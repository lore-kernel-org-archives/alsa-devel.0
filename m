From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Add ASoC TLV320 Codec driver.
Date: Tue, 20 Nov 2007 22:34:42 +0100
Message-ID: <20071120223442.7e0bcead@hyperion.delvare>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h4pfhjihm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 4880E24AD4
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 22:34:44 +0100 (CET)
In-Reply-To: <s5h4pfhjihm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, i2c@lm-sensors.org, Nicola Perrino <nicola.perrino@atlab.it>
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Mark,

On Tue, 20 Nov 2007 11:53:25 +0100, Takashi Iwai wrote:
> At Tue, 20 Nov 2007 09:25:39 +0000,
> Mark Brown wrote:
> > 
> > diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
> > index 5ced329..f6a1ddf 100644
> > --- a/include/linux/i2c-id.h
> > +++ b/include/linux/i2c-id.h
> > @@ -122,6 +122,7 @@
> >  #define I2C_DRIVERID_VP27SMPX	93	/* Panasonic VP27s tuner internal MPX */
> >  #define I2C_DRIVERID_CS4270	94	/* Cirrus Logic 4270 audio codec */
> >  #define I2C_DRIVERID_AK4535	95	/* AK4525 audio codec */
> > +#define I2C_DRIVERID_TLV320	97	/* TLV 320 audio codec */
> 
> Where is 96? :-)

You don't seem to use these driver IDs anywhere? These IDs are
optional, so if you have no need for them, it's much easier to just not
define them.

Note that the i2c_driver.id field is planed for removal anyway.

-- 
Jean Delvare
