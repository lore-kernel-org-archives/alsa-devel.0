From: Mark Brown <broonie@opensource.wolfosnmicro.com>
Subject: Re: [PATCH] Add ASoC TLV320 Codec driver.
Date: Tue, 20 Nov 2007 12:22:51 +0000
Message-ID: <20071120122250.GA21414@sirena.org.uk>
References: <1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BB6824A00
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 13:22:53 +0100 (CET)
Content-Disposition: inline
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
To: Takashi Iwai <tiwai@suse.de>, Nicola Perrino <nicola.perrino@atlab.it>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, i2c@lm-sensors.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 11:53:25AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > +#define I2C_DRIVERID_TLV320	97	/* TLV 320 audio codec */

> Where is 96? :-)

Sorry, I had another codec queued for addition which I dropped from the
series.  I'll fix this when I resubmit.

> > +#define TLV320_VOICE_BITS \
> > +	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
> > +	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)

> Double-check if it's really S24_LE or S24_3LE.

Nicola, could you please look into this and also the other issues that
Takashi raised?
