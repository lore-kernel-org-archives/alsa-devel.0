From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320aic3x: Let the codec hit
 SND_SOC_BIAS_OFF when idle
Date: Fri, 10 Sep 2010 15:42:38 +0300
Message-ID: <20100910154238.8377bed9.jhnikula@gmail.com>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
	<1284117812-8618-4-git-send-email-jhnikula@gmail.com>
	<20100910120016.GL7259@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7149510395E
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 14:41:43 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1594309ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 05:41:43 -0700 (PDT)
In-Reply-To: <20100910120016.GL7259@rakim.wolfsonmicro.main>
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

On Fri, 10 Sep 2010 13:00:17 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Sep 10, 2010 at 02:23:32PM +0300, Jarkko Nikula wrote:
> 
> > -	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
> > +	if (aic3x->power)
> > +		regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies),
> > +				       aic3x->supplies);
> 
> This looks suspicious - doesn't it mean that the enable/disables won't
> be balanced any more?  I'd expect to either see the disable being
> uncondtional or the power flag being updated.  I could be missing
> something, though.

I agree.

This is actually due the current implementation where the regulators are
enabled in aic3x_i2c_probe and disabled in aic3x_probe. So this disable
is needed only if the driver is removed without aic3x_probe being
called.

I'll cook up one patch more that moves regulator setup to aic3x_probe
as most of the codec drivers are doing. (side issue: it's hard to probe
a chip if voltages are missing but doing regulator setup in i2c probe is
not any better either).


-- 
Jarkko
