Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8872EC54754
	for <alsa-devel@archiver.kernel.org>; Thu, 15 May 2025 07:37:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1176E61A8F;
	Thu, 15 May 2025 09:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1176E61A8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747294305;
	bh=4r9tJ+EcKTSeTDqTruse8d4E3SvZHkJ5ztPCJLWlUSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=u4tGh0nkOYd8uQ8IyqK5Hw3mLm58YWiD39bBmDcuiZJq2mRKuWvQhaT4u+MPdlWOp
	 DOAR3acyb57XdbvwpA2JQxHxtOIWIcBBEyWR6XOpQVVPnsI72imHRH+aDZbQR8uV6M
	 0WX+vy6aJmsiwLUVN6Ay0eReulm6M3ZTilL1Oyoc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D4F9F80C90; Sun, 11 May 2025 16:32:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22DFDF80C7D;
	Sun, 11 May 2025 16:32:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A80BF95BD7; Fri, 25 Apr 2025 10:07:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7AE7BF8E231
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2025 10:07:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AE7BF8E231
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=fairphone.com header.i=@fairphone.com
 header.a=rsa-sha256 header.s=fair header.b=Wp8VWrQV
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so1478140f8f.0
        for <alsa-devel@alsa-project.org>;
 Fri, 25 Apr 2025 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1745568453; x=1746173253;
 darn=alsa-project.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+B51z9x2y4YummWOIXlfsBUwS8WF++0rEKHeNnV0Us=;
        b=Wp8VWrQVsNoof9Z7j3/xeoYITbTfo2Kz8hV9Hwgf4DnmQoBK1MQuc95UvEBBDD8EYM
         cEc/sATSW3zwDPqzh6w/pGAUfH5oDQNeV9AaHuuEZZij55/kmHfCHm4fCbjQe1ehp300
         aLNNC1I4ylOwbm2Eqd5Dle4ZC+lg6As2nBxVKL7ki9rlLeMvA8VygdFaCgfwXQkfImQu
         KbpA3w6oFNtaOresbx4BZuhOc6Y7qr3/Gn2eJsPchCitmyILzgsYyAqRc8P8A0o9zpqg
         FXEDk/M2VKu8wryXYMpksp6jn/mfASq+2mg5IVa1qPQAxXiFAyNIq0sWzXz0nXGTo6yo
         BVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568453; x=1746173253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+B51z9x2y4YummWOIXlfsBUwS8WF++0rEKHeNnV0Us=;
        b=o854FlmmEdzLzXqhkX+ootXzBM57JjkI/mK3iyi8rSbL8NT29HRvAMcOzrlkAbAkCO
         uukS0PFFH0sMv3DfJ5AtrsX0Ij3O2W87qQFcsMHNWOMgbu+qvPVxbJ2esgeCsBeWd1w3
         TD1djFmH9XNtoKRF4W5br0mKNtv4Tp4BG8gfdjoV312i5hx7n0bBs3xRmU4D29qh4ABV
         WXdYnWhTPJJMd473PcL7i9/TSWB/jt58Bg40klLvtGRnKC8uYoCBb//orwbeUFUshYa0
         8YqCEwgHr0DBd1jlaS82Wqxs+WIuoMMqXOVNIs9pem8OGODAvYmJzKbFJoU6OphDZWSr
         XTuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwAkap/n+PYtSpE7+AOSQ+Ygx1wQVHaZytXZkedTxa+kVraYANaUnkQrC1K+YOG/Y3OuFvxB3vc+kW@alsa-project.org
X-Gm-Message-State: AOJu0Yw1g+Xh1UIMJjEqv4kHMhE6ziOpWvOy5zBBw0uPfi+wjXkA2S/r
	YRqkxixm0J0K78fLmT9kAAlgqGcRsjRMrR8N2tUmUCIGBy9aYRPpDK5u3QOtoMU=
X-Gm-Gg: ASbGncsbNRFhC+GLAM+tdusVoyN4aLcoGj/HAwhMbBhCOxXH/N1Fpksj4sTvC1kMgZn
	rDAvcIB1U7kVZDOctn7zIFijbx6yFY0UjEBMiFLWgho3NlG1K5REDOEKLbzREffrifuS8kKw56y
	qnz6+aV544cBJfouxy9LxVUTAO0JxsDwEeo83rdu2xzC6iWk8qS5y6lb30vqO2oFo2115/hXSaW
	HPD+7O7hEthEvrr2dPI9sU2WWG4hGFHE2zfoW+yR4pipQqke2aQbzo0vEgbH/VnebmLvjBge7az
	AAOoaQ37pWCoe+jtqvy1cycVR3RbCInOTr/vYWfQdWfL0hJGB6+fNyMoMhPyYmoWKM5lWhKYNqj
	FpsGhrXzF1BJqLYGLektOHstYPAFJN78O14DdTsyqq/EPI0OIuXnBuzn+
X-Google-Smtp-Source: 
 AGHT+IESPkwoSXL9H158Zipa+9IfMAIxHeKuyCQjlKcULNXaCkr05UQj4rmsW9F9V/zyF5XpgSj7jg==
X-Received: by 2002:a05:6000:2485:b0:39e:e588:672a with SMTP id
 ffacd0b85a97d-3a074e0f0c0mr971220f8f.7.1745568452582;
        Fri, 25 Apr 2025 01:07:32 -0700 (PDT)
Received: from [100.64.0.4]
 (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at.
 [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e461casm1593513f8f.74.2025.04.25.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:07:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 25 Apr 2025 10:07:25 +0200
Subject: [PATCH v3 1/5] ASoC: dt-bindings: qcom,sm8250: Add Fairphone 5
 sound card
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-fp5-dp-sound-v3-1-7cb45180091b@fairphone.com>
References: <20250425-fp5-dp-sound-v3-0-7cb45180091b@fairphone.com>
In-Reply-To: <20250425-fp5-dp-sound-v3-0-7cb45180091b@fairphone.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-MailFrom: luca.weiss@fairphone.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: OJCMI2YILBD7OJ7DQFIIZIK3EDJCLATC
X-Message-ID-Hash: OJCMI2YILBD7OJ7DQFIIZIK3EDJCLATC
X-Mailman-Approved-At: Sun, 11 May 2025 14:32:09 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OJCMI2YILBD7OJ7DQFIIZIK3EDJCLATC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Document the bindings for the sound card on Fairphone 5 which uses the
older non-audioreach audio architecture.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 4e208cb7f6c61adfd4b687227038d275f849480a..57f62a228c262f38e703816efdcf443355052619 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,sm8750-sndcard
           - const: qcom,sm8450-sndcard
       - enum:
+          - fairphone,fp5-sndcard
           - qcom,apq8096-sndcard
           - qcom,qcm6490-idp-sndcard
           - qcom,qcs6490-rb3gen2-sndcard

-- 
2.49.0

