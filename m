From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Wed, 25 Nov 2009 16:20:52 +0100
Message-ID: <20091125152052.GM29442@buzzloop.caiaq.de>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 338AA2439C
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 16:20:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091125150139.GC636@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 03:01:39PM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 03:36:27PM +0100, Daniel Mack wrote:
> 
> >  static int cs4270_dai_mute(struct snd_soc_dai *dai, int mute)
> >  {
> >  	struct snd_soc_codec *codec = dai->codec;
> >  	struct cs4270_private *cs4270 = codec->private_data;
> > -	int reg6;
> > +	int reg6, err;
> >  
> >  	reg6 = snd_soc_read(codec, CS4270_MUTE);
> >  
> >  	if (mute)
> >  		reg6 |= CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B;
> >  	else {
> > +		if (cs4270->va_reg)
> > +			regulator_enable(cs4270->va_reg);
> > +
> 
> This looks wrong - why is the power being controlled in the mute
> function?  If nothing else this is going to break recording since the
> CODEC will only be unmuted during playback which means power will be cut
> during record.

Ok - which place would you suggest for it? Is there an ASoC callback I
can hook on to tell me when the whole codec isn't used anymore? I can
only see startup/shutdown, but I would need to my own snd_pc_substream
handling login in there. Other drivers do that in the probe/remove
functions, but that won't suffice for my board as we want VA disabled
whenever possible.

Daniel
