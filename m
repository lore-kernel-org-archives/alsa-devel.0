Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C9CC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 10:18:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8063722CA1
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 10:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8063722CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D227516AC;
	Tue, 12 Jan 2021 11:17:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D227516AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610446721;
	bh=XC4x5R0AW8FkGhvfoDvjCDJummIDFXQcbI/HKYsx3S8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J5EWrKk+3nGt7S2VALwXjHcRdhyqsBP/5cQlWwIIgJJb7t2yDIK0Dt9jC7QSqjptP
	 eHbPl4hjiKghNWihzFWnHWJjgU9yNYT9oRKD3+/JEk1W7kdykh0MPXLpS6QXeRuOEK
	 oPUkaOo4X2F1f3OSpvvsjHARisXgvtI8hHJ4EMn0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D369F80249;
	Tue, 12 Jan 2021 11:17:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6A50F8025E; Tue, 12 Jan 2021 11:17:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62F69F800EB
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 11:17:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62F69F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="Jl1EsuTv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610446654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Udz9vn84uwwXcBik+uTtDwfov9SaSVSotavmrBrWdQ=;
 b=Jl1EsuTvdwzvDtMOUN/QfOlLEIl6kXHqLWFEhNMLKFtnmLwLaSVqZocGyKFKPMpyqvXnKd
 Bo4LoFAmp/X0yK/OJs1xsSsWImaW1kuw9+982DpAyhd23oJrtM6eThCEyGClktmmBgzytk
 Yvgns6eZXUbRzgZFMV4vUwIMdRG5YQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-8L5CEGtTOsKSzc_j7ftApw-1; Tue, 12 Jan 2021 05:17:30 -0500
X-MC-Unique: 8L5CEGtTOsKSzc_j7ftApw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2D58015D0;
 Tue, 12 Jan 2021 10:17:28 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-212.ams2.redhat.com [10.36.115.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B921660BE5;
 Tue, 12 Jan 2021 10:17:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: es8316: Fix possible NULL pointer deref in
 es8316_disable_jack_detect()
Date: Tue, 12 Jan 2021 11:17:25 +0100
Message-Id: <20210112101725.44200-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 russianneuromancer <russianneuromancer@ya.ru>
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

sound/soc/soc-core.c: soc_remove_component() unconditionally calls
snd_soc_component_set_jack(component, NULL, NULL); on any components
being removed.

This means that on machines where the machine-driver does not provide
a jack through snd_soc_component_set_jack() es8316_disable_jack_detect()
will still get called and at this time es8316->jack will be NULL and
the es8316->jack->status check in es8316_disable_jack_detect() will
lead to a NULL pointer deref.

Fix this by checking for es8316->jack bein NULL at the start of
es8316_disable_jack_detect() and turn the function into a no-op in
that case.

Cc: russianneuromancer <russianneuromancer@ya.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/es8316.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index f9ec5cf82599..1ce84f12a4cf 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -681,6 +681,9 @@ static void es8316_disable_jack_detect(struct snd_soc_component *component)
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
+	if (!es8316->jack)
+		return; /* Already disabled (or never enabled) */
+
 	disable_irq(es8316->irq);
 
 	mutex_lock(&es8316->lock);
-- 
2.28.0

