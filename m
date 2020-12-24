Return-Path: <SRS0=BPvr=F4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F69EC433E6
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:08:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964CF221EB
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Dec 2020 10:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964CF221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8C4617EB;
	Thu, 24 Dec 2020 11:07:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8C4617EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608804496;
	bh=toafuJ03EiDZ6CbDny/fE78PxW4mnQQMn2CF5j95t4M=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nuk7FyqN0y3s16Hx9J2TXo0GgHwr1yt6FwC0t+HqSAljwMQi8+LTCty24d6nf1qNr
	 YycsMFnGxYHQKytHN3h6C9g/pk633qc9FNB5oJsRZmS6MtYAm09sAj2YafHGcewQlN
	 83jMNqPsY0agiOX7akyKpjyQ49OlCs5T8YCzvI98=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21865F804BB;
	Thu, 24 Dec 2020 11:06:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 476AEF8023E; Thu, 24 Dec 2020 11:06:26 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25BDDF800CE
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 11:06:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25BDDF800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="dSBjK7Bj"
Received: by mail-yb1-xb49.google.com with SMTP id j1so2717568ybj.11
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2020 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=yrNMV8ZIBx+GbIeepiPn7ci0CTXODCE+VcJLXlRVrCo=;
 b=dSBjK7Bj6usn3j+JLJ39oIOp8+wI8ut4IAtEflfTfrVsIdUa/0Xvdz/lS47FVT81BU
 9/O7nRD2WQVw7camoeR3q+mvxXVwX7eI6saXG24AVIRQCKSzHUFj7+d3HQU+jAJ32D3b
 8M3Q2xoinjYfFUCGSczeSIJjiaKa9g2zl/BkKmodhmi/SPpZPq9L6TisnW+0HYigS0kG
 0qK94zAt8nTYGOicAG9iN7IH0rfCIitP+VOlo8EtXfhwfnUEDxeFCwi7MMn1fzdg9Z0o
 BxN7pi8dUkeRKcW7xOy8hVpGzvWQNxEn6i9TmlaMIyxwc/1HrQfoBz+eylerv8KodkdC
 BMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=yrNMV8ZIBx+GbIeepiPn7ci0CTXODCE+VcJLXlRVrCo=;
 b=s7/3w50ZDAq7EZ4n/PZfx4ONLG6IuOk/O1DKw5xA0+7lFg4h/CEHeAHGvm4YU9tZnb
 2k7NCnKhSIgmhn1TPcvCs0TYfPrvkTyi5z47JY2UtTYwWhKFNhpeTZ8E/WVVlCWwc4RL
 L2ebJy881w2yDo/0uq1g1oDfJGcnfhOvzSV1AP7FAevKxhHgiSTPuG5b7ekW5bcWq++0
 c1Z+KHL1hS1en6UtARIUo9SpexBJxe7COX5g/YRotLjNKliEhv5O4a9ryGnt+Dc21vl/
 8kuBs9IXJmYryyW/gsmMYIJsCQrtxpkWjwewJ8hrxyHIX+o/GdHF4Fgypmv399XWN+mf
 2qIg==
X-Gm-Message-State: AOAM533bF8A3ZbtxLChXAn0aaAakTgwqDaDkHrUCwNw/E67e8qe6OxLr
 PvUOwGepAzB8lpGtUjfLOqbqG8tOIQdT
X-Google-Smtp-Source: ABdhPJw/INHqt/AJcIwc9GpCaVWo/LOT2Joexym9YJxs+wq+S1qafTFwfkn05GNbBXt/x8dn9A/RHIkPR1WD
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a25:5c2:: with SMTP id
 185mr40617523ybf.161.1608804380703; 
 Thu, 24 Dec 2020 02:06:20 -0800 (PST)
Date: Thu, 24 Dec 2020 18:06:04 +0800
In-Reply-To: <20201224100607.3006171-1-tzungbi@google.com>
Message-Id: <20201224100607.3006171-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20201224100607.3006171-1-tzungbi@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 2/5] ASoC: rt1015: save boost_mode only if valid
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

Saves boost_mode only if valid.  Also returns -EINVAL if it is invalid.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/rt1015.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 1a29d3d5263e..696e00478991 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -444,10 +444,9 @@ static int rt1015_boost_mode_put(struct snd_kcontrol *kcontrol,
 		snd_soc_kcontrol_component(kcontrol);
 	struct rt1015_priv *rt1015 =
 		snd_soc_component_get_drvdata(component);
+	int boost_mode = ucontrol->value.integer.value[0];
 
-	rt1015->boost_mode = ucontrol->value.integer.value[0];
-
-	switch (rt1015->boost_mode) {
+	switch (boost_mode) {
 	case BYPASS:
 		snd_soc_component_update_bits(component,
 			RT1015_SMART_BST_CTRL1, RT1015_ABST_AUTO_EN_MASK |
@@ -471,8 +470,11 @@ static int rt1015_boost_mode_put(struct snd_kcontrol *kcontrol,
 		break;
 	default:
 		dev_err(component->dev, "Unknown boost control.\n");
+		return -EINVAL;
 	}
 
+	rt1015->boost_mode = boost_mode;
+
 	return 0;
 }
 
-- 
2.29.2.729.g45daf8777d-goog

