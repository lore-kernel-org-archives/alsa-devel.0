From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [ALSA] mpc8610: Add mmap support
Date: Thu, 17 Jan 2008 10:31:37 -0600
Message-ID: <478F82E9.1050809@freescale.com>
References: <12005823754197-git-send-email-timur@freescale.com>
	<478F8129.5030408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D1242444B
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 17:32:59 +0100 (CET)
In-Reply-To: <478F8129.5030408@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> Timur Tabi wrote:
>> Enable mmap support in the MPC8610 ASoC driver.  The driver can use 
>> ALSA's
>> default mmap functionality, it was just not enabled previously.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> [sorry, I may be completely wrong below about the .page callback purpose 
> - in this case, just confirm that the testcase works]
> 
> Hm, the "struct snd_pcm_ops fsl_dma_ops" doesn't contain the .page 
> callback. With saa7134-alsa, this led to the "device claims to support 
> mmap but actually doesn't work" bug, see the following subthread:

Isn't that an ARM chip?  The default MMAP handler in ALSA doesn't support ARM, 
but it works for PowerPC.

> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-October/003773.html 
> 
> 
> IOW: have you actually tested that the following commands work (X,Y 
> refer to the FSL chip)?
> 
> aplay -M -D hw:X,Y sample.wav
> arecord -f cd -M -D:X,Y capture.wav

I haven't tried record, but I did try playback, and it worked.  Without this 
patch, adding -M gives me this error:

aplay: set_params:852: Access type not available

After applying this patch, playback works fine.

-- 
Timur Tabi
Linux kernel developer at Freescale
