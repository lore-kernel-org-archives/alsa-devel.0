From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Mon, 6 Dec 2010 22:43:59 +0000
Message-ID: <20101206224359.GB2862@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 095BB1037FF
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:43:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 04:34:37PM -0600, Olaya, Margarita wrote:

> In some cases it was not possible to follow the appropiate power
> ON/OFF sequence.
> Add a widget to support speaker drivers where power ON/OFF
> ordering is important.

Why not use the existing speaker widget?  It's at pretty much the same
point in the sequence and is intended for use with external GPIO
controlled speaker drivers.  It'd be good to discuss this in the
changelog.

> +#define SND_SOC_DAPM_DRV(wname, wreg, wshift, winvert,\
> +	 wcontrols, wncontrols) \
> +{	.id = snd_soc_dapm_drv, .name = wname, .reg = wreg, .shift = wshift, \
> +	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}

The _DRV name seems rather opaque - I'd suggest _SPK as a name but
obviously that's in use.  If we do want this I guess _SPK_DRV or
sommething.
