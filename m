Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0169CC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:10:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6512422B51
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6512422B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5EA016E7;
	Mon, 11 Jan 2021 14:09:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5EA016E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610370600;
	bh=SnoOXdfrBLnEPLFaEg3pkA0fEwTBOhmf5QcaYzLnFtU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QWenDTf9Sgzc3RF+n8QqkqDdWH75q/l8Ty67E3BSHaTrbqZdptIm21oJYYi3CR+wp
	 Rdzr7CmxCTOOlXrjUdAl0rI7FS8aRBU6Nv6lkVLTniHx+GrjmnxXBIgRW9gvheXbkP
	 vYG6oi0jIkqw9FgpTvDGpIaiinKWwT9AuDA3KQL4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33BD8F804E5;
	Mon, 11 Jan 2021 14:07:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD171F804E0; Mon, 11 Jan 2021 14:07:03 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFAE7F804D8
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 14:06:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFAE7F804D8
Received: from [123.114.32.120] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1kywuO-0001Ym-OW; Mon, 11 Jan 2021 13:06:57 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz,
 kai.vehmanen@linux.intel.com
Subject: [RFC][PATCH v4 4/4] alsa: jack: implement save-and-restore for jack's
 hw status
Date: Mon, 11 Jan 2021 21:05:57 +0800
Message-Id: <20210111130557.90208-5-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111130557.90208-1-hui.wang@canonical.com>
References: <20210111130557.90208-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Once we enable the sw_inject for a jack_kctl, the hw status change
will be blocked, but the hw status still could be reported to
snd_jack_report() and be saved to hw_status_cache.

After the sw_inject is disabled, we use the last saved hw_status_cache
to restore jack's status.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 include/sound/jack.h | 1 +
 sound/core/jack.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 9eb2b5ec1ec4..1181f536557e 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -67,6 +67,7 @@ struct snd_jack {
 	char name[100];
 	unsigned int key[6];   /* Keep in sync with definitions above */
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
+	int hw_status_cache;
 	void *private_data;
 	void (*private_free)(struct snd_jack *);
 };
diff --git a/sound/core/jack.c b/sound/core/jack.c
index fc49dae887f8..e15db7894b88 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -194,8 +194,14 @@ static ssize_t sw_inject_enable_write(struct file *file,
 		goto exit;
 	}
 
+	if (jack_kctl->sw_inject_enable == (!!enable))
+		goto exit;
+
 	jack_kctl->sw_inject_enable = !!enable;
 
+	if (!jack_kctl->sw_inject_enable)
+		snd_jack_report(jack_kctl->jack, jack_kctl->jack->hw_status_cache);
+
  exit:
 	kvfree(buf);
 	return ret;
@@ -679,6 +685,8 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (!jack)
 		return;
 
+	jack->hw_status_cache = status;
+
 	list_for_each_entry(jack_kctl, &jack->kctl_list, list)
 		if (jack_kctl->sw_inject_enable)
 			mask_bits |= jack_kctl->mask_bits;
-- 
2.25.1

