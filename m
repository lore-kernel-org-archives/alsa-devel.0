Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AF4C33CB1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:41:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A8220748
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DS+Ouf1E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OL2T1sop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A8220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5617917ED;
	Fri, 17 Jan 2020 08:40:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5617917ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579246864;
	bh=pgfXHy02GH4PLNUSufuM68Ba5ul9j4+w15Prdij8Pew=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DS+Ouf1EMhaSZ+Rid6irU4HZx7r7leCfvw6q2fLy4NGwhAeuORP2M4XkvgjkVPhO5
	 6BNCiO5mF08/HX67tRZ9ioasqwrovOITisEKrxpv8U84a9PCeO+t0W1Oigs4Esdu2F
	 hd4pxaxC83MVDXoi6JqpOd4/ngSenBQ+tNsb5dfA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53592F80271;
	Fri, 17 Jan 2020 08:38:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 674BCF80271; Fri, 17 Jan 2020 08:38:36 +0100 (CET)
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B58C0F80086
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 08:38:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B58C0F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="OL2T1sop"
Received: by mail-yw1-xc49.google.com with SMTP id y188so24606455ywa.4
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 23:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ALWThFLzftaLoQOtE1JCuOa5AGHG1TvvmMLKcLHztMM=;
 b=OL2T1sopnx6kT3Nl5K7X9J3JltuUQZvDXGF58EXeRWnQC6O0JHmTluUmqRcXU203TY
 z9AWiWceiXWIF/5D4Ybg6ghjotEqPFeLcMC0S8iMKdogpYlsWOwQmPVZzVPe2hjIj33M
 RGvOUoSLn1bFh3ozGh11+ELj6I1Hott1e5l1bukzM7Tp88+eAvYaARYk34tLwBGdleaQ
 GwDnVN2o02VrFfLVulqCCs95K3ULudgtWZjp3ZC2sT0XwAkAU12u5FNZGCWfveLMC98w
 ev40zaO/ttlY46J9EWpRmkmPrwS8qBdkmuAEDZyPkgv/DmJQORVV0tH259o5bdxYGbLD
 VP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ALWThFLzftaLoQOtE1JCuOa5AGHG1TvvmMLKcLHztMM=;
 b=mQ0i1jJq4mFJmD5lnuZ/6mMINFGgT0+wPB/2L0aXLae+e0HdYdl6xgwQIU4JD3FpFO
 ed73LWRz3qviXg3U4GkAKwj3QITIGNeGvwHW4tpVjsl57uLkntp3HHsSxNb1BzUXIX3h
 OKmFT03273enA4hlfaUrmycvMBCITAv4jY13tc6PVwgVNsyQU3jn1N3w4AYtVIEUcI48
 r4Yl95DkLtZ0gsM96ClwIXXTGDWEZxSaMytqpGvRSXoOdfkBv90RAZmrRT7FMjAXa7jl
 5e05LNBviSiYzXX1jgWZKvB9iqYxu1WxnvGBgGNSazI4XqfEmHbTM7wj159fV9A3Q3I8
 nugw==
X-Gm-Message-State: APjAAAWA8qeqSiJSCQJI+qgpFgVPq7eLNXzlC3E8WQb9hZ2Q3YqPkerj
 Bq24N0nXlN3wS/iWGFwTmk3TQI+RkHWc
X-Google-Smtp-Source: APXvYqyaCPQTKW6JuTs+e+98DyCC0fziQ5pay5SAj8h4FxuzfD0L2Pxx0PdvJCL/KwRFXUyY+Da2rNo1k2bI
X-Received: by 2002:a0d:ed05:: with SMTP id w5mr31042354ywe.378.1579246710505; 
 Thu, 16 Jan 2020 23:38:30 -0800 (PST)
Date: Fri, 17 Jan 2020 15:38:13 +0800
In-Reply-To: <20200117073814.82441-1-tzungbi@google.com>
Message-Id: <20200117073814.82441-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20200117073814.82441-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com
Subject: [alsa-devel] [PATCH 2/3] ASoC: dapm: add
	snd_soc_dapm_put_enum_double_locked
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Adds snd_soc_dapm_put_enum_double_locked() for those use cases if
dapm_mutex has already locked.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 include/sound/soc-dapm.h |  2 ++
 sound/soc/soc-dapm.c     | 54 ++++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 1b6afbc1a4ed..2a306c6f3fbc 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -392,6 +392,8 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
+int snd_soc_dapm_put_enum_double_locked(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_dapm_info_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 442846f12cd4..bc20ad9abf8b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3441,17 +3441,8 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
 
-/**
- * snd_soc_dapm_put_enum_double - dapm enumerated double mixer set callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to set the value of a dapm enumerated double mixer control.
- *
- * Returns 0 for success.
- */
-int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+static int __snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol, int locked)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct snd_soc_card *card = dapm->card;
@@ -3474,7 +3465,9 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= e->mask << e->shift_r;
 	}
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	if (!locked)
+		mutex_lock_nested(&card->dapm_mutex,
+				  SND_SOC_DAPM_CLASS_RUNTIME);
 
 	change = dapm_kcontrol_set_value(kcontrol, val);
 
@@ -3496,15 +3489,50 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		card->update = NULL;
 	}
 
-	mutex_unlock(&card->dapm_mutex);
+	if (!locked)
+		mutex_unlock(&card->dapm_mutex);
 
 	if (ret > 0)
 		soc_dpcm_runtime_update(card);
 
 	return change;
 }
+
+/**
+ * snd_soc_dapm_put_enum_double - dapm enumerated double mixer set callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to set the value of a dapm enumerated double mixer control.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	return __snd_soc_dapm_put_enum_double(kcontrol, ucontrol, 0);
+}
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
 
+/**
+ * snd_soc_dapm_put_enum_double_locked - dapm enumerated double mixer set
+ * callback
+ * @kcontrol: mixer control
+ * @ucontrol: control element information
+ *
+ * Callback to set the value of a dapm enumerated double mixer control.
+ * Must acquire dapm_mutex before calling the function.
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_dapm_put_enum_double_locked(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	dapm_assert_locked(snd_soc_dapm_kcontrol_dapm(kcontrol));
+	return __snd_soc_dapm_put_enum_double(kcontrol, ucontrol, 1);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double_locked);
+
 /**
  * snd_soc_dapm_info_pin_switch - Info for a pin switch
  *
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
