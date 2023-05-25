Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7607C7EE29
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 18:33:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE01A200;
	Thu, 25 May 2023 20:32:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE01A200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685039610;
	bh=30LUA668h7VdTQuEqajPXaMTBzrCOVJwFLuPF9LjHBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hpO77r17srJ9MDQd+56hRLSgo7co45NXCPp3ckUyp1h21ftSEaCuAamXn0zNH234K
	 +Qf7+5PS1ZpyWL0gYlmk5u19zI2T6AxihdCFEs5d2d8JssN/0sdVaVkb4UUCaK4fqS
	 JU+SyrripyRwWZzPRk7aZ0clHsOaGVTw9OzzPheI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1078FF80548; Thu, 25 May 2023 20:32:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C8FBF8024E;
	Thu, 25 May 2023 20:32:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 146D9F8024E; Thu, 25 May 2023 20:32:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B7591F80007
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2023 20:32:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7591F80007
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=f77ZhGjt
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6310864892;
	Thu, 25 May 2023 18:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB9C4339B;
	Thu, 25 May 2023 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039518;
	bh=30LUA668h7VdTQuEqajPXaMTBzrCOVJwFLuPF9LjHBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f77ZhGjtPRuFcDb3H6pAow3J/NMDGXwIxs+UQeFAS6ttZOmFcfVLekmr79o5TQhyV
	 4wEDuJ4lPqJmXnkb3Fzl6ANU1PgXhuL4Xk7eHhJIxEu7O+CtMQAu1E9Jum8jSBdEte
	 7lsJ/qgKnSaKtKK3VowbiByjCzr/VJ1kD1rXwTVJln8cEWHlQm5c9XOmvzFH+LJZtr
	 mFtcX9hTaHST5q/JBJbWCoYRnX1jdrQdrX1EAHu/W2PPVxGn/G6tJ7ZvD3RI2zl+ml
	 Puxl4vqrIjau1bW8hVOAolrgp4cR8tZ/OcqMyxrBoTNde2BzGFqZX2yp3EIkhNBbuR
	 ZmkTCSeHvXYqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeremy Soller <jeremy@system76.com>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	Syed.SabaKareem@amd.com,
	xazrael@hotmail.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 04/67] ASoC: amd: yc: Add DMI entry to support
 System76 Pangolin 12
Date: Thu, 25 May 2023 14:30:41 -0400
Message-Id: <20230525183144.1717540-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7OMCIHJQIYDHELGBLGRVYIG2WCRSMSGS
X-Message-ID-Hash: 7OMCIHJQIYDHELGBLGRVYIG2WCRSMSGS
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7OMCIHJQIYDHELGBLGRVYIG2WCRSMSGS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jeremy Soller <jeremy@system76.com>

[ Upstream commit 7b9891ad25246b18b5ccc19518da7abc7763aa0a ]

Add pang12 quirk to enable the internal microphone.

Signed-off-by: Jeremy Soller <jeremy@system76.com
Signed-off-by: Tim Crawford <tcrawford@system76.com
Link: https://lore.kernel.org/r/20230505161458.19676-1-tcrawford@system76.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0acdf0156f075..b844f321d139e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -276,6 +276,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "System76"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "pang12"),
+		}
+	},
 	{}
 };
 
-- 
2.39.2

