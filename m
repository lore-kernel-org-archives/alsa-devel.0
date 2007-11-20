From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add ASoC AK4535 codec driver.
Date: Tue, 20 Nov 2007 15:35:41 +0000
Message-ID: <20071120153538.GA1744@sirena.org.uk>
References: <1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h63zxjj3a.wl%tiwai@suse.de>
	<20071120150530.GF21414@sirena.org.uk>
	<s5hwssd3rna.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 81981249D1
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 16:35:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwssd3rna.wl%tiwai@suse.de>
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
Cc: Richard Purdie <richard@openedhand.com>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Milan Plzik <milan.plzik@gmail.com>, i2c@lm-sensors.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 03:42:17PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > consistency I'd rather leave this just now and then separately go
> > through and address this for all drivers at once - does that seem
> > sensible to you?

> Well, the problem is that the dependency with I2C is incomplete right
> now.  We may build ASOC=y and I2C=m, and you'll get unresolved symbols
> due to call of I2C function from asoc.

Yes, I agree that this would be an improvement.  I'd just like to do it
for all the drivers at once rather than have some of the drivers set up
one way and some another.

> I'm not sure what is the proper way to fix this.  If the codec driver
> supports non-I2C and can be built without it, the explicit dependency
> on I2C is of course wrong.

Yes, and of course users will still need to ensure that the appropriate
bus driver for their platform is availiable on their system, though that
could be loaded later.  Still, we could make life a little easier for
some users so it seems a worthwhile thing to do even though it doesn't
solve everything.
