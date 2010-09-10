From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: tlv320aic3x: Add runtime
 regulator control to aic3x_set_bias_level
Date: Fri, 10 Sep 2010 15:18:27 +0300
Message-ID: <20100910151827.debce417.jhnikula@gmail.com>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
	<1284117812-8618-2-git-send-email-jhnikula@gmail.com>
	<20100910114717.GI7259@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5945C1039B6
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 14:17:32 +0200 (CEST)
Received: by eye27 with SMTP id 27so577812eye.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 05:17:32 -0700 (PDT)
In-Reply-To: <20100910114717.GI7259@rakim.wolfsonmicro.main>
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

On Fri, 10 Sep 2010 12:47:17 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Sep 10, 2010 at 02:23:30PM +0300, Jarkko Nikula wrote:
> 
> > This patch manages all the regulators and reset since it seems that register
> > sync is needed even if only analog supplies AVDD and DRVDD are disabled.
> > This was noted when the system was running with idle behavior changed and
> > IOVDD and DVDD were on.
> 
> This is normal, chips normally require all the core supplies to be
> enabled to take them out of reset.
> 
Some chips were programmable with digital IO supply only. I'll leave
this comment here to show that this chip has been noted to require all
of them :-)

> > @@ -151,7 +153,8 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
> >  	data[1] = value & 0xff;
> >  
> >  	aic3x_write_reg_cache(codec, data[0], data[1]);
> > -	if (codec->hw_write(codec->control_data, data, 2) == 2)
> > +	if (!aic3x->power ||
> > +	    codec->hw_write(codec->control_data, data, 2) == 2)
> >  		return 0;
> >  	else
> >  		return -EIO;
> 
> If you were using the soc-core stuff you'd be able to use the cache_only
> flag in the CODEC to do this.  It might make sense to still use the flag
> so that when someone converts the driver to use soc-cache this doesn't
> get missed.
> 
Makes sense, I'll change this.

> >  static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
> >  		      u8 *value)
> >  {
> > +	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
> >  	*value = reg & 0xff;
> >  
> > -	value[0] = i2c_smbus_read_byte_data(codec->control_data, value[0]);
> > +	if (aic3x->power) {
> > +		value[0] = i2c_smbus_read_byte_data(codec->control_data,
> > +						    value[0]);
> > +		aic3x_write_reg_cache(codec, reg, *value);
> > +	} else {
> > +		value[0] = aic3x_read_reg_cache(codec, reg);
> > +	}
> >  
> > -	aic3x_write_reg_cache(codec, reg, *value);
> >  	return 0;
> >  }
> 
> This seems fishy - surely the read should be being satisfied from cache
> all the time if it can be, and if the register does need to be read from
> the hardware due to being volatile then it's an error to read it while
> powered off?

Good question. I didn't look at this. Actually it seems there is a need
to add some function to indicate if headset & button detection or gpio
readings are required. We cannot shutdown if those are needed.


-- 
Jarkko
