From: Bard Liao <bardliao@realtek.com>
Subject: Different reg_default for rt5650 codec
Date: Thu, 29 Oct 2015 11:17:26 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7010C3663@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EF4A260537
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 12:17:32 +0100 (CET)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

Mark,

rt5645.c support both rt5645 and rt5650 codec. And the default value of
registers are not identical. So, we may need separate reg_defaults for
rt5645 and rt5650.  My idea is to assign a new reg_defaults once rt5650
is detected.
Something like
	case RT5650_DEVICE_ID:
+		rt5645->regmap-> reg_defaults = rt5650_reg;
+		rt5645->regmap-> num_reg_defaults = ARRAY_SIZE(rt5650_reg)
		rt5645->codec_type = CODEC_TYPE_RT5650;
		break;

Is that ok?

Or should I use different regmap_config? There is one question if I use
different regmap_config. We will know which codec it is by regmap_read.
So, regmap is init before we know which codec it is. Assume rt5645_regmap
is used and what should I do once rt5650 is detected?

Thanks.

Bard Liao

Computer Peripherals Business Unit
Realtek Semiconductor Corp.
886-3-578-0211 ext. 13334
bardliao@realtek.com
