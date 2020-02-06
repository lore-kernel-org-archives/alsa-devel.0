Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB520C35247
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:03:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68209218AC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 20:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hscB4QWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68209218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B384F16CA;
	Thu,  6 Feb 2020 21:02:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B384F16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581019408;
	bh=wnz8+304PDfZoEuK6oSw3mYXSECglltLGygofn8lkwg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hscB4QWFqjVfudgumjYrq6ZdYuF6uaAqo6MHN7t1lVPJI9FEJpN/R8YybE9ZfXham
	 SSVnQGslBd9bGP1S6o2bwNmON95VOIAoSAF9EDa150B9T0OclL+lDLorLdkWGZ135D
	 AGVhqt2u2saKfkiZLCb6vwYcBp3IPxrn+2sVUqPs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 440F3F8015B;
	Thu,  6 Feb 2020 21:02:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63277F80162; Thu,  6 Feb 2020 21:02:36 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E48FF800C6
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 21:02:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E48FF800C6
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Feb 2020 12:02:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; d="scan'208";a="255197680"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2020 12:02:28 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Date: Thu,  6 Feb 2020 22:02:21 +0200
Message-Id: <20200206200223.7715-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, ranjani.sridharan@linux.intel.com
Subject: [alsa-devel] [PATCH 1/3] ALSA: hda: do not override bus codec_mask
	in link_get()
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

snd_hdac_ext_bus_link_get() does not work correctly in case
there are multiple codecs on the bus. It unconditionally
resets the bus->codec_mask value. As per documentation in
hdaudio.h and existing use in client code, this field should
be used to store bit flag of detected codecs on the bus.

By overwriting value of the codec_mask, information on all
detected codecs is lost. No current user of hdac is impacted,
but use of bus->codec_mask is planned in future patches
for SOF.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index cfab60d88c92..09ff209df4a3 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -254,6 +254,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down_all);
 int snd_hdac_ext_bus_link_get(struct hdac_bus *bus,
 				struct hdac_ext_link *link)
 {
+	unsigned long codec_mask;
 	int ret = 0;
 
 	mutex_lock(&bus->lock);
@@ -280,9 +281,11 @@ int snd_hdac_ext_bus_link_get(struct hdac_bus *bus,
 		 *  HDA spec section 4.3 - Codec Discovery
 		 */
 		udelay(521);
-		bus->codec_mask = snd_hdac_chip_readw(bus, STATESTS);
-		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", bus->codec_mask);
-		snd_hdac_chip_writew(bus, STATESTS, bus->codec_mask);
+		codec_mask = snd_hdac_chip_readw(bus, STATESTS);
+		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", codec_mask);
+		snd_hdac_chip_writew(bus, STATESTS, codec_mask);
+		if (!bus->codec_mask)
+			bus->codec_mask = codec_mask;
 	}
 
 	mutex_unlock(&bus->lock);
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
