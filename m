Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F344C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 10:34:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBD32076E
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 10:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QVxS/4ey";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fGCU7at5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBD32076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A57D1743;
	Wed, 11 Nov 2020 11:33:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A57D1743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605090841;
	bh=pZ5AL1mD10JHBSmSNt09nI9aNBf181UXKMDMZJRDp/c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QVxS/4eygIrVt7sd7SyL9aWkw6XhGxDPAujniryp9/NxqDBT3fxSPgkWLSA7/7Yv9
	 +NGWSPOW9KX1Z2jHFmHgh2+9n3/urJ6f7CDHjxjj4dWYl6oCjSjLhTqbqkhvvp1Ct/
	 0upwDFhm+LJlCNgnk0Hv86MeE8gr/r0c/7SmsKFY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75EF7F801F5;
	Wed, 11 Nov 2020 11:33:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1BFEF8020C; Wed, 11 Nov 2020 11:33:08 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8D97F8007E
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 11:33:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8D97F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="fGCU7at5"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fabbddd0000>; Wed, 11 Nov 2020 02:33:01 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Nov
 2020 10:32:56 +0000
Received: from moonraker.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Nov 2020 10:32:55 +0000
From: Jon Hunter <jonathanh@nvidia.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] ASoC: tegra: Don't warn on probe deferral
Date: Wed, 11 Nov 2020 10:32:45 +0000
Message-ID: <20201111103245.152189-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605090781; bh=umwC4KXImamx+HDRSlrnQ73F0EgY86+D9nhOjECGVGg=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
 b=fGCU7at5YjtTsspyHCZlXxfGrWS9+bUSh19oedTijGoL3nYcalSftka7k+pHzJcQz
 Eu6acrnohu2Q8bKj7IAn007FtHpy8wm5r1vr9i1txDp1GGPItlEkM1KJUWE11g8zEN
 RzSiFl9GBk8fdnrekTC6lZdeUl4m0dnNy4x4jKgVn1LeBBDQJPwtJuGsgMwoYJ0q7g
 o87J6Ha0XPXu93O2sGuB9sFbVHKbQR4NNOP/dMxNejy8i+GyCoWqq6S4IB0/tcRqjJ
 O0yIrBsVCVzmdDZL64jJdjyAOhuvgCk+nxwPnOyPu/hfHzXd4XiepzTPeqC39RlG5a
 akLMSgZ74+k7w==
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jon Hunter <jonathanh@nvidia.com>
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

Deferred probe is an expected return value for snd_soc_register_card().
Given that the driver deals with it properly, there's no need to output
a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra_alc5632.c  | 4 ++--
 sound/soc/tegra/tegra_max98090.c | 8 +++-----
 sound/soc/tegra/tegra_rt5640.c   | 8 +++-----
 sound/soc/tegra/tegra_rt5677.c   | 4 ++--
 sound/soc/tegra/tegra_sgtl5000.c | 4 ++--
 sound/soc/tegra/tegra_wm8753.c   | 8 +++-----
 sound/soc/tegra/tegra_wm8903.c   | 8 +++-----
 sound/soc/tegra/tegra_wm9712.c   | 4 ++--
 sound/soc/tegra/trimslice.c      | 8 +++-----
 9 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc563=
2.c
index 8661877bf4c6..0a0efd24e4b0 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -203,8 +203,8 @@ static int tegra_alc5632_probe(struct platform_device *=
pdev)
=20
 	ret =3D snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
+		dev_err_probe(&pdev->dev, ret,
+			      "snd_soc_register_card failed\n");
 		goto err_put_cpu_of_node;
 	}
=20
diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98=
090.c
index 9d8e16473ab9..00c19704057b 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -247,11 +247,9 @@ static int tegra_max98090_probe(struct platform_device=
 *pdev)
 		return ret;
=20
 	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "snd_soc_register_card failed\n");
=20
 	return 0;
 }
diff --git a/sound/soc/tegra/tegra_rt5640.c b/sound/soc/tegra/tegra_rt5640.=
c
index c73bd23b3d67..9afba37a3b08 100644
--- a/sound/soc/tegra/tegra_rt5640.c
+++ b/sound/soc/tegra/tegra_rt5640.c
@@ -193,11 +193,9 @@ static int tegra_rt5640_probe(struct platform_device *=
pdev)
 		return ret;
=20
 	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "snd_soc_register_card failed\n");
=20
 	return 0;
 }
diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.=
c
index 7504507dd8b8..d30f8b6deda4 100644
--- a/sound/soc/tegra/tegra_rt5677.c
+++ b/sound/soc/tegra/tegra_rt5677.c
@@ -268,8 +268,8 @@ static int tegra_rt5677_probe(struct platform_device *p=
dev)
=20
 	ret =3D snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
+		dev_err_probe(&pdev->dev, ret,
+			      "snd_soc_register_card failed\n");
 		goto err_put_cpu_of_node;
 	}
=20
diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5=
000.c
index e1dc8e7d337a..885332170c77 100644
--- a/sound/soc/tegra/tegra_sgtl5000.c
+++ b/sound/soc/tegra/tegra_sgtl5000.c
@@ -154,8 +154,8 @@ static int tegra_sgtl5000_driver_probe(struct platform_=
device *pdev)
=20
 	ret =3D snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
+		dev_err_probe(&pdev->dev, ret,
+			      "snd_soc_register_card failed\n");
 		goto err_put_cpu_of_node;
 	}
=20
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.=
c
index fa41fa366daf..efd793886689 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -156,11 +156,9 @@ static int tegra_wm8753_driver_probe(struct platform_d=
evice *pdev)
 		return ret;
=20
 	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "snd_soc_register_card failed\n");
=20
 	return 0;
 }
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.=
c
index ef6652aaac9b..e4863fa37b0c 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -352,11 +352,9 @@ static int tegra_wm8903_driver_probe(struct platform_d=
evice *pdev)
 		return ret;
=20
 	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "devm_snd_soc_register_card failed (%d)\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "snd_soc_register_card failed\n");
=20
 	return 0;
 }
diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.=
c
index 726edfa21a29..4f09a178049d 100644
--- a/sound/soc/tegra/tegra_wm9712.c
+++ b/sound/soc/tegra/tegra_wm9712.c
@@ -117,8 +117,8 @@ static int tegra_wm9712_driver_probe(struct platform_de=
vice *pdev)
=20
 	ret =3D snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
+		dev_err_probe(&pdev->dev, ret,
+			      "snd_soc_register_card failed\n");
 		goto codec_unregister;
 	}
=20
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index baae4cce7fc6..6c1cc3d0ac33 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -144,11 +144,9 @@ static int tegra_snd_trimslice_probe(struct platform_d=
evice *pdev)
 		return ret;
=20
 	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "snd_soc_register_card failed\n");
=20
 	return 0;
 }
--=20
2.25.1

