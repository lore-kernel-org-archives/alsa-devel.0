From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Sound: MSM soc : imported alsa for the MSM
 from codeaurora
Date: Mon, 9 Nov 2009 09:42:05 +0100
Message-ID: <20091109084205.GC4818@elf.ucw.cz>
References: <1257435101.25623.1.camel@localhost>
	<1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C9D9B1038E7
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 09:42:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

> I had to make two little change to make it compile:
> snd_ep = msm_rpc_connect_compatible(snd_rpc_ids.prog,
> became:
> snd_ep = msm_rpc_connect(snd_rpc_ids.prog,
> and I also changed snd_rpc_ids.vers(with ifdefs)
> to a known and working magick number:
> 
> I also had to change from ARCH_MSM_ARM11 to ARCH_MSM in the configuration

Thanks for pointer.

> it still has serious runtime problems such as:
> *Can produce kernel oops under theses conditions:
>  start alsamixer and if the second bar is on 0 or 4,
>  so it can play music with aplay,then increase the routing alsamixer bar
>  to the max.
>  Then decrease the routing bar to 4 or less
>  Then It may have a null pointer problem
>  That bug could be because it tries to route to route to speakers and
>  handset at the same time(SND_DEVICE_HEADSET_AND_SPEAKER in android):
>  that is to say it could be the same bug than here:
> http://gitorious.org/replicant/msm7k/commit/370d37a088368ca8cc478e76c928a1ce6589495e
>  but I need time to verify that
> *can pannick(reboots the phone) if you send things to /dev/dsp when the
>  oss emulation is activated
> *only aplay works(mplayer,gstreamer don't work) for mplayer an ioctl
>  didn't return...so it get stuck before playing.
>  The explanation of the bug can be found here:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/022697.html

Perhaps it should go to staging?

> Note the following things:
> *this patch depends on,and doesn't contain arch/arm/mach-msm/qdsp5
> *I removed the support for more recents chips because of code-size issue
>  in a mailing list

I had qdsp5 support in staging tree, check 2.6.31. It is not there
_now_ but I hope to reinstall it.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
