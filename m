Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB6C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 14:43:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBA264F1B
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 14:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBA264F1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6731F172B;
	Tue,  2 Mar 2021 15:42:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6731F172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614696208;
	bh=6YeEQeSY2aAqu4UwA7UJx6z2RKa4wMiORHUtgH+Rzvo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JOIe23/BfGZnh3LFu4BjZRWztNREZti3AweSRWAgWDHEyFrwjUBlBn+ZaT94LLTUq
	 O2b4Qf09Dt0V61HjmLj2ByzsHmwcu+FlnXsHxic+2onNXHzKIB1i0AtI5Ow18V8l1v
	 wzYhH+puRdx+CGIfM4f72r++uM6qpDWHFXndheFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3828F8025B;
	Tue,  2 Mar 2021 15:42:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25C88F80269; Tue,  2 Mar 2021 15:42:37 +0100 (CET)
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0BE4F80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 15:42:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0BE4F80088
Received: from [100.112.130.24] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.us-west-2.aws.symcld.net id 66/53-29685-ECE4E306;
 Tue, 02 Mar 2021 14:42:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsWSLveKXfecn12
 Cwd5jfBZXLh5isljXn+7A5LHhcxObx6bWJawBTFGsmXlJ+RUJrBmrPt1iKljLWfFn4gqWBsbf
 7F2MXBxCAv8ZJY63nGWCcF4zSsw+85W5i5GTg01AW2LLll9sXYwcHCICMhIf1nqChJkFQiXuX
 VjHBmILC5hKTP7ezwpiswioSMx7uJ8JxOYVsJJ43HcUbIyEgLzE/9ZTYDWcAqoSZ7oes4DYQk
 D19x8sYYOoF5Q4OfMJC8R8eYnmrbOZIWwJiYMvXkDNUZDY/+csK4SdINHz7xHbBEaBWUjaZyF
 pn4WkfQEj8ypGi6SizPSMktzEzBxdQwMDXUNDI11DYwNdIyNzvcQq3US90mLd8tTiEl0jvcTy
 Yr3iytzknBS9vNSSTYzAgE4paHq8g3Hnmw96hxglOZiURHkbvOwShPiS8lMqMxKLM+KLSnNSi
 w8xynBwKEnwpvkC5QSLUtNTK9Iyc4DRBZOW4OBREuHl8ARK8xYXJOYWZ6ZDpE4xKkqJ887xAU
 oIgCQySvPg2mARfYlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO8JkCk8mXklcNNfAS1mAlo
 8yw1scUkiQkqqgUnSbxvr6dqT0/mnxMw2vffAWm2PLed57/kWfP4Plm/Znle1qsDtfbaHS81d
 hds7TNZM7VQKfXhaRah0TfTforaoOxsC75y8dse6tGaWf+LrttPPV6SYRfKdixa50XbI9/fed
 MO4n1Ez55w4s+/KZ42SOSUXxRXmivAbT3LyFv0Qtrte4D3bX6s6e0fZ7qKaPebpdgeLa49evF
 5WqpeypMBoVXrP4ehFVp7v5wf7Gxwt7ZgvMY/Xoe60ptt5c8mvT6LWHiuUZE69b9p9MOv5I3Y
 x48vn3eYv5pzn9d+yO7J/xvLZWsf+1/c9mvjpaaPg7hOhS42/PWqX4ig4wRfi9WnXl/SVUtyp
 Kb8+5doY3ldiKc5INNRiLipOBAAK+fgqYwMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-6.tower-326.messagelabs.com!1614696140!1424!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17417 invoked from network); 2 Mar 2021 14:42:22 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
 by server-6.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 2 Mar 2021 14:42:22 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by Forcepoint Email with ESMTPS id 2A454364C64A0770C201;
 Tue,  2 Mar 2021 22:42:18 +0800 (CST)
Received: from localhost.localdomain.com (10.64.94.117) by
 reswpmail01.lenovo.com (10.62.32.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 2 Mar 2021 09:41:14 -0500
From: Mark Pearson <markpearson@lenovo.com>
To: <markpearson@lenovo.com>
Subject: [PATCH] ALSA: hda: ignore invalid NHLT table
Date: Tue, 2 Mar 2021 09:41:52 -0500
Message-ID: <20210302144152.7718-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.64.94.117]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
Cc: alsa-devel@alsa-project.org,
 Philipp Leskovitz <philipp.leskovitz@secunet.com>
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

On some Lenovo systems if the microphone is disabled in the BIOS
only the NHLT table header is created, with no data. This means
the endpoints field is not correctly set to zero - leading to an
unintialised variable and hence invalid descriptors are parsed
leading to page faults.

The Lenovo firmware team is addressing this, but adding a check
preventing invalid tables being parsed is worthwhile.

Tested on a Lenovo T14.

Tested-by: Philipp Leskovitz <philipp.leskovitz@secunet.com>
Reported-by: Philipp Leskovitz <philipp.leskovitz@secunet.com>
Signed-off-by: Mark Pearson <markpearson@lenovo.com>
---
 sound/hda/intel-nhlt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index 059aaf04f..0889f2cc5 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -37,6 +37,11 @@ int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
 	if (!nhlt)
 		return 0;
 
+	if (nhlt->header.length <= sizeof(struct acpi_table_header)) {
+		dev_warn(dev, "Invalid DMIC description table\n");
+		return 0;
+	}
+
 	epnt = (struct nhlt_endpoint *)nhlt->desc;
 
 	for (j = 0; j < nhlt->endpoint_count; j++) {
-- 
2.29.2

