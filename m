From: "M R Swami Reddy" <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH v2] ASoC: Add support for TI LM49453 Audio
	codec
Date: Mon, 06 Feb 2012 16:00:23 +0530
Message-ID: <4F2FABBF.7010604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw05.nsc.com (mail2.nsc.com [12.238.8.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 2898C243A9
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 11:30:39 +0100 (CET)
Received: from SCNTRDCSS6.nsc.com (scntrdcss6.nsc.com [10.188.130.177])
	by sc-mailgw05.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	2F3F910D511E
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 02:30:30 -0800 (PST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown Wrote:
 > > ---
 > > Changes made in V2
 > > o Removed fll and vco reference frequency settings from _set_dai_pll()
 > > o Reworked chip enable and disable in _STANDBY and _OFF modes in
 > > m49453_set_bias_level, as per the review comments.

 >You say this is version 2 but there's been rather more than two versions
 > posted...

Thats right. I started numbering the patch version with previous one, so 
mentioned it as v2. The version number will be continued.


 > > +static int lm49453_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 > > +                              int source, unsigned int freq_in,
 > > +                              unsigned int freq_out) {

 >This is now a bit odd.

I will update it as per the other drivers formate.


 > > +       state->in = freq_in;
 > > +       state->out = freq_out;

 >It stores but otherwise ignores the configuration which was passed in (which
 > seems more than a little odd).

Will be removed in the next patch.


 > > +       /* Always disable the PLL - it is not safe to leave it running
 > > +        * while reprogramming it.
 > > +        */
 > > +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
 > > +                           LM49453_PMC_SETUP_PLL_EN, 0);
 > > +
 > > +       if (!freq_in || !freq_out)
 > > +               return 0;
 > > +
 > > +
 > > +       /* All done, turn it on */
 > > +       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, pwr_mask,
 > > +                           pwr_mask);

 >Then if the PLL was already enabled it bounces the power briefly.
 >Really it seems like this should just be merged in with set_sysclk() - you're
 >not actually configuring the PLL at all, just turning it on and off, at which 
 >point it's just another SYSCLK source.


Ok. The PLL disable code will be removed and the PLL enable code will be moved 
to _sysclk().

 >Otherwise this seems good, just this clock configuration stuff to sort out.

OK. Thank you. Do I need to resend the patch.

Thanks
Swami
