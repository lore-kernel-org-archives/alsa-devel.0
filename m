From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_params_free() immediately after
	snd_pcm_hw_params() ???
Date: Sun, 24 Jan 2010 11:30:04 +0800
Message-ID: <4f3252891001231930j55aff4ccme3b3b40323b8cee0@mail.gmail.com>
References: <4B582A0A.8030603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 29A3810380F
	for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2010 04:30:07 +0100 (CET)
Received: by pxi3 with SMTP id 3so1699636pxi.16
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 19:30:07 -0800 (PST)
In-Reply-To: <4B582A0A.8030603@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/1/21 Clemens Ladisch <clemens@ladisch.de>

> Raymond Yau wrote:
> > Is there any flags in substream which can indicate snd_xxx_hw_params()
> was
> > called at first time since snd_xxx_hw_params() were called many times
> > during OSS emulation (probing the supported rates , channels , .... ) ?
>
> There is no such flag.  It is the responsibility of the driver to track
> the resources it has allocated.
>
> If a resource does not depend on the hardware parameters, it might be
> a better idea to allocate/free it in the open/close callbacks.
>
>
> Best regards,
> Clemens
>

https://bugzilla.redhat.com/show_bug.cgi?id=497739

Apr 26 11:20:11 localhost kernel: vortex_adb_addroutes: unending route! 0x40
Apr 26 11:20:11 localhost kernel: vortex_adb_addroutes: unending route! 0x2060
Apr 26 11:20:11 localhost kernel: vortex_adb_addroutes: unending route! 0x3641
Apr 26 11:20:11 localhost kernel: vortex_adb_addroutes: unending route! 0x2101
Apr 26 11:20:11 localhost kernel: vortex_adb_delroutes: route not found! 0x3641
Apr 26 11:20:11 localhost kernel: vortex_adb_delroutes: route not found! 0x2101
Apr 26 11:20:11 localhost kernel: mix ALARM 0
Apr 26 11:20:11 localhost kernel: vortex_adb_delroutes: route not found! 0x3593
Apr 26 11:20:11 localhost kernel: mix ALARM 0
Apr 26 11:20:11 localhost kernel: Vortex: vortex_fifo_setadbctrl fail
Apr 26 11:20:11 localhost kernel: vortex_adb_addroutes: unending route! 0x3642
Apr 26 11:20:11 localhost kernel: vortex_adb_addroutes: unending route! 0x3743
Apr 26 11:20:11 localhost kernel: vortex_adb_addroutes: unending route! 0x2201
Apr 26 11:20:11 localhost kernel: Vortex: vortex_fifo_setadbctrl fail


did the suspend/resume cycle call snd_xxx_hw_params() or snd_xxx_hw_free()
when the driver did not support suspend/resume ?
