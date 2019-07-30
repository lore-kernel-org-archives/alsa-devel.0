From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Date: Tue, 30 Jul 2019 15:18:22 +0100
Message-ID: <20190730141822.GI54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730124158.GH54126@ediswmail.ad.cirrus.com>
 <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37B57F800BF
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 16:18:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Marco Felsch <m.felsch@pengutronix.de>, Annaliese McDermond <nh6z@nh6z.net>, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 03:04:19PM +0100, Thomas Preston wrote:
> On 30/07/2019 13:41, Charles Keepax wrote:
> >> +static int tda7802_bulk_update(struct regmap *map, struct reg_update *update,
> >> +		size_t update_count)
> >> +{
> >> +	int i, err;
> >> +
> >> +	for (i = 0; i < update_count; i++) {
> >> +		err = regmap_update_bits(map, update[i].reg, update[i].mask,
> >> +				update[i].val);
> >> +		if (err < 0)
> >> +			return err;
> >> +	}
> >> +
> >> +	return i;
> >> +}
> > 
> > This could probably be removed using regmap_multi_reg_write.
> > 
> 
> The problem is that I want to retain the state of the other bits in those
> registers. Maybe I should make a copy of the backed up state, set the bits
> I want to off-device, then either:
> 
> 1. Write the changes with regmap_multi_reg_write
> 2. Write all six regs again (if my device doesn't support the multi_reg)
> 

Nah sorry my bad you are probably better off they way you are.

Thanks,
Charles
