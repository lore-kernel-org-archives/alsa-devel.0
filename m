From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: imx-spdif: Use module_init() to
 handle platform_device_register()
Date: Tue, 17 Dec 2013 18:31:05 +0800
Message-ID: <20131217103049.GA3043@MrMyself>
References: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131216194717.GO3185@sirena.org.uk>
 <20131216211958.GS4360@n2100.arm.linux.org.uk>
 <20131216221710.GH3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 86FC22608B8
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 11:44:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131216221710.GH3185@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 16, 2013 at 10:17:10PM +0000, Mark Brown wrote:
> I don't see registering the DAIs directly as adding complexity here;
> it's essentially what the current code is trying to do and doesn't
> change the normal device registration flow at all.  I do agree that the

Sir, I just tried to register the CODEC DAI in machine driver and it
works perfectly for module-loading. But when unloading it....
[...]
root@freescale ~$ modprobe snd-soc-imx-spdif
imx-spdif sound-spdif.10: S/PDIF-RX <-> 2004000.spdif mapping ok
root@freescale ~$ lsmod
Module                  Size  Used by
snd_soc_imx_spdif       3207  1
snd_soc_fsl_spdif       9604  2
imx_pcm_dma             1140  1 snd_soc_fsl_spdif
imx_sdma               10781  0 [permanent]
root@freescale ~$ rmmod snd-soc-imx-spdif
rmmod: can't unload 'snd_soc_imx_spdif': Resource temporarily unavailable
[...]
It looks like registering the CODEC DAI to the pdev->dev of machine driver
wasn't a good idea since it would lock itself up.

Then I also tried to register it to the pdev->dev of CPU DAI driver --
fsl-spdif, which is also the platform driver. The result is that there's
nothing wrong with module loading/unloading except one failure:
[...]
root@freescale ~$ rmmod snd-soc-imx-spdif
root@freescale ~$ modprobe snd-soc-imx-spdif
debugfs: creating file 'imx-spdif'
debugfs: creating file 'dapm_pop_time'
debugfs: creating file 'dapm'
debugfs: creating file 'bias_level'
debugfs: creating file '2004000.spdif'
debugfs: creating file 'cache_sync'
debugfs: creating file 'cache_only'
debugfs: creating file 'codec_reg'
debugfs: creating file 'dapm'
debugfs: creating file 'bias_level'
debugfs: creating file '2004000.spdif'
fsl-spdif-dai 2004000.spdif: ASoC: Failed to create platform debugfs directory
imx-spdif sound-spdif.10: S/PDIF-RX <-> 2004000.spdif mapping ok
debugfs: creating file 'Capture'
debugfs: creating file 'spdif-in'
[...]
It should be caused by the naming conflict since they are two exact same
names.

Although I'll continue finding another way to register it tomorrow, I think
it's better to make a simple report for this solution.

And if you have any idea, please guide me.

Thank you,
Nicolin Chen
