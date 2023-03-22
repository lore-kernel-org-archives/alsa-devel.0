Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEB9C6FD1F
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Mar 2023 20:08:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63202F16;
	Wed, 22 Mar 2023 21:07:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63202F16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679515706;
	bh=2yJDhlgtT2RyRVOjfRfz4bd8Xvh8tCq8cDWSbB+IWv4=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BH+0Y25C0pom+K2SsXg8qf5UPrBpEw4xie/Z1hDv6Phe0KbS2k5CTT+PfbI7M4J46
	 jQZ7RkFaRQkX/IajTCdsMoeSKso7DCvrcnHqaQJXw1WLvd4hJyM6CJBxQ3/pP3LQy9
	 vSlrcMQAcltBilHOecTnlEn3gUs2BBC+mX7axseU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65615F805BF;
	Wed, 22 Mar 2023 21:03:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0D2BF805C0; Wed, 22 Mar 2023 21:03:50 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0AAA9F8055A
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2023 21:03:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AAA9F8055A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dHPGYBIM
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A4891622B4;
	Wed, 22 Mar 2023 20:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D7CC433D2;
	Wed, 22 Mar 2023 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679515427;
	bh=2yJDhlgtT2RyRVOjfRfz4bd8Xvh8tCq8cDWSbB+IWv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHPGYBIMVFtxswFPr5yivaZ4atQT4F0S8BgyXWVB0gpZnrxZdFB0sWgzKmuF0e6BG
	 tVRcPf3ST8rzf8oH6837kyEMepCKArvTmzvvVK7DkUuSzri8xs+aeeb6qJYDBzoLT5
	 cv+FU9uU0udypAch/4aYRILNVy/Mu2Uq+sm0AfL+FpemDHLJN+p5KTdr15FXZZeqKr
	 zMXAiYssT89nKL6KH5sQgJTa8kc4fu5SFY+Lrs5GWQP6YD7i7PMVndhAUZm5SiYgWJ
	 pGzeiiMtPb4XGgLINahfJgH8jV49D4v1x1Uqua+dvfoEk5YmRUc8ob5qN3pJSELxgD
	 P1vWi57+wuvjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/9] ALSA: hda/ca0132: fixup buffer overrun at
 tuning_ctl_set()
Date: Wed, 22 Mar 2023 16:03:30 -0400
Message-Id: <20230322200337.1997810-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322200337.1997810-1-sashal@kernel.org>
References: <20230322200337.1997810-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3FU4DWA6QBAJATACVYNDRWLPGAJZ3IGB
X-Message-ID-Hash: 3FU4DWA6QBAJATACVYNDRWLPGAJZ3IGB
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 tiwai@suse.com, dev@xianwang.io, ye.xingchen@zte.com.cn,
 gremlin@altlinux.org, alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3FU4DWA6QBAJATACVYNDRWLPGAJZ3IGB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 98e5eb110095ec77cb6d775051d181edbf9cd3cf ]

tuning_ctl_set() might have buffer overrun at (X) if it didn't break
from loop by matching (A).

	static int tuning_ctl_set(...)
	{
		for (i = 0; i < TUNING_CTLS_COUNT; i++)
(A)			if (nid == ca0132_tuning_ctls[i].nid)
				break;

		snd_hda_power_up(...);
(X)		dspio_set_param(..., ca0132_tuning_ctls[i].mid, ...);
		snd_hda_power_down(...);                ^

		return 1;
	}

We will get below error by cppcheck

	sound/pci/hda/patch_ca0132.c:4229:2: note: After for loop, i has value 12
	 for (i = 0; i < TUNING_CTLS_COUNT; i++)
	 ^
	sound/pci/hda/patch_ca0132.c:4234:43: note: Array index out of bounds
	 dspio_set_param(codec, ca0132_tuning_ctls[i].mid, 0x20,
	                                           ^
This patch cares non match case.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87sfe9eap7.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_ca0132.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 280643f72c6e2..13c32f3414d2f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2943,8 +2943,10 @@ static int tuning_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 
 	for (i = 0; i < TUNING_CTLS_COUNT; i++)
 		if (nid == ca0132_tuning_ctls[i].nid)
-			break;
+			goto found;
 
+	return -EINVAL;
+found:
 	snd_hda_power_up(codec);
 	dspio_set_param(codec, ca0132_tuning_ctls[i].mid,
 			ca0132_tuning_ctls[i].req,
-- 
2.39.2

