From: Frank Barknecht <fbar@footils.org>
Subject: Re: Quattro woes or: What does "SNDRV_PCM_IOCTL_START failed" mean?
Date: Tue, 11 Mar 2003 11:32:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030311103209.GA4139@fliwatut.scifi>
References: <20030310223321.GA10836@fliwatut.scifi> <s5hwuj62pbv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hwuj62pbv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Takashi Iwai hat gesagt: // Takashi Iwai wrote:

> At Mon, 10 Mar 2003 23:33:22 +0100,
> Frank Barknecht wrote:
> > ALSA lib pcm_hw:454(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
> > Broken pipe
> 
> do you see any kernel message?
> if the start fails in the pcm trigger callback, usb-audio driver
> should show some error message there.

No, there only are the usual (de-)registering messages regarding
snd-usb-audio. The only difference between my notebook and the laptop
has been the kernel-version. Just 5 minutes ago I downgraded the
notebook's kernel to 2.4.18 and now the error message went away! I'm
currently still getting a lot of clicks, that probrably are caused by
some wrong period settings in my application, but in general it is
fine. For example "jackd -d alsa -d hw:0 -n 2" clicks, but "-n 3" is
smooth.

I was using the Debian kernel 2.4.20 and also the Debian package of
ALSA.  I remember now, that the Debian maintainers send a bunch of
USB-audio related patches. Maybe it's just Debian, that is broken??

Anyway, I can live with 2.4.18 for now, thank you for the help. Now on
to ALSA 1.0 ;)

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
