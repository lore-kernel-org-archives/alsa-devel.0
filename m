From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Callback after a specified number of samples
Date: Mon, 30 Sep 2002 20:27:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209302023570.503-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.21.0209301754340.25497-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0209301754340.25497-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: Wolfgang Hesseler <wolf1122@gmx.net>, Paul Davis <pbd@op.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Sep 2002, tomasz motylewski wrote:

> I do the following: knowing the sample rate and the current position of the HW
> pointer (via snd_pcm_avail_update - why there is no function which would tell
> me directly that - the current position in the buffer?) I can calculate when
> the required position _will_ happen. So  I can just schedule the timer or sleep
> until that time. When it arrives I can check again snd_pcm_avail_update to see
> whether my calculation way correct and adjust the sleep period.
> 
> I do not understand why ALSA drivers (or at least some plug-ins) could not do
> the same?

What same? Offer position in ring buffer?

> There is also another problem: I understand that snd_pcm_avail_update does not
> really read current count from the card, but uses a value stored in memory. So
> it will only be updated when the card generates an interrupt. Is there any way
> to force snd_pcm_avail_update or to use another function which will for sure
> query the HW and not use the cached value? If the card does not have a
> capability to report it, this could be extrapolated from the last time sample
> counter was updated and the current time.

Use snd_pcm_status() to get the accurate timing information. The 
avail_update function is light version which does not need a context 
switch between user and kernel space.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
