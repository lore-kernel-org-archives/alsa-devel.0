From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] ASoC: sta32x: add workaround for ESD reset
	issue
Date: Wed, 9 Nov 2011 18:34:19 +0100
Message-ID: <20111109173419.GA10174@sig21.net>
References: <20111109133001.GA7394@sig21.net>
	<20111109143647.GB587@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EE84243B5
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 18:34:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111109143647.GB587@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 09, 2011 at 02:36:47PM +0000, Mark Brown wrote:
> On Wed, Nov 09, 2011 at 02:30:01PM +0100, Johannes Stezenbach wrote:
> > sta32x resets and loses all configuration during ESD test.
> > Work around by preserving coefficient RAM in a shadow,
> > poll once a second on the CONFA register and restore
> > all coeffcients and registers when CONFA changes unexpectedly.
> 
> So, clearly a constant poll isn't going to do power consumption or
> anything any favours so we shouldn't be doing this by default.  The most
> obvious idea is to only check while audio is active (since it doesn't
> really matter if the device is reset while not playing audio anyway)
> which would get rid of most of the problem.

Um, well, the sta32x is a power amplifier, it draws 3mA
even when in power down.  I think a poll once per second
won't add measurable power consumption, especially since
there are other wakeup sources present in the system with
higher wakeup frequency.  I acknowledge that your are right
in principle, but since the sta32x won't be used in battery-powered
mobile devices I think it is not crucial to improve this.  Do you agree?

> Given that the driver already supports powering the device down it may
> also be sufficient to simply enable idle_bias_off and assume that if the
> device resets the application will get sufficiently upset to restart
> things anyway.

Unfortunately the app won't notice, the PXA I2S interface will
happily push the audio data to the codec which will be muted
without the app knowing it since the register cache will tell
something different.

> If we do need to poll or anything else invasive I'd also expect this to
> be optional as if the device has ESD weaknesses then it'd be likely that
> boards would add external ESD protection which 

OK, I'll add a module parameter.  Raumfeld engineers claim their
hw design is fine as is, of course...


> >  	snd_soc_write(codec, STA32X_CFADDR2, index);
> > +	for (i = 0; i < numcoef && (index + (i + 1) * 3 < STA32X_COEF_COUNT); i++)
> > +		sta32x->coef_shadow[index + i] =
> > +			  (ucontrol->value.bytes.data[3 * i    ] << 16)
> > +			| (ucontrol->value.bytes.data[3 * i + 1] << 8)
> > +			| (ucontrol->value.bytes.data[3 * i + 2]);
> 
> Does this need to be done when restoring to _STANDBY as well?

No, all registers and coefs are preserved until hw reset or power loss.

> > +	/* check if sta32x has reset itself */
> > +	snd_soc_cache_read(codec, STA32X_CONFA, &confa);
> > +	if (confa == codec->hw_read(codec, STA32X_CONFA))
> > +		goto ok;
> 
> Don't call hw_read() directly, use cache_bypass if you need to.

OK

> > +	/* mute during restore */
> > +	snd_soc_cache_read(codec, STA32X_MMUTE, &mute);
> > +	snd_soc_write(codec, STA32X_MMUTE, mute | STA32X_MMUTE_MMUTE);
> 
> Just use snd_soc_read() and let the cache do the right thing.

hm, I think snd_soc_cache_read() is more explicit; but OK, will change

> > +	for (i = 0; i < STA32X_REGISTER_COUNT; i++) {
> > +		if (snd_soc_codec_volatile_register(codec, i))
> > +			continue;
> > +		snd_soc_cache_read(codec, i, &value);
> > +		snd_soc_write(codec, i, value);
> > +	}
> 
> Use cache_sync().

OK


Thanks
Johannes
