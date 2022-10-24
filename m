Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BACC38A2D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 22:02:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47F2456BD;
	Tue, 25 Oct 2022 00:01:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47F2456BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666648947;
	bh=yUOJmnlfdy5bC2kZgeZWbD0yF667HQA6aNkS15dlW6A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VKm2wNOwU8pWN7RCJKBwxJcDuDepkkTRaODgH+7eGAClP7oJCCWw15DyCHu1ihF3a
	 Vfhn4KElh5R8gZ+9V6y8uS7THvxd8HaLzd0oYeP0v23DW7Bc2EIp1UUYqSULVYwEXp
	 l4/2PIUTckZaYViWASYtaqjd3bbf/fp1n7OqV/Ys=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE0B9F80566;
	Tue, 25 Oct 2022 00:00:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59E0EF8055A; Tue, 25 Oct 2022 00:00:36 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E1F1F8052F
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 00:00:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E1F1F8052F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="GGQxoeeu"
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id C0E496602820;
 Mon, 24 Oct 2022 23:00:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1666648829;
 bh=yUOJmnlfdy5bC2kZgeZWbD0yF667HQA6aNkS15dlW6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GGQxoeeulNxtBsMzpjtPmZyyGa4mApgfpXJiUxsfMh8TjJFkSpE1FpW0wUBr6Xt69
 3gZ3eY1j7ub80kQgEWBC//c94Ojomkwy0PVU7EunnRhexxGD5C68E3yef5fuLeG5+W
 srwyYfZg/MDqcf/2gs+731jRqJcm36f6Oe5mvY8Vj+4xATnTwllLTzUrmFRH1nhgZW
 /ayYlLCZnCnYFH/5rRLq/DuIf6ymFrcIX7SOLb5wcKmT7L1rsqsLZOp8GCkLqEqyNB
 pWfoMJYYX/XUuFsMt5mzA9BLAvt9JnDJkiM/AB07acH6xEKJ9fWEcKeIn+OGZ1rLwL
 14iQFRP4iIGqQ==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/4] ASoC: dt-bindings: rt5682: Set sound-dai-cells to 1
Date: Mon, 24 Oct 2022 18:00:14 -0400
Message-Id: <20221024220015.1759428-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024220015.1759428-1-nfraprado@collabora.com>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Commit 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
defined the sound-dai-cells property as 0. However, rt5682 has two DAIs,
AIF1 and AIF2, and therefore should have sound-dai-cells set to 1. Fix
it.

Fixes: 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added this commit

 Documentation/devicetree/bindings/sound/rt5682.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index c5f2b8febcee..6b87db68337c 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -46,7 +46,7 @@ Optional properties:
 
 - realtek,dmic-clk-driving-high : Set the high driving of the DMIC clock out.
 
-- #sound-dai-cells: Should be set to '<0>'.
+- #sound-dai-cells: Should be set to '<1>'.
 
 Pins on the device (for linking into audio routes) for RT5682:
 
-- 
2.38.1

