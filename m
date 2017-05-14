From: David Binderman <dcb314@hotmail.com>
Subject: linux-4.12-rc1/sound/soc/codecs/cs35l35.c: false
	comparison ?
Date: Sun, 14 May 2017 19:15:13 +0000
Message-ID: <HE1PR0801MB1865C452989E58A0DB71BEA09CE00@HE1PR0801MB1865.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-oln040092065069.outbound.protection.outlook.com [40.92.65.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 165602668AC
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 21:15:14 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


hello there,

[linux-4.12-rc1/sound/soc/codecs/cs35l35.c:495] -> [linux-4.12-rc1/sound/soc/codecs/cs35l35.c:498]: (style) Mismatching assignment and comparison, comparison 'errata_chk==1' is always false.
[linux-4.12-rc1/sound/soc/codecs/cs35l35.c:495] -> [linux-4.12-rc1/sound/soc/codecs/cs35l35.c:498]: (style) Mismatching assignment and comparison, comparison 'errata_chk==3' is always false.

Source code is

    errata_chk = clk_ctl & CS35L35_SP_RATE_MASK;

    if (classh->classh_wk_fet_disable == 0x00 &&
        (errata_chk == 0x01 || errata_chk == 0x03)) {

but

./sound/soc/codecs/cs35l35.h:#define CS35L35_SP_RATE_MASK		0xC0

Regards

David Binderman
