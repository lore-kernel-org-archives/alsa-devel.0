Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0656CC43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:54:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E12D2601EB;
	Tue, 30 Jun 2026 13:54:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E12D2601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820459;
	bh=lEytILmpt7fOGcKrkSoaWxUtUVYjRYZbpNj45BMNlIU=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Y/ItFuPlX0qfVPjC4kwk49e5iF1DHHAFKNsemy79cO7qNqdi99Luh6FbkJ5NT/9Jw
	 OAwKf6qIR448pAkhOQb4lvlO+Flpwi9Z8bIDRRruAGmPBQKsFXYZaCeTRja7ngwWuG
	 EPjPTe9jH8UOXBtyFoxFZTiBefqk3r7ecMrvswgg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B55C1F80621; Tue, 30 Jun 2026 13:53:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23D5CF80620;
	Tue, 30 Jun 2026 13:53:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD974F80579; Tue, 23 Jun 2026 19:13:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782234811;
	b=jAlcKJP+6D8BggGRcHV5iwnNEKVaYH4HF/YqpiTLUIdgmBOL4eqzpD9xl4gNY1kgk3+H
	 r0dFiyDkXlrZeZBZaQAlFEsbvGvCr/fJsUo859l1k+yrxHaO+tmm5RQt/jOtHdREqEEHe
	 44JH+SjEpfCWx4DsP9h9DiwhuP+1RHqLK5boWSitAG4Ovd0JeZ7/O0iV08r6lgX5dR8Hd
	 uDV+E+P8z4w4xiutlBolUMxcqr8TAK6Oc5ruJo0L68ikPT0sYiZgtaK+cMS+WPMn6ojJk
	 PaxdzvJyrZzAC/TQRmMndG6TWdW/BuX30+MDPf/oEB22gUdUH7AZSd31BRvXmry0TgQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782234811;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lEytILmpt7fOGcKrkSoaWxUtUVYjRYZbpNj45BMNlIU=;
	b=X3KEydhI4VWbv0M+nqKDzI6UVIz+JPI8fAP6BgC4u9T7WsgSS5+hrpEqTxZGW4j5sqw5
	 6z6Lq7BxkP56YXpcFJ5OkMcISz1B7tXORQC8eDI2aMC2FEWjcG2Kc/Oa50oSJ0JGB02L2
	 yShJYItS4xkSJxhlE85CRRTd5TpbbwloeB5OAXqR8OcLJcCcE/JqU4ESToFDkHhApWVsO
	 Q05m+K3RxljdmxzyWh/59rtb1UEPSjsdFlrJtAzYAVw4QnIr/tA5IrzAD+vlZkqmJ7/8O
	 tobLPecFuf5ayupn62FugV/uwtzHtSOVKLSMsEUjRWrfKPR+b1XjiHvwGS5u+X22/XA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=digiscrypt.com header.i=@digiscrypt.com
 header.a=rsa-sha256 header.s=google header.b=E+LGqpYu;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E7FCF80424
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2026 19:13:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E7FCF80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=digiscrypt.com header.i=@digiscrypt.com
 header.a=rsa-sha256 header.s=google header.b=E+LGqpYu
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso636565ad.0
        for <alsa-devel@alsa-project.org>;
 Tue, 23 Jun 2026 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1782234807; x=1782839607;
 darn=alsa-project.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2fdThPLw4069+ChQ4aX9THIXeJhuFpX1Wqly5R4NnJY=;
        b=E+LGqpYuvjJi/BPQSqi/dI4vnwQBv8PEsvHXmMIrb2KtZV5ZDSAfBrzRJhjP5LG9Ku
         UOHC5mJkS/UhHEsLhCuv+oLwaf+yFeASffhiYgvOaVCWEYiJta3XFpk+F6KAKGDiXA9w
         0WDauk8SEnzghBRFxyPkV0P7guJGPd5Wc7UH9gUeVMIb37XjZkJP/nwpaq+yVlogyp0Z
         ad81JF2ZWbFnBUzVDnNcVCzeltparhQAgm+wDAwnQMz1ZJJQDTU79710dwPvxmU/mhWh
         wcEzagBah76GFhCoxEQT+NMuV5cj5BsSXFFp50VWcVqhNWSly0+rZMmHac5pQe/j8g4W
         NguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782234807; x=1782839607;
        h=mime-version:content-transfer-encoding:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fdThPLw4069+ChQ4aX9THIXeJhuFpX1Wqly5R4NnJY=;
        b=h11uUZLU8vy5058tyZLsF1TC2PFy0bhje5v8S1QmWdn2iKvuG1ZtSfWVfjT3ZEA2kS
         Ku4uJ71GU9zE/tBF7bbkdtFkmoH0BOv4IuRtQlEVqcPc+CRl0JBtonwgWGE/dquGKsAB
         H9utQKXOjQRnWoSLw8i0yRi5Hq+WIRRxuFLNhYJaTjy5DT09lS8Niqn6BbT+z1KoAnbi
         kc2rMTF4PEcWSRkaTAIFWmuJHnASuqJgGfpRI5kb11pEDah1YPaw09cqYXBNzH58wtas
         Vpj2v40N1gZKWjW7rSfd0lddjoxNmONIdOltV+SEnZ8QRXnJWlYM1o99q8zWJxMWmQ4C
         6QPQ==
