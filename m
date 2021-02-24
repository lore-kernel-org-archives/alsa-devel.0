Return-Path: <SRS0=BjaJ=H2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54FC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 21:21:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D2964F08
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Feb 2021 21:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D2964F08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D3A51686;
	Wed, 24 Feb 2021 22:21:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D3A51686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614201717;
	bh=VxDBajqe59UilE9eIhMEvf8RiKI6ZylnGsqaNHA61ak=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fwhsHCcBDeputjOGBjmtQDDDuRwIE7hW+GNkY15SpCOSrH4QMRgiLtH0kXMoBRBmP
	 RET0r0ev5CQn2M2QtBTTbx1L9m2itUQZDFKQo91XXJaUE0V+DoVwbR+bEY23x45zF4
	 h5ZFNAfQH9vQbWkWl5rcjT5V2FWAaIHdBP3NDXzM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16DCEF802CA;
	Wed, 24 Feb 2021 22:19:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A563BF802E0; Wed, 24 Feb 2021 22:19:38 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3D9FF80234
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 22:19:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3D9FF80234
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BRabxy4a"
Received: by mail-lf1-x12f.google.com with SMTP id v30so5262799lfq.6
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MM8lRVTEi67ROhOzPrn24FSX21U5wxP/r4L8+ZdPQ2g=;
 b=BRabxy4aR3qNWGDNKy3hK0gY0gFXnJR0fLQXsES4dfJC3gH+kwao5Y5kiVzz7mRakF
 BL/3QxzgXoz7JFnZq4pNyIFpAk+SWLkbybNf5e3xUGO6SeVwE4iKZ1DztwkrNp2/cwVH
 Gj9NVrmH9r8azQvgenXXcjBuNrgx3BM38VjAh8yB7WtmQ59EXqTC6AxLm62G4LVrNILf
 tpA28ESjBlIyORjEa8kjG0GbpbMBirxhMV4Jgbu396lfDszujOSHPC5IJXhCva4i66fx
 sb8HACSVmFO5AK++R+3h/FcevUKkA0/y+K3tkJwFEJsQTswYmAGA1Ev2bchlhrp5cSrX
 zoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MM8lRVTEi67ROhOzPrn24FSX21U5wxP/r4L8+ZdPQ2g=;
 b=Ajn/gMkYZanKrRV3sHP+8Aw6iMflwwP/yOdqueTt57pYX3aHbDSNi9KGvKXk8KmP+s
 WW4W+MQ+eXlnH/Qh7poRG56RKTAFW+P8MHwaWws+dYMacMHBve035n68j6DaaQk02ZFH
 ZWI2ntKuvDNarrAOh94GP/AXqD3KUZVNFOUNnuZT5YU6oagG0KM7hydIU1e3bhbQXh9A
 Ju2RWKQpuLeUmnY4HU4wVYsfktDTyQkU/DUBbUhR/wny1rWwIyd5mDIUvJuG7OLm86Ad
 +cCM3X2eRiBmtSe2nNMxi8O3XFuAlOMgQzQ8/14leSi8TajbDYlcs9S2oYPsTEp2lzHG
 7+CQ==
X-Gm-Message-State: AOAM531tNfauZ1GchTRodUR155mzdBXWbkxFoHYQPVJsEaMF4KrkdMT1
 g/SdbcVIIgnmp+s7XghQzRQ=
X-Google-Smtp-Source: ABdhPJwyFbVVquaVbhPQJW6vmosdTHqeGskZgmaphUjB0Q2E3UAyaegpCAeQfUF4bdAJshkYrdBxxA==
X-Received: by 2002:a19:f60c:: with SMTP id x12mr11290410lfe.156.1614201566034; 
 Wed, 24 Feb 2021 13:19:26 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se.
 [98.128.229.129])
 by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 13:19:25 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/4] ASoC: rt*: Constify static struct sdw_slave_ops
Date: Wed, 24 Feb 2021 22:19:15 +0100
Message-Id: <20210224211918.39109-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, linux-kernel@vger.kernel.org
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

The only usage of these is to assign their address to the ops field in
the sdw_driver struct, which is a pointer to const. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/rt1308-sdw.c | 2 +-
 sound/soc/codecs/rt5682-sdw.c | 2 +-
 sound/soc/codecs/rt700-sdw.c  | 2 +-
 sound/soc/codecs/rt711-sdw.c  | 2 +-
 sound/soc/codecs/rt715-sdw.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index afd2c3b687cc..1c226994aebd 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -594,7 +594,7 @@ static int rt1308_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1308_slave_ops = {
+static const struct sdw_slave_ops rt1308_slave_ops = {
 	.read_prop = rt1308_read_prop,
 	.interrupt_callback = rt1308_interrupt_callback,
 	.update_status = rt1308_update_status,
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index b49f1e16125d..0b7ac74e671d 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -683,7 +683,7 @@ static int rt5682_interrupt_callback(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops rt5682_slave_ops = {
+static const struct sdw_slave_ops rt5682_slave_ops = {
 	.read_prop = rt5682_read_prop,
 	.interrupt_callback = rt5682_interrupt_callback,
 	.update_status = rt5682_update_status,
diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index 4001612dfd73..ff9c081fd52a 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -430,7 +430,7 @@ static int rt700_interrupt_callback(struct sdw_slave *slave,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt700_slave_ops = {
+static const struct sdw_slave_ops rt700_slave_ops = {
 	.read_prop = rt700_read_prop,
 	.interrupt_callback = rt700_interrupt_callback,
 	.update_status = rt700_update_status,
diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 2beb4286d997..8f5ebe92d407 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -431,7 +431,7 @@ static int rt711_interrupt_callback(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops rt711_slave_ops = {
+static const struct sdw_slave_ops rt711_slave_ops = {
 	.read_prop = rt711_read_prop,
 	.interrupt_callback = rt711_interrupt_callback,
 	.update_status = rt711_update_status,
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 71dd3b97a459..81a1dd77b6f6 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -488,7 +488,7 @@ static int rt715_bus_config(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops rt715_slave_ops = {
+static const struct sdw_slave_ops rt715_slave_ops = {
 	.read_prop = rt715_read_prop,
 	.update_status = rt715_update_status,
 	.bus_config = rt715_bus_config,
-- 
2.30.1

