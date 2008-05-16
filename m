From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Kernel crashes for unsupported sample rates
Date: Fri, 16 May 2008 17:16:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02225E739A@dbde02.ent.ti.com>
References: <s5htzgzrafp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 17AB224996
	for <alsa-devel@alsa-project.org>;
	Fri, 16 May 2008 13:46:52 +0200 (CEST)
In-Reply-To: <s5htzgzrafp.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have tried to apply the patch manually but I couldn't because I am on kernel version 2.6.22.1.

Is the patch available for my kernel version? How should I go about it?

One observation I had was when I removed "SNDRV_PCM_INFO_MMAP" from the "pcm_hardware_playback", the kernel stopped crashing. It gave me some error and returned.

[root@OMAP3EVM bin]# [root@OMAP3EVM bin]# ./pcm -f cd -r 1000
Playback device is plughw:0,0
Stream parameters are 4000Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to find an usable access for 'plughw:0,0'
Rate 4000Hz not available for playback: Invalid argument
Setting of hwparams failed: Invalid argument

Thanks and Regards,
Anuj Aggarwal

Platform Support Products
Texas Instruments Inc
Ph: +91-80-2509-9542
TI IP Ph: 509-9542
PSP Products RSS Feed PSP Product Announcements


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Thursday, May 15, 2008 6:28 PM
To: Aggarwal, Anuj
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Kernel crashes for unsupported sample rates

At Thu, 15 May 2008 18:09:21 +0530,
Aggarwal, Anuj wrote:
>
> Can you point me to any particular git tree which I can download and apply the patches directly, instead of committing any silly mistake? It would be really helpful.

You can try my experimental tree:
    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git


Takashi
