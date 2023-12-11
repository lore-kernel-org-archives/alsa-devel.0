Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40A0C10DC3
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 14:04:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D339DDF9;
	Mon, 11 Dec 2023 15:04:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D339DDF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702303468;
	bh=uNrzFIHW5arvNF8Q+6qd4P78lIhkuakWAiBbRtTZw5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EseJlcAyMCHPv8cyFaI9KFR3d4UZb1qw4SdHM7U0yvsOersDDhXajAJtj+IFeqNMa
	 3a2viFKNpBGPV3XI9SGxAPNxYWEbYs36ai7g0C2MLEBGnlFvC4kOhTSjnDkkCXi85z
	 +/lZFqEJ2vvAKLpeBPZ1eQBWRgOXKNu3mCpi5N84=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2AED2F8060E; Mon, 11 Dec 2023 15:02:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E1EBF80674;
	Mon, 11 Dec 2023 15:02:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03314F805C7; Mon, 11 Dec 2023 15:02:50 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 634CCF8001F
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 15:02:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 634CCF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=R/C4U5/O
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8DDFFCE1287;
	Mon, 11 Dec 2023 14:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA7C433C9;
	Mon, 11 Dec 2023 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303355;
	bh=uNrzFIHW5arvNF8Q+6qd4P78lIhkuakWAiBbRtTZw5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/C4U5/OnlP/Kz9sI6pG/GtsmlRgApoZZdWvYslDIz7bfIf9TGLWLtR8yZsS6nQ6C
	 mJts11aKsE53G8LoUO7Z6lttEfPgoFTqRVpVNKHgDhv0TF42QxRyjPZrTcHEvXOkn4
	 o8IgO6a5rLMdz+RjkgC9EYniPTNYOLi7DyRJgy3V8ro6jpW+UkIl33CG8XvGmLKx0j
	 Zj0OYgnkRIq4wvIwMw+FF4wbEUHdOI7L3v0JiCF7c3OIO5HLRflw3TAwf8IG2H3U7n
	 Ph6ci/8oHEBlIZu5cMezL/dMVanxCX87pXLvdmyn/M6h7r3R3T0V5UGPVcd8Hj84XC
	 gxAYsEU0bwKHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 05/12] ASoC: cs43130: Fix incorrect frame delay
 configuration
Date: Mon, 11 Dec 2023 09:01:58 -0500
Message-ID: <20231211140219.392379-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140219.392379-1-sashal@kernel.org>
References: <20231211140219.392379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.263
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GRK367GLDFX7AOUDHJJCNPH3Q3I55U74
X-Message-ID-Hash: GRK367GLDFX7AOUDHJJCNPH3Q3I55U74
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GRK367GLDFX7AOUDHJJCNPH3Q3I55U74/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit aa7e8e5e4011571022dc06e4d7a2f108feb53d1a ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-3-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 285806868c405..02fb9317b6970 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -578,7 +578,7 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		hi_size = bitwidth_sclk;
-		frm_delay = 2;
+		frm_delay = 0;
 		frm_phase = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-- 
2.42.0

