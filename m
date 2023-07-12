Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3B4C0015E
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 15:42:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C98DEAE9;
	Wed, 12 Jul 2023 17:41:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C98DEAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689176568;
	bh=TnBFqbbzgjL9q9pFRoc5uu6BkdcO9YJ7JVR18QHszz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZnWFzTmqg2iSYpAiiOQcb1KBC732BAf3FoD/y4tGRQ6naY4/2YLvhFfoZKcg14wKk
	 oEDgQbPSsRWfMvsO2iIwS6Gz7JJmX2KowuwlceRgaww2ZpgSjT5j1ik/NuiMGCoowH
	 ifOq/lhABpK03b12WLUceS7dNOegjepgDmVOXbh0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 451B3F80571; Wed, 12 Jul 2023 17:41:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B2B9F80570;
	Wed, 12 Jul 2023 17:41:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98D00F80551; Wed, 12 Jul 2023 17:41:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7C86F80153
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 17:40:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7C86F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qxVEnB/5
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 64A6161828;
	Wed, 12 Jul 2023 15:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CECAC4339A;
	Wed, 12 Jul 2023 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689176446;
	bh=TnBFqbbzgjL9q9pFRoc5uu6BkdcO9YJ7JVR18QHszz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qxVEnB/5IDGeIXoXuliMt3jaDqILPk0b0m5VguRDIY3c2nl39ekD67uvMykOdHcVT
	 y8RJJC0jk4f+XpzEUMBvjkUGSDmDyeyH1jbFE8GbMzkTChN45XXTJ9iQf480A8NK/A
	 D9rVOLU8EhLoZl3Fx6Ixhs8Z/6nuJDPD3tMEoCfFDZTfYtkixyVwI7RyoAjbFep+Gw
	 yt3MoAg+VrVAu2/Ff5sbrJtqngm6h6ZElrz4xiBPIl0ky3SA3Ze7nRzvDaJQGBlyda
	 dQIAJ29dtdCYlJM+wCoEz+WdhS7sKFp6KXauloNqcoMBd7FlkC+Fe6rpvt8pS9b2Zj
	 xtTwsA46mDf2Q==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 12 Jul 2023 16:40:34 +0100
Subject: [PATCH 1/2] kunit: Enable ASoC in all_tests.config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-asoc-topology-kunit-enable-v1-1-b9f2da9dca23@kernel.org>
References: <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
In-Reply-To: 
 <20230712-asoc-topology-kunit-enable-v1-0-b9f2da9dca23@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=682; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TnBFqbbzgjL9q9pFRoc5uu6BkdcO9YJ7JVR18QHszz8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrsl27ZL9bb6Lvk7dV/yYkcl8czkbEDp6M5JF3
 fZ5YIXFOgCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK7JdgAKCRAk1otyXVSH
 0M58B/47rzu91SwUwCKWAryHgGCq69ZM0U8NuOuxuimscwow45VjLpFLJLqs1YaLwbGjz/f/s1U
 jwaqvgJ0lukYrUq7MNKR4IjHkPY5EyXtEIBHfdieUWQwkgUKUCsHTnX4Gw9MCqVskznMiNMWWYb
 FU3+yw9OVFcaezNsSdLP6bVDy16j3R8YDWyZbx7HDFTPgpJYr1dPsYNZLzPqBZUGZanPxrseV7j
 7X3rhpYwRux2Hid3xXH7JrVcjf1idI9TquKpxpMVt2Pmz/+5ACGgpqwFz+ti4kpNLFwS2Z0DN7n
 VOwIQ+uGA8vNWkX5jYY8l66imUA/4wu7AXO2A6rwVtMm8QS4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: UUHA3VTZ3CD32NLVGYXFLA42TSDWHBMO
X-Message-ID-Hash: UUHA3VTZ3CD32NLVGYXFLA42TSDWHBMO
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UUHA3VTZ3CD32NLVGYXFLA42TSDWHBMO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There are KUnit tests for some of the ASoC utility functions which are
not enabled in the KUnit all_tests.config, do so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/kunit/configs/all_tests.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 0393940c706a..13d15bc693fb 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -35,3 +35,7 @@ CONFIG_DAMON_DBGFS=y
 
 CONFIG_SECURITY=y
 CONFIG_SECURITY_APPARMOR=y
+
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y

-- 
2.39.2

