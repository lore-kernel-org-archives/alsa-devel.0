From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v2 4/4] ASoC: tegra: Harmony: Support the
 internal speaker
Date: Tue, 25 Jan 2011 19:46:57 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310955FA7@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295470205-26501-5-git-send-email-swarren@nvidia.com>
	<20110125202953.GB4605@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id D455F24371
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 04:47:14 +0100 (CET)
In-Reply-To: <20110125202953.GB4605@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote on Tuesday, January 25, 2011 1:30 PM:
> 
> On Wed, Jan 19, 2011 at 01:50:05PM -0700, Stephen Warren wrote:
> 
> > -static int __init harmony_soc_modinit(void)
> > +static __devinit int tegra_snd_harmony_probe(struct platform_device
> *pdev)
> 
> Unrelated change...

Yeah, I guess I should separate the device probing rework into a separate
patch.

> ...
> With the recently added exposure of snd_soc_register_card() you *should*
> just be able allocate a regular platform device with a regular name in
> your arch/arm code and then register that directly with the ASoC core -
> something like:
> 
> int __devinit harmony_audio_probe(struct platform_device *pdev)
> {
> 	/* Do GPIO stuff */
> 
> 	card->dev = &pdev->dev;
> 	snd_soc_register_card(&snd_soc_harmony);
> 
> 	/* Error handling */
> }
> 
> ought to do the trick, and is much neater and more idiomatic than the
> soc-audio stuff.

With the existing soc-audio structure, one has to:

	platform_set_drvdata(harmony_snd_device, &snd_soc_harmony);

I assume there's no need for this when registering via snd_soc_register_card;
In other words, I'm free to use dev_set_drvdata on the platform_device/device
so I can get rid of all the globals in harmony.y while I'm at it?

I do see some internal use of set_drvdata/get_drvdata in soc-core.c. It
looks like that's restricted to when the soc-audio platform_device is used,
but I don't know if that's just co-incidence, or if it's a guarantee of the
API. Can you confirm this?

Thanks.

--
nvpublic
