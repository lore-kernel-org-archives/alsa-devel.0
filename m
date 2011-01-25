From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/4] ASoC: tegra: Harmony: Support the
 internal speaker
Date: Tue, 25 Jan 2011 20:29:53 +0000
Message-ID: <20110125202953.GB4605@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295470205-26501-5-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD9AC244D8
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 21:29:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295470205-26501-5-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 01:50:05PM -0700, Stephen Warren wrote:

> -static int __init harmony_soc_modinit(void)
> +static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)

Unrelated change...

> -	if (!machine_is_harmony()) {
> -		pr_err(PREFIX "Not running on Tegra Harmony!\n");
> -		return -ENODEV;
> +	if (pdev->id != 0) {
> +		dev_err(&pdev->dev, "ID %d out of range\n", pdev->id);
> +		return -EINVAL;
> +	}
> +
> +	pdata = pdev->dev.platform_data;
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "no platform data supplied\n");
> +		return -EINVAL;

Unless you have more than one sound card your device ID should be -1.
I'd also be inclined to keep the machine_is_harmony() check here for
paranoia.

With the recently added exposure of snd_soc_register_card() you *should*
just be able allocate a regular platform device with a regular name in
your arch/arm code and then register that directly with the ASoC core -
something like:

int __devinit harmony_audio_probe(struct platform_device *pdev)
{
	/* Do GPIO stuff */

	card->dev = &pdev->dev;
	snd_soc_register_card(&snd_soc_harmony);

	/* Error handling */
}

ought to do the trick, and is much neater and more idiomatic than the
soc-audio stuff. 
