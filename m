From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: trouble with dosemu and alsa oss emulation (and a fix for alsa)
Date: Sat, 6 Sep 2003 16:56:03 -0500
Sender: linux-msdos-owner@vger.kernel.org
Message-ID: <20030906215602.GV21868@dbz.icequake.net>
References: <20030906200943.GA5128@quark.fsb.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-msdos-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20030906200943.GA5128@quark.fsb.hr>
To: alsa-devel@lists.sourceforge.net, linux-msdos@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Hi,

On Sat, Sep 06, 2003 at 10:09:43PM +0200, Vedran Rodic wrote:
> Hi. 
> 
> I'm having trouble with latest ALSA and oss emulation. I'm using dosemu to
> play some DOS games and I've noticed that sound in DOS apps stops playing 
> after short time (depending on the app). 
> 
> 
> I'm regulary updating both alsa and dosemu, I suspected dosemu first, since
> I had no problems whatsoever with alsa oss emulation. 
> 
> It turned out that this was not dosemu problem, but alsa oss emulation problem.
> I've tracked it down to a change in  alsa-kernel/core/oss/pcm_oss.c. 
> The change is here:
> http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/alsa/alsa-kernel/core/oss/pcm_oss.c.diff?r1=1.40&r2=1.41
> 
> I'm currently using the latest pcm_oss.c but without this patch and it
> works great again. 
> 
> I think that dosemu code - src/arch/linux/dosext/sound/linux_sound.c is
> correct. 

Yeah, I know I tried dosemu with the ALSA OSS emulation before, and it
worked mostly correct (surprisingly enough!).  I'm glad you spotted this
regression, it might have gone overlooked for some time otherwise.

DOSEMU really needs the native ALSA sound output... one of these days ;)

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
