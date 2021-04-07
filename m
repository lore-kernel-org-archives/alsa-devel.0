Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E631C433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 07:55:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14876113B
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 07:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14876113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B4A21676;
	Wed,  7 Apr 2021 09:54:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B4A21676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617782129;
	bh=CLCRDi+77gCWDlerWFlOW56IEbEOy4AbCcAAleJkdpE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SMyBk3Hw/Fmmprfy7ki/TUqfMEEfDBUyxA+rSj7HiyWPGDw3L/Iv0Zmu8ME8iMJCh
	 Ah1MV5NWax1nGWPqNXfqE4VR9hYYtxTa6c0cXYl+87aL+7oBbSGZKm3+RJfg4fRhVR
	 UodE5NhxBVlMxj+zatXxAWBv82CZAH4dF/L2//p0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29E71F80168;
	Wed,  7 Apr 2021 09:54:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A179BF8016A; Wed,  7 Apr 2021 09:54:37 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06775F800BD
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 09:54:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06775F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="ArOz3Usf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1617782072;
 x=1649318072; h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bLOXTbfkAb9gwNO6weZ5ORyuJJ7xGVy31mdD30BGh7U=;
 b=ArOz3UsfaZGAKJOdzEQrc4LwQaJIcO1glmeb0pmaWEXYSeA8O7Jl6iRi
 Aq0Swv5K0vdQHGFI7ZDmalaFPeCL7yYgnZXO9jTndSes+RJY9ktqNmA06
 87OXVaP/yQFJLChWgB7Q5QF6Av+e8npQW1Mvp5knboiSWj5vKeKbOtgYN
 HVTZg8JCqz7EbuZ96AxZrzj+RiIAVp9RlnT5iPWiUqEPL414yqbfainZZ
 WW1Q233LXImW/kndZWytQHft8Ej2UlOrXv1KkpdSkLhglM1AyeacfWMB5
 moj8KhWh5nMGHFsJw+yqE5zwxnaAR8XS8bobMz4bnJRnKpXsOAh6aNjfF g==;
From: Jonas Holmberg <jonashg@axis.com>
To: <tiwai@suse.de>, <alsa-devel@alsa-project.org>
Subject: [PATCH] ALSA: aloop: Fix initialization of controls
Date: Wed, 7 Apr 2021 09:54:28 +0200
Message-ID: <20210407075428.2666787-1-jonashg@axis.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add a control to the card before copying the id so that the numid field
is initialized in the copy. Otherwise the numid field of active_id,
format_id, rate_id and channels_id will be the same (0) and
snd_ctl_notify() will not queue the events properly.

Signed-off-by: Jonas Holmberg <jonashg@axis.com>
---
 sound/drivers/aloop.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 52637180af33..80b814b9922a 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1571,6 +1571,14 @@ static int loopback_mixer_new(struct loopback *loopback, int notify)
 					return -ENOMEM;
 				kctl->id.device = dev;
 				kctl->id.subdevice = substr;
+
+				/* Add the control before copying the id so that
+				 * the numid field of the id is set in the copy.
+				 */
+				err = snd_ctl_add(card, kctl);
+				if (err < 0)
+					return err;
+
 				switch (idx) {
 				case ACTIVE_IDX:
 					setup->active_id = kctl->id;
@@ -1587,9 +1595,6 @@ static int loopback_mixer_new(struct loopback *loopback, int notify)
 				default:
 					break;
 				}
-				err = snd_ctl_add(card, kctl);
-				if (err < 0)
-					return err;
 			}
 		}
 	}
-- 
2.26.3

