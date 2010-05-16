From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 4/6] cs42l51: add asoc driver
Date: Sun, 16 May 2010 18:27:34 +0100
Message-ID: <20100516172730.GB9830@opensource.wolfsonmicro.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.666637769@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100515153130.666637769@mandriva.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, May 15, 2010 at 05:30:02PM +0200, apatard@mandriva.com wrote:
> This patch is adding a ASoC driver for the cs42l51 from Cirrus Logic.
> Master mode and spi mode are not supported.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

This seems basically OK but there are a few things of varying severity
to fix below.  The main one is the namespacing of the constants in the
header file.

> +	/* route microphone */
> +	ret = snd_soc_write(codec, ADC_INPUT, 0xF0);
> +	if (ret < 0)
> +		goto error_alloc;

This really should be either chip default or user visible, but hopefully
when explicit control gets added users will be able to work out which
non-default value they were using so it'll be OK.

> +static const char *mic_boost[] = { "+16dB", "+32dB"};

> +	SOC_ENUM("Mic Boost", cs42l51_mic_boost),

This really should be a SOC_SINGLE_TLV() - that will mean that userspace
software like Pulse that tries to automate gain control over the full
path can include the gain from the boost amplifier.

> +static const char *cs42l51_dac_names[] = {"PCM->DAC",
> +	"PCM->SPE->DAC", "ADC->DAC"};

Conventionally these would have different names - something like "Direct
PCM", "DSP PCM" and "ADC" - since it looks a little nicer in the UI of
apps but it doesn't really matter since these are only ever likely to be
seen by people configuring systems and not end users.

> +#define DAPM_EVENT_PRE_POST_PMD	(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)

This really ought to get pushed into the main DAPM header file if it's
going to stick, though I'd be surprised to see other users so it's not
terribly urgent.

> +	if (!rates) {
> +		printk(KERN_ERR "cs42l51: could not find a valid sample rate\n");
> +		return -EINVAL;
> +	}

You could use dev_() printks based on codec->dev or dai->dev.

> +	dev_info(&pdev->dev, "CS42L51 ALSA SoC Codec\n");

Not a big fan of chatty boots but it's no big deal.

> +#define CHIP_ID			0x1B
> +#define CHIP_REV_A		0x00
> +#define CHIP_REV_B		0x01

The macros in the header file should all be namespaced - they're likely
to collide with other things when the header is included in machine
drivers (eg, the registers for the CODEC).  Some of them are moderately
safe but things like these ones seem likely to run into trouble and it'd
be better to be consistent.
