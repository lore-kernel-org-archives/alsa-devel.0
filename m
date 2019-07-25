From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 00/11] JZ4740 SoC cleanup
Date: Thu, 25 Jul 2019 18:02:04 -0400
Message-ID: <20190725220215.460-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset converts the Qi LB60 MIPS board to devicetree and makes it
use all the shiny new drivers that have been developed or updated
recently.

All the crappy old drivers and custom code can be dropped since they
have been replaced by better alternatives.

Some of these alternatives are not yet in 5.3-rc1 but have already been
accepted by their respective maintainer for inclusion in 5.4-rc1.

To upstream this patchset, I think that as soon as MIPS maintainers
agree to take patches 01-03/11 and 11/11, the other patches can go
through their respective maintainer's tree.

Note for MIPS maintainers:
Patch 11/11 may conflict with the TCU patchset v15, should this one be
accepted upstream, but the conflict is tiny and easy to fix. Should this
case appear, don't hesitate to bother me about it.

Thanks,
-Paul
