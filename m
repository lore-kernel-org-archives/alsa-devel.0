From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: How to lock the sample rate ?
Date: Mon, 08 Mar 2004 10:34:37 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040308103437.pochini@shiny.it>
References: <20040306140542.GM25734@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040306140542.GM25734@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 06-Mar-2004 Adam Tla/lka wrote:

>> > On the Echoaudio cards the sample rate is a global setting, so I need a way
>> > to prevent an app to change the rate if someone else already set it (the
>> > card han several devices/subdevices). I was thinking to put a simple
>> > "if (IsAudioOpen()) rate_min=rate_max=current_rate;" in pcm_open callback,
>> > but this solution is racy.

> Talking about race conditions you could use a variable which is set to 0
> at the beginning. Now if app wants to set a rate it does atomic compare
> and increase (cmpxchg on  x86) instruction so only one app could set
> rate. The other could only read memorized rate settins and report an
> error if rate is different.

No, I wasn't clear enough.
If I add the "if (IsAudioOpen())..." in the pcm_open() function it
works as long as the firts applications which set the sample rate
don't changes it again. Furthermore, noone, but the firt app, can
change the sample rate until all substream are closed. But there is
another case where the above method fails. Let's suppose there are
two application, A and B. They both do pcm_open(). Since nobody
has set the sample rate yet, the driver says that all sample rates
in the range 8k-96k can be choosed (the driver set hw constraints
in the open callback). Then A sets 44100. But B still believes it
can do 8-96 and it sets 48000. Everything goes fine until B tries
to start the substream (that is the prepare() callback is called).
At this point there are two possibilites: 1) The call fails and the
application can't know why. 2) The call succeeds and it changes
the sample rate of all running substreams.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
