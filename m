From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add ASoC AK4535 codec driver.
Date: Tue, 20 Nov 2007 15:05:30 +0000
Message-ID: <20071120150530.GF21414@sirena.org.uk>
References: <1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h63zxjj3a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 89EBF24A23
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 16:05:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h63zxjj3a.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Richard Purdie <richard@openedhand.com>, liam.girdwood@wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Milan Plzik <milan.plzik@gmail.com>, i2c@lm-sensors.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 11:40:25AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > +config SND_SOC_AK4535
> > +	tristate
> > +	depends on SND_SOC
> > +

> Unless you add another interface support, this driver seems only for
> I2C.  Then let's add dependency on I2C (which will avoid a possible
> unresolved symbol error).

The idiom used by the rest of the ASoC codecs appears to be to omit the
bus dependencies entirely from the codec drivers and rely on the machine
driver pulling in the appropriate bus driver.  For the sake of
consistency I'd rather leave this just now and then separately go
through and address this for all drivers at once - does that seem
sensible to you?

> > --- /dev/null
> > +++ b/sound/soc/codecs/ak4535.c

> ak4535.c has some obvious coding-style issues.
> Try to run scripts/checkpatch.pl and fix the reported parts.

I've fixed up the mechanical issues for next submission.
