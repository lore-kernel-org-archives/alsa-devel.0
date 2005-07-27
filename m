From: "Alfredo" <alfredo@vida-software.com>
Subject: RE: Little question about ALSA callbacks
Date: Wed, 27 Jul 2005 13:21:08 +0200
Message-ID: <e12dfbe9dfb85344939f51e03daf6a04@vida-software.com>
References: <s5hhdeglgvh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdeglgvh.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Thank you very much for your suggestions Takashi.
	

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: mi=E9rcoles, 27 de julio de 2005 10:48
To: Alfredo
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Little question about ALSA callbacks

At Wed, 27 Jul 2005 11:28:26 +0200,
Alfredo wrote:
> 
> Hello, I have read the article =1B$B!H=1B(BIntroduction to Sound
Programming with ALSA from Linux
> Journal. This article explains:
> 
> // Starts here:
>
------------------------------------------------------------------------
-------------------------------------------
> 
> =1B$B!H=1B(BIn the previous examples, the PCM streams were operating in
blocking mode, that is,
> the calls would not return until the data had been transferred. In an
interactive
> event-driven application, this situation could lock up the application
for
> unacceptably long periods of time. ALSA allows opening a stream in
nonblocking mode
> where the read and write functions return immediately. If data
transfers are pending
> and the calls cannot be processed, ALSA returns an error code of
EBUSY.
> 
> Many graphical applications use callbacks to handle events. ALSA
supports opening a
> PCM stream in asynchronous mode. This allows registering a callback
function to be
> called when a period of sample data has been transferred.=1B$B!H=1B(B
> 
> // Finishes here:
>
------------------------------------------------------------------------
-------
> 
> I=1B.F=1BN"m developing an event driven Linux server that will use ALSA
library. Please, could
> you point me to some resources in order to learn how to use alsa in
asynchronous mode
> (the event driven mechanism will be based in poll()).
> 
> Clemens Ladisch helped me suggesting that I must use poll to wait for
events in
> different file descriptors. I need to be notified when audio buffer
has been recorded.
> I need to learn how to use ALSA in conjunction with poll.

The async mode described above uses a signal instead of poll, so this
is not a recommended way although it seems working on most of
architectures.  Using poll is better.

If your app is a graphical one or do a heavy job (e.g. encoding)
together with a sound engine, you'll likely need a dedicated audio
thread for stability.  In that case, consdering to use JACK would be a
good idea, too...


Takashi





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
