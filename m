From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2] ASoC: rt286: add jack detection
 enable/disable APIs and export
Date: Thu, 5 Feb 2015 02:07:35 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BA9CB6@SHSMSX101.ccr.corp.intel.com>
References: <1423056843-26490-1-git-send-email-yang.jie@intel.com>
 <20150204202604.GF21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D03322606A7
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 03:07:48 +0100 (CET)
In-Reply-To: <20150204202604.GF21293@sirena.org.uk>
Content-Language: en-US
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
Cc: "bardliao@realtek.com" <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, February 05, 2015 4:26 AM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org; bardliao@realtek.com; Girdwood, Liam R
> Subject: Re: [PATCH v2] ASoC: rt286: add jack detection enable/disable APIs and
> export
> 
> On Wed, Feb 04, 2015 at 09:34:03PM +0800, Jie Yang wrote:
> 
> > +int rt286_disable_jack_detection(struct snd_soc_codec *codec) {
> > +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	disable_irq(rt286->i2c->irq);
> > +
> > +	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "LDO1");
> > +	snd_soc_dapm_sync(&rt286->codec->dapm);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(rt286_disable_jack_detection);
> 
> So, now I look at this again I'm wondering why this isn't writing to any registers
> - looking at the code we run on probe there's a register write if we're passed an
> interrupt which looks awfully like we're enabling jack detect.  Probably we
> wouldn't need to do the rather odd disabling of the IRQ if we did that, but
> perhaps it's required.
[Keyon] yes, it's required to disable jack detection, otherwise, pin LDO1 will be force enabled again. So here I just disable the IRQ to make the code change smallest.

> 
> I think there's actually problems with the existing jack detection code in the
> driver, I'd expect that the initial enabling of jack detect would be done when the
> machine driver says it wants jack detect by passing in the jack to report for.
[Keyon] I agree that it may be more reasonable if we can pass jack(similar to rt286_mic_detect(), can use jack=NULL for disable) from this machine driver, then add checking this jack in handler rt286_irq(), don't call rt286_jack_detect() and snd_soc_jack_report() when the jack is NULL.
What do you think about this solution?
