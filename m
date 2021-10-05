Return-Path: <SRS0=jGB1=OZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53205C433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 13:52:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C7860249
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 13:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88C7860249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 232F21688;
	Tue,  5 Oct 2021 15:51:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 232F21688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633441936;
	bh=AXytzKMUE1DPWebMn1FnjSeiu0njVB7PhvTjMrtxGB4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zs/7E8NjVkj7+hinGKqZjRVhZ1Kcb1mg3CAUW6wo6yQiepyvRoefW4uCLL6jPVag6
	 DjxoUdIpfFpWk9ikx+1qgxnV2SRoxkBETragOW+FGZubatZFV9q2qVYGWNozcAnC6m
	 +hZ4+Rs+T8BPe6l4unHTwQh3M0VTeNhtxJSSdpKQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01790F802A0;
	Tue,  5 Oct 2021 15:50:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D281BF8020D; Tue,  5 Oct 2021 15:50:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CA1CF8020D
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 15:50:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CA1CF8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Kvjebn3Y"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 789D961244;
 Tue,  5 Oct 2021 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633441831;
 bh=AXytzKMUE1DPWebMn1FnjSeiu0njVB7PhvTjMrtxGB4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kvjebn3YjDBkTmesrYqZCOSECepzM9mq0f0/Dtjnf4nNC1jmgP+GQ+TJJO9x9T81A
 RVnwU9LZpSaOFbVJHplFZJNe7/QArvEifGFlh0+FsSdGvCtu06Kyy31vwKEAeuij8W
 POeVw8Yn20/06TNcbRGixiN7iI0RWkkwCVK7AptmanaeGI0SdHZpzOTjUXiUf0q1/f
 l8VStXrkoXlHuUzYuwPvvndudYWunPyOxvMgMH42tKtsoapf/BE0C2kqg7w9OTvkab
 91W4oFKJg63XYm2r2VMb6r0HOxtLNazvm1bIpLxOhC2/5NmMjQn+GEdN/cXgKtV7Jj
 yvPWUKHhGFvug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 05/40] ALSA: oxfw: fix transmission method for
 Loud models based on OXFW971
Date: Tue,  5 Oct 2021 09:49:44 -0400
Message-Id: <20211005135020.214291-5-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005135020.214291-1-sashal@kernel.org>
References: <20211005135020.214291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, tiwai@suse.com
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 64794d6db49730d22f440aef0cf4da98a56a4ea3 ]

Loud Technologies Mackie Onyx 1640i (former model) is identified as
the model which uses OXFW971. The analysis of packet dump shows that
it transfers events in blocking method of IEC 61883-6, however the
default behaviour of ALSA oxfw driver is for non-blocking method.

This commit adds code to detect it assuming that all of loud models
based on OXFW971 have such quirk. It brings no functional change
except for alignment rule of PCM buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20210913021042.10085-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/oxfw/oxfw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index cb5b5e3a481b..daf731364695 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -184,13 +184,16 @@ static int detect_quirks(struct snd_oxfw *oxfw, const struct ieee1394_device_id
 			model = val;
 	}
 
-	/*
-	 * Mackie Onyx Satellite with base station has a quirk to report a wrong
-	 * value in 'dbs' field of CIP header against its format information.
-	 */
-	if (vendor == VENDOR_LOUD && model == MODEL_SATELLITE)
+	if (vendor == VENDOR_LOUD) {
+		// Mackie Onyx Satellite with base station has a quirk to report a wrong
+		// value in 'dbs' field of CIP header against its format information.
 		oxfw->quirks |= SND_OXFW_QUIRK_WRONG_DBS;
 
+		// OXFW971-based models may transfer events by blocking method.
+		if (!(oxfw->quirks & SND_OXFW_QUIRK_JUMBO_PAYLOAD))
+			oxfw->quirks |= SND_OXFW_QUIRK_BLOCKING_TRANSMISSION;
+	}
+
 	return 0;
 }
 
-- 
2.33.0

