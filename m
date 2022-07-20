Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E028FC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jul 2022 16:02:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 224A41890;
	Thu, 21 Jul 2022 18:01:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 224A41890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658419323;
	bh=04lEv4md+meT45x9vGxNBY7skVDgunMl32yD7sb+orE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RL5oQ6PgN7awcSEZ2TlxflkBu6xU+sBpqbl4LH0H3PsXuq5qKZw/bVs/+BT4YWvSE
	 w6EEpybT33EZ8gDzKQ3cmR9d8l87BCsWkm7UU3sZqlT369zVWCrJ2MnPv//3xghDBx
	 lUvsYzczAfMI+Ikjtx0QqmJjJ9+VZMoU2aq9Z0Mo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9586AF8058C;
	Thu, 21 Jul 2022 17:58:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8315F800BA; Wed, 20 Jul 2022 21:58:36 +0200 (CEST)
Received: from smtpbg.qq.com (unknown [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C605AF800BA
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 21:58:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C605AF800BA
X-QQ-mid: bizesmtp85t1658347100t3i1qnje
Received: from harry-jrlc.. ( [125.70.163.183])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 21 Jul 2022 03:58:10 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: hoArX50alxH98OUvPUVBbyqiVwZNp3TNDC56TczZlb7YsKlmcTzFVWQWGteBb
 4snqm2P3EAmLSQNyGA2hrlpCyscabIAHeMmrizKGjnBYNHzG89eYRZ4qkIOIzFHsJ95ds59
 5pgLofybb576NkhqHdVNRiSVWho4n9EJb4/j3ztRwS/3mnyUJg9vYRH0frOiQ9kbtkm8Uhq
 fnC1g2PqGoL2bLzxt7s+BVuYnkqvKZUedem1mpO1m1VziYwWaQvLnnW8CNSV5b79m7MdVgA
 F+e2AqbCo8ejuQQFKEP//wPTntgSYDli/V+c3F6wl3MDLpx0XZE/XJejcAcSDhOasYdk8HW
 LyZA4YtLA/fq6CnqENHyv8F9xbAu76W4zWoEsk7xyXh2tTXQo/Ep7erPSrDTQ==
X-QQ-GoodBg: 0
From: Xin Gao <gaoxin@cdjrlc.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ASoC:do not initialise statics to 0.
Date: Thu, 21 Jul 2022 03:58:09 +0800
Message-Id: <20220720195809.9470-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Mailman-Approved-At: Thu, 21 Jul 2022 17:58:03 +0200
Cc: fred.oh@linux.intel.com, alsa-devel@alsa-project.org,
 Xin Gao <gaoxin@cdjrlc.com>, linux-kernel@vger.kernel.org,
 akihiko.odaki@gmail.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 45c301ea5e00..8a8b25589c55 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -50,7 +50,7 @@ struct cht_mc_private {
 #define CHT_RT5645_SSP0_AIF2     BIT(18)
 #define CHT_RT5645_PMC_PLT_CLK_0 BIT(19)
 
-static unsigned long cht_rt5645_quirk = 0;
+static unsigned long cht_rt5645_quirk;
 
 static void log_quirks(struct device *dev)
 {
-- 
2.30.2

