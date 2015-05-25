From: Sergej Sawazki <ce3a@gmx.de>
Subject: ASoC: regmap_config.max_register value wrong?
Date: Mon, 25 May 2015 22:46:25 +0200
Message-ID: <55638A21.50208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B2462625EE
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 22:46:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, dan.carpenter@oracle.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear all,

The following snippet is from the wm8741 codec driver. Shouldn't the
.max_register field be set to WM8741_REGISTER_COUNT-1 (10) instead of
WM8741_MAX_REGISTER (0x20)?

[...]
static const struct regmap_config wm8741_regmap = {
	.reg_bits = 7,
	.val_bits = 9,
	.max_register = WM8741_MAX_REGISTER,
[...]

WM8741_MAX_REGISTER is the address of the last register.
WM8741_REGISTER_COUNT is the number of registers.

The regmap_config documentation says: "@max_register: Optional,
specifies the maximum valid register index."

So it should be the *register index* and not the register address.
Do I understand it correctly?

Many thanks in advance.
Best regards,
Sergej
