Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A6C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 11:27:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29EA3221FF
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 11:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G64VCZiL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5bBWmVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EA3221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71200174B;
	Tue, 17 Nov 2020 12:26:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71200174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605612437;
	bh=O3KvBIO1LSAMMzRBSURMoee2oAidevgBH4STXLE8dPw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G64VCZiLgA2f7MUYAR4qVvPqYEFrc3cFHjnledZ+dXbF6qwXIJUbMx+B+FWfrU0yn
	 DmZavXlLH+aOAAmCdA6AbORwBcDWDgdaxSeDF5Tr4VYPuhN76Ps7M7yINjncAbuyDM
	 AeTOr5SNfmdRbWyZZBhcTrCc7XJK6KDJtSpz+Ds0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1F0EF800E2;
	Tue, 17 Nov 2020 12:26:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53599F801F5; Tue, 17 Nov 2020 12:26:25 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFB76F800E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 12:26:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFB76F800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="O5bBWmVT"
Received: by mail-pf1-x444.google.com with SMTP id q5so17092266pfk.6
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5QH8l3HzZjblS+KPiXb77NBbNTh6S8myLIAJDUGNsj8=;
 b=O5bBWmVTPEBh/wG/pGQE0dEyVrFSP9Ty3BF956K66kZY8Ga5Bv0ZO+dPKZdFwQnUU6
 8Re+odTtvmBPW/Pe/ey4gvN2NwnMSTVjO0THOf/mTGSSmHPJE1u1htYGpGgjUweZl0hu
 Y3d/hvn8/ZvmSbXbLF2FhktSTDJEfHaB5FbPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5QH8l3HzZjblS+KPiXb77NBbNTh6S8myLIAJDUGNsj8=;
 b=Efk2aYGm+5QvsFx23Y0uM5WZEmNvbQ6h26C2t+fBXSiyjIGEDJTH1lB+JCCGf2DpAh
 mrjskD25uLEgfH0vNbtxd58pJjNPdYejqzN209ZGRx62ma7WxqvWPDJzuZekuTEuqbNO
 hiA1QWoKIiywUqSos6ZlEuaPHVNtLT/XbPU9QPHlREw6NRdxLeqKiytpsIt5FrdUZYzK
 BPoFjb4ygYsh4vpilRAbRTIzbXCm42BQ4t2wyZUDb8Ye1IRDpwkddJLTslt/NnEE0cH1
 EpyEK4vgikdBzsDIH0Exm5+jn6LtLuwBpJTbovVSdGouPvfI/icx0MWhMfv5rfdhmeUM
 DLBQ==
X-Gm-Message-State: AOAM530xEz/rMndbcWj4802ZxDlpSLgmKlJ64mYq5lMAIoSLG9H2OLwx
 i9pDtsrd2CeRx9n8COVCDAOaTA==
X-Google-Smtp-Source: ABdhPJyrnAjBQ/jtFgnI1ZSF/1TLY+kjZEhSgcrRqfC80FgaKc4a5J8gFviPhqMlAnXOMeI4QK8f7A==
X-Received: by 2002:aa7:9414:0:b029:18c:23f6:bc6d with SMTP id
 x20-20020aa794140000b029018c23f6bc6dmr18205106pfo.21.1605612370295; 
 Tue, 17 Nov 2020 03:26:10 -0800 (PST)
Received: from localhost ([100.102.99.29])
 by smtp.gmail.com with ESMTPSA id t20sm2843368pjg.25.2020.11.17.03.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2020 03:26:09 -0800 (PST)
From: Cheng-Yi Chiang <cychiang@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdmi-codec: Get ELD in before reporting plugged event
Date: Tue, 17 Nov 2020 19:26:03 +0800
Message-Id: <20201117112603.210620-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, dianders@chromium.org,
 Srinivasa Rao <srivasam@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 tzungbi@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, dgreid@chromium.org,
 judyhsiao@chromium.org, linux-arm-kernel@lists.infradead.org,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

In plugged callback, ELD should be updated from display driver so that
user space can query information from ELD immediately after receiving jack
plugged event.

When jack is unplugged, clear ELD buffer so that user space does not get
obsolete information of unplugged HDMI.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/codecs/hdmi-codec.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 403d4c6a49a8..f0e0e1836000 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -692,10 +692,16 @@ static void plugged_cb(struct device *dev, bool plugged)
 {
 	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
 
-	if (plugged)
+	if (plugged) {
+		if (hcp->hcd.ops->get_eld) {
+			hcp->hcd.ops->get_eld(dev->parent, hcp->hcd.data,
+					    hcp->eld, sizeof(hcp->eld));
+		}
 		hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
-	else
+	} else {
+		memset(hcp->eld, 0, sizeof(hcp->eld));
 		hdmi_codec_jack_report(hcp, 0);
+	}
 }
 
 static int hdmi_codec_set_jack(struct snd_soc_component *component,
-- 
2.29.2.299.gdc1121823c-goog

