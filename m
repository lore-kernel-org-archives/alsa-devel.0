From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: wm5110: Add additional analogue
 input enable for early revs
Date: Thu, 17 Sep 2015 09:10:07 +0100
Message-ID: <20150917081007.GA7694@ck-lbox>
References: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1442408383-31682-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150916200159.GV12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D3AAA265161
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 10:33:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150916200159.GV12027@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 16, 2015 at 09:02:00PM +0100, Mark Brown wrote:
> On Wed, Sep 16, 2015 at 01:59:43PM +0100, Charles Keepax wrote:
> 
> > +static int wm5110_in_pga_get(struct snd_kcontrol *kcontrol,
> > +			     struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> > +	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> > +	struct snd_soc_card *card = dapm->card;
> > +	int ret;
> > +
> > +	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
> > +
> > +	ret = snd_soc_get_volsw_range(kcontrol, ucontrol);
> > +
> > +	mutex_unlock(&card->dapm_mutex);
> 
> Can we please have a comment explaining why we need the lock (I see why
> but someone reading the code in the future might not)?

Yes no problem will fire a new version out today.

Thanks,
Charles
