From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: tlv320aic3x: Use regulator
 notifiers for optimizing the cache sync
Date: Fri, 10 Sep 2010 15:33:32 +0300
Message-ID: <20100910153332.8a3255b0.jhnikula@gmail.com>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
	<1284117812-8618-3-git-send-email-jhnikula@gmail.com>
	<20100910115808.GK7259@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AA5010395F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 14:32:37 +0200 (CEST)
Received: by eye27 with SMTP id 27so588850eye.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 05:32:37 -0700 (PDT)
In-Reply-To: <20100910115808.GK7259@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Sep 2010 12:58:08 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Sep 10, 2010 at 02:23:31PM +0300, Jarkko Nikula wrote:
> 
> > Mark, struct aic3x_disable_nb was created for getting pointer to aic3x easily.
> > Probably same idea could be applied to wm8962 as well?
> 
> Probably.  TBH I'd rather fix this in the notifier API - either way it's
> pretty nasty.
> 
Yep. I read this that I can still use this idea in v2 :-)

I noticed that I managed to forget to add test for event in
aic3x_regulator_event so I need to resend.

> > @@ -153,7 +161,7 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
> >  	data[1] = value & 0xff;
> >  
> >  	aic3x_write_reg_cache(codec, data[0], data[1]);
> > -	if (!aic3x->power ||
> > +	if (codec->cache_sync ||
> >  	    codec->hw_write(codec->control_data, data, 2) == 2)
> >  		return 0;
> >  	else
> 
> This isn't the expected use of cache_sync, the idea is that it is a flag
> indicating that a cache sync is required - this will happen when writes
> are held while the regulators are disabled but the regualators haven't
> actually been powered down.  This can be nice since we end up not
> needing to do I2C I/O during bulk configuration at startup, I'm hoping
> that we may be able to exploit this even more in the future.

I'll change this to cache_only and set both flags in
aic3x_regulator_event so that core can take use of them. My idea was to
cover both regulators not disabled case and CONFIG_REGULATOR not set
case and picked up this flag as it was set.


-- 
Jarkko
