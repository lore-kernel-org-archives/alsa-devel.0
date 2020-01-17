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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD45C33CB1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:41:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16B720748
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aR8DtdH6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PbAZkuBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16B720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE7C217D9;
	Fri, 17 Jan 2020 08:41:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE7C217D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579246911;
	bh=n1gEAB8esWxh4DROqntOufoMT1Mlqq/7jfgjJl3r3do=;
	h=Date:In-Reply-To:References:From:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aR8DtdH6f+LfOtQplqAqs/7uQK57G3/D7jO1kLKp8jYfsOYMgDgExGqdb0jpQh6ZD
	 wFf2D4RwYgDWBdmTDMGuaBF5VdLvrix35X/mtByMpvzDC8CCJKkQyb1GfPHzAwCIUc
	 ou1EUv59hk+VOJ7eCHSfGfLljJalLh2+G7M+ddUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CC31F8022B;
	Fri, 17 Jan 2020 08:38:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61868F80278; Fri, 17 Jan 2020 08:38:41 +0100 (CET)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88D62F8022B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 08:38:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88D62F8022B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="PbAZkuBF"
Received: by mail-pj1-x104a.google.com with SMTP id c67so3866138pje.4
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 23:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=fEQgEpr0/A25/r1nOsA8ZhWThQeI4230hbMRX4R83Mo=;
 b=PbAZkuBFURa/hveRCXlpL83F8tQ2IXzDfrzMRXg8qw8u2nmoyhgc9OZhfzW1pph2Dx
 0eZfAWq7XUQnomYPldGCGfY4i1DKydaQ84ffmHlCNgF2PxbsV+9t1HYv3sa8aJ1gSMvo
 /N4LIQsyaiJjxyATvjlYZExSxdGQwTXPDQ8TWOJvogS5wGNplhEKsQil19hHpMwE6mHe
 rMnLCzTonk/Yr2jNIGbExFpTBydvHzZAbGgjHGFBzXybrChMjmkZGFwwH03ywcxZqffw
 kXP6nwXlAkwJElHhdVQdjNcRevWFryAmszkJB/QN2rlRUXl9u/knbW/g+i0YpiFRr82b
 IVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=fEQgEpr0/A25/r1nOsA8ZhWThQeI4230hbMRX4R83Mo=;
 b=mBmol7xKa+FH4izFu+ZnwqjKbJOSNZ1xuTNgcIG1u4u9ETz6hDHC/N9ZxC/3xRG7r5
 f7uNcwotplt9imbq85weB7YOEZlijkV/RFVUXnEgjw9gz/GTfO0vT3TNNyUdIJSYnSu1
 7vgtnGekYw/mmjTIrQIexQmqI/PzLSsX3AoOyAJ+xgjB0+bRZRCs+maiVOh0MPlPgsnx
 AC4pYKfTHfBMgqvKM5bqxiCKhymnxBI8rYYCJm0gtOQ6BVfdG6MC8dsrLIeW2ZlkWOpC
 +eYYsYx4VLicsp/CTk1QieN6r93t3s2Q9HRO4ITtWbs6q4Rf11UvYejhbvYiTYOmG39y
 Dlsw==
X-Gm-Message-State: APjAAAXjNpS5B9Crz0c+dEHieby9/a8Mg7reCquwIOPK++7M8iDnl8yN
 5iMOrZ+kr8SyS8gNy+1QQN58SycCbk2v
X-Google-Smtp-Source: APXvYqy6Pmu+s6quw7wUfHZScWLZXSCbWCBWS/cXxpUSiIFV1B+T5AwV8opAQtw4EMD4if58hO/u4uchgzHu
X-Received: by 2002:a65:66c8:: with SMTP id c8mr45913038pgw.161.1579246715490; 
 Thu, 16 Jan 2020 23:38:35 -0800 (PST)
Date: Fri, 17 Jan 2020 15:38:14 +0800
In-Reply-To: <20200117073814.82441-1-tzungbi@google.com>
Message-Id: <20200117073814.82441-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20200117073814.82441-1-tzungbi@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com
Subject: [alsa-devel] [PATCH 3/3] ASoC: max98090: fix deadlock in
	max98090_dapm_put_enum_double()
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

Commit 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when
changing sensitive registers SHDN bit") uses dapm_mutex to protect SHDN
bit.  However, snd_soc_dapm_put_enum_double() in
max98090_dapm_put_enum_double() acquires the dapm_mutex again which
cause a deadlock.

Use snd_soc_dapm_put_enum_double_locked() instead to fix the deadlock.

Fixes: 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing sensitive registers SHDN bit")
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c01ce4a3f86d..0313e1183167 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -88,7 +88,7 @@ static int max98090_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	int ret;
 
 	max98090_shdn_save(max98090);
-	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
+	ret = snd_soc_dapm_put_enum_double_locked(kcontrol, ucontrol);
 	max98090_shdn_restore(max98090);
 
 	return ret;
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
