From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Unexpected hw_pointer value
Date: Sun, 5 Oct 2003 16:26:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031005162648.1e15ace5.pochini@shiny.it>
References: <20031004211200.GA13137@zeus.homenet>
	<20031004215812.GI2972@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031004215812.GI2972@dbz.icequake.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 4 Oct 2003 16:58:12 -0500
Ryan Underwood <nemesis-lists@icequake.net> wrote:

> > i have an ES1983S Maestro-3i on a c600 dell laptop
> > i got this message in syslog :
> >
> > ALSA sound/core/pcm_lib.c:214: Unexpected hw_pointer value (stream = 0,
> > delta: -944, max jitter = 1024): wrong interrupt acknowledge?
>
> I get a lot of these as well with the in-development Aureal driver.

Me too, with the Echoaudio driver. I had quick look at the code that prints
that warning and I couldn't see anything obviously wrong. btw I can't figure
out why it happens. It seems harmless, so I left the question on hold.

> I'm also curious as to what they mean.  (I seem to be the only person having
> the problem).  They mostly occur while playing music in xmms with xmms
> alsa plugin.  They fill up syslog with hundreds of megabytes. :)

It happens with any program and it depends a lot on the period number and
period size settings.


--
Giuliano.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
