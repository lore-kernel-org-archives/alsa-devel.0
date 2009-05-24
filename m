From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2 1/9] Register the wm9712 DAIs on module
	load
Date: Sun, 24 May 2009 11:28:15 -0400
Message-ID: <9e4733910905240828q4b4cfd96xe840f3ae983143dc@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231257.17919.4483.stgit@terra>
	<20090524111118.GC4933@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 76D2424495
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 17:28:16 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1530341qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 08:28:15 -0700 (PDT)
In-Reply-To: <20090524111118.GC4933@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 24, 2009 at 7:11 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, May 23, 2009 at 07:12:57PM -0400, Jon Smirl wrote:
>> Register the wm9712 DAIs on module load
>
>> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> Why do you wish to do this - ASoC does not require or use DAI registration
> for AC97 CODECs?
>

Then what is wrong with my binding code? If I take out the
registration my bind fails.

static struct snd_soc_dai_link pcm030_fabric_dai[] = {
{
	.name = "AC97",
	.stream_name = "AC97 Analog",
	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_NORMAL],
},
{
	.name = "AC97",
	.stream_name = "AC97 IEC958",
	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
	.cpu_dai = &psc_ac97_dai[MPC5200_AC97_SPDIF],
},
};

static __init int pcm030_fabric_init(void)
{
	struct platform_device *pdev;
	int rc;

	if (!machine_is_compatible("phytec,pcm030"))
		return -ENODEV;

	card.platform = &mpc5200_audio_dma_platform;
	card.name = "pcm030";
	card.dai_link = pcm030_fabric_dai;
	card.num_links = ARRAY_SIZE(pcm030_fabric_dai);

	device.card = &card;
	device.codec_dev = &soc_codec_dev_wm9712;

	pdev = platform_device_alloc("soc-audio", 1);
	if (!pdev) {
		pr_err("pcm030_fabric_init: platform_device_alloc() failed\n");
		return -ENODEV;
	}

	platform_set_drvdata(pdev, &device);
	device.dev = &pdev->dev;

	rc = platform_device_add(pdev);
	if (rc) {
		pr_err("pcm030_fabric_init: platform_device_add() failed\n");
		return -ENODEV;
	}
	return 0;
}


Advanced Linux Sound Architecture Driver Version 1.0.19.
No device for DAI stac9766 analog
No device for DAI stac9766 IEC958
No device for DAI tas5504
irq: irq 129 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 129
irq: irq 194 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 194
irq: irq 195 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 195
mpc5200-psc-ac97 f0002000.ac97: Codec ID is 574d 4c12
ALSA device list:
  No soundcards found.





-- 
Jon Smirl
jonsmirl@gmail.com
