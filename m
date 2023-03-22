Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EC3C6FD1F
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Mar 2023 14:55:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45467E94;
	Wed, 22 Mar 2023 15:54:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45467E94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679496915;
	bh=y9cPo7Hkh45jrheKlb+QH3ZHXcV3fZ4Ptvq1q0A+RY0=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Wq0+Puvi8Ze4u+CH3VOwunhRv0uPPsV+gC8lPcfKg8hRGjUBndgRORoWu+H29yyU5
	 FuP1Y0tM0JwZDz8acxYicQPhkc1MQwPhlr0UiOmASAkQd+XKvzmip5YmXlcDva3zjp
	 dIuHSO7ODGGOz7qIWKMxDCLBzhJfU5eUjS33+vxU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1DE3F8027B;
	Wed, 22 Mar 2023 15:54:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5E8DF8027B; Wed, 22 Mar 2023 15:53:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E645F80105
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2023 15:53:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E645F80105
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=GnsdCkhq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679496828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7KKwFOj1UQENKDh+Nfn9DcknVR98a02x7TEK664zSDI=;
	b=GnsdCkhqjCpO5PDxbYLwDQnV91E/wlUHPOY7DH/PfHV3naqiXD6KfJCs4OFGvJRN7Sqpoj
	zU0WZRKGEwktgzd2gDt9u7bdbaac/oYeyuofihX759KsRFOgkPw18O8G6luYWgERMrsN2J
	ryyrKhbcuZEr2T9apKnZYBE+K2oy1qc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-g6x3d7CrNHej0sXdzCUM7A-1; Wed, 22 Mar 2023 10:53:42 -0400
X-MC-Unique: g6x3d7CrNHej0sXdzCUM7A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D4473C025D7;
	Wed, 22 Mar 2023 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED7E3492C13;
	Wed, 22 Mar 2023 14:53:40 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH resend] ASoC: Intel: bytcr_rt5640: Add quirk for the Acer
 Iconia One 7 B1-750
Date: Wed, 22 Mar 2023 15:53:32 +0100
Message-Id: <20230322145332.131525-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Message-ID-Hash: EHMDQ3VW3XCJS2JRHC7QWH7GAZCBJVKP
X-Message-ID-Hash: EHMDQ3VW3XCJS2JRHC7QWH7GAZCBJVKP
X-MailFrom: hdegoede@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EHMDQ3VW3XCJS2JRHC7QWH7GAZCBJVKP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Acer Iconia One 7 B1-750 tablet mostly works fine with the defaults
for an Bay Trail CR tablet. Except for the internal mic, instead of
an analog mic on IN3 a digital mic on DMIC1 is uses.

Add a quirk with these settings for this tablet.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Resend: I somehow forgot to add Mark Brown to the recipients with
the original submission. I did add Pierre-Louis' ack for this resend.
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 79e0039c79a3..5a12940ef907 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -533,6 +533,18 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{	/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Acer Iconia Tab 8 W1-810 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
2.39.1

