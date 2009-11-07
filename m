From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] S3C AUDIO: Add header to pass platform
 data to device drivers.
Date: Sat, 7 Nov 2009 12:12:53 +0000
Message-ID: <20091107121252.GA3228@sirena.org.uk>
References: <1257384900-18308-1-git-send-email-jassi.brar@samsung.com>
	<20091106165214.GF4938@sirena.org.uk>
	<1b68c6790911061931h59ef299ftb7422421225fd4d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 09AE81037F2
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 13:12:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790911061931h59ef299ftb7422421225fd4d0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 07, 2009 at 12:31:43PM +0900, jassi brar wrote:

> Well, since the abstraction(dev-audio) is supposed to be common for
> I2S, PCM and AC97 protocol, we need to have another layer which
> communicate protocol specific platform data.
> This pdata is meant to serve that purpose in future.

There's no real abstraction here - it's just a place to put the devices
and whatnot for the various audio related devices.  I would be very
surprised to ever see any need for generic audio platform data, the
devices don't have that much in common.

> > I'd just embed the GPIO configuration callback in a driver-specific
> > platform data.
> If not for pdata, the cfg_gpio wudn't be enough for future SoCs which
> not only configure the MUX'ed pins but also set the drive strength. Some
> might also need configuring the SoC which may not fall into either Clock
> or Power domain.
> So, if I am to remove pdata, maybe cfg_gpio can be renamed config_controller?

I'd be happier if it stayed as GPIO - that'd still cover things like
drive strength.  This is because the platform device code has recently
gained the ability to provide platform specific annotations on the
device itself which would allow this to be done in a way that is
transparent to the edge drivers and avoids code duplication in all the
device drivers.  This is (IIRC) used by the OMAP power domain management
and I'd expect that the Samsung SoCs will end up going down a similar
way in future.  I'd rather try to reduce the amount of device specific
handling for things like that which appears.