X-Gm-Message-State: AOJu0YzK1agg8rmTldfEIVtQ4QDeXuTJIIx6ZK4468dxgjmbSG+KmOck
	Soz6pwsUlmsdqX95iBs5YhTLH45alQFKB19Zr5aynlk1dGT3Zd4CUiRLC/rJG+gZTaTt6YCvnkT
	o8M93na6tPPw=
X-Gm-Gg: AfdE7ckUkXD8Fss45xPh9SlI3EMSe8cid7Ohpr3PqXzTchOyxIUPQAJmAKCXv3dqiyC
	TPekxMh+Jz0YkO87Pi3ACHaFdanLts5YlQBB6y0C8rpb+zQitHmU/cctaf5z5GeD1OOduuNJdJC
	18lNErH7frWguJQqie5d7kDOZK+c3vTv7evfRxINbuP+cI1Gc8ayBeAYYBuPs99Osz19AyYthfB
	KsH7t+yUninpYllgSdXMXfJ9aDyjxccskUWDnOlAUK0zV7mRVoyrsgrpOKpC1H89CkHwa4aAlHa
	5RR3d2vPJv9/XG4fkz0KfXo88u88cxbI2WdgVSN7Fm35G3sJ/i5m4VFKBcNCGYOd7mbDLW9akt+
	oJeB/byGQrLrTgpP5s3RJSuA1Ytw0R40/52iEOS5eXq0VwuDQ12oiYsX3H4cNrU159PkP8S0Y+A
	zjEZzoVA1Jcfi7Pqe1UMJEzzZuRP9QyPli/4TutBA6SW8nMF6tGkv7Zmj9lu7yc21nbDi57m+S6
	4jjSuQ2jXuraAGodiElN9CfmPp17bvF0W7+BOz8p28=
X-Received: by 2002:a17:903:4b4e:b0:2c6:d710:3e58 with SMTP id
 d9443c01a7336-2c742b79e68mr162330795ad.36.1782234806525;
        Tue, 23 Jun 2026 10:13:26 -0700 (PDT)
Received: from 3.1.168.192.in-addr.arpa
 ([2401:4900:1c07:46d8:110b:11b8:fb24:5255])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c743bfd9ddsm114850345ad.55.2026.06.23.10.13.25
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:13:26 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: topology: Fix bounds check for widget private data
Date: Tue, 23 Jun 2026 22:43:22 +0530
Message-ID: <178223480291.58041.7638917057876822952@digiscrypt.com>
X-CodeOps-Marker: 6ace80b0dc704f70b7449e0416eb7b0e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MailFrom: naveed@digiscrypt.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GPCJNVDJ3HXOWF3TFCXZ5A65Q364XD77
X-Message-ID-Hash: GPCJNVDJ3HXOWF3TFCXZ5A65Q364XD77
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:53:18 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GPCJNVDJ3HXOWF3TFCXZ5A65Q364XD77/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

soc_tplg_dapm_widget_elems_load() validates that a DAPM widget fits
within the topology firmware buffer before parsing it. The check for
the widget header correctly accounts for sizeof(*widget):

	if (soc_tplg_get_offset(tplg) + sizeof(*widget) >= tplg->fw->size)

but the subsequent check for the widget's private data only adds
priv.size:

	if (soc_tplg_get_offset(tplg) + le32_to_cpu(widget->priv.size) >=
	    tplg->fw->size)

The private data is located after the widget header, and
soc_tplg_dapm_widget_create() advances tplg->pos by
sizeof(struct snd_soc_tplg_dapm_widget) + priv.size accordingly. Since
the check omits the header size, a topology blob whose priv.size
satisfies

	offset + priv.size < fw->size

but

	offset + sizeof(*widget) + priv.size >= fw->size

passes validation and leaves tplg->pos pointing past the end of the
firmware buffer. When the widget declares one or more kcontrols, the
following read of control_hdr->type dereferences memory up to
sizeof(struct snd_soc_tplg_dapm_widget) bytes beyond the allocation,
an out-of-bounds read whose length is controlled by the (firmware
supplied) topology data.

Include sizeof(*widget) in the private data bounds check, matching the
widget header check above.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 35cbe29d22..3f8bdacc3a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1290,7 +1290,8 @@ static int soc_tplg_dapm_widget_elems_load(struct soc_tplg *tplg,
 		}
 
 		/* check if widget private data fits within topology file */
-		if (soc_tplg_get_offset(tplg) + le32_to_cpu(widget->priv.size) >= tplg->fw->size) {
+		if (soc_tplg_get_offset(tplg) + sizeof(*widget) +
+		    le32_to_cpu(widget->priv.size) >= tplg->fw->size) {
 			dev_err(tplg->dev, "ASoC: invalid widget private data size\n");
 			return -EINVAL;
 		}
-- 
2.52.0
