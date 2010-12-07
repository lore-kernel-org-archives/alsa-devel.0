From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Tue, 7 Dec 2010 14:13:39 +0000
Message-ID: <20101207141338.GY4698@rakim.wolfsonmicro.main>
References: <20101206224359.GB2862@opensource.wolfsonmicro.com>
	<1291676132.3281.116.camel@odin>
	<20101206230948.GH2862@opensource.wolfsonmicro.com>
	<1291678207.3281.152.camel@odin>
	<8C6859A9-36EF-4016-822B-DA67D7147E28@opensource.wolfsonmicro.com>
	<1291725285.3275.14.camel@odin>
	<20101207123600.GD4698@rakim.wolfsonmicro.main>
	<1291725988.3275.22.camel@odin>
	<20101207130914.GF4698@rakim.wolfsonmicro.main>
	<1291730484.3275.54.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3AFD1103A8C
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 15:13:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291730484.3275.54.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 07, 2010 at 02:01:24PM +0000, Liam Girdwood wrote:
> On Tue, 2010-12-07 at 13:09 +0000, Mark Brown wrote:

> > You can say that for pretty much all of the widgets, though, including
> > the existing speaker and headphone widgets.  

> You can only really say for the last widget in the sequence.

Pretty much anything might be the last widget in the chain, and
obviously you can need to do stuff like this within the CODEC as well as
the machine (after all that's exactly what this is about).

For full flexibility we need something like optional sorting within each
widget type.

> @@ -61,6 +61,7 @@ static int dapm_up_seq[] = {
>         [snd_soc_dapm_mixer] = 7,
>         [snd_soc_dapm_mixer_named_ctl] = 7,
>         [snd_soc_dapm_pga] = 8,
> +       [snd_soc_dapm_drv] = 9,
>         [snd_soc_dapm_adc] = 9,
>         [snd_soc_dapm_hp] = 10,
>         [snd_soc_dapm_spk] = 10,

> This patch shares the ADC sequence number for the DRV on the power ON.

This isn't entirely great for digital bypass paths (the current setup
isn't ideal either but that's a separate issue and harder to fix as you
can get PGAs on both input and output paths).  You'll power up your
output driver and only then start feeding through samples from the ADC,
meaning a sudden introduction of any DC offset in the analogue input
that the ADC is passing through rather than getting the benefit of any
soft start or DC offset correction the hardware does.  I'd rather see us
ading the new widget at step 10, either with the existing speaker and
headphone driver widgets or moving them up a step.

> and inserts a new number as you suggested for power OFF. Imo, nothing
> wrong with this approach and since I don't have all day to discuss, Magi
> will change both the sequence numbers to use the same number as
> snd_soc_dapm_spk.

Right, the down sequence is fine.
