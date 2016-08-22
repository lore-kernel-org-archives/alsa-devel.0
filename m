From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: core: Clean up DAPM before the card
	debugfs
Date: Mon, 22 Aug 2016 16:30:56 +0300
Message-ID: <b2b7605a-b80e-6ac0-e948-4a7472e8394c@ti.com>
References: <1471545449-29516-1-git-send-email-broonie@kernel.org>
 <20160818232642.GF1041@n2100.armlinux.org.uk>
 <20160819175003.GE22076@sirena.org.uk>
 <20160819180452.GW1041@n2100.armlinux.org.uk>
 <20160819181123.GF22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id B452C2654CE
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 15:31:04 +0200 (CEST)
In-Reply-To: <20160819181123.GF22076@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/19/16 21:11, Mark Brown wrote:
> On Fri, Aug 19, 2016 at 07:04:52PM +0100, Russell King - ARM Linux wrote:
> =

>> I think it was something like the following, but I don't remember
>> off hand without re-running the build that caused it and booting it
>> again.
> =

>> twl6040 0-004b: Unable to sync registers 0xc-0xd. -121
> =

> ...
> =

>> That's probably not regmap's fault, but something else.  I guess TIers
>> need to dig into that one.
> =

> Yeah, smells like an I/O error - possibly attempting to resync before
> the I2C bus is up or something?

twl6040 does not support bulk access:
https://lkml.org/lkml/2016/5/18/296

I will resend the MFD patches asap.

-- =

P=E9ter
