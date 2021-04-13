Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D318FC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 08:42:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B33613B1
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 08:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B33613B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75B7E1616;
	Tue, 13 Apr 2021 10:42:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75B7E1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618303376;
	bh=YYU2/1EALcfZd8piKudlbmsTwEH/DveifOTAYyXKVBc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dxjg7WHrfjTJM3JNyA2oXNf99JxTY10/3V9IMm8glZICqXEkEF0m9bzVGIINFDil2
	 VIx3OIXv5cZgUPPQdcg9gaHkQq55GhFjBypcV/OK0wDhTbHDJCyEgqbWx6caFjjiQM
	 Mz0i6hSRhAgbfAdRl2ckvXJqTUNyWU0wGH4ptY/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFCE2F8021D;
	Tue, 13 Apr 2021 10:42:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9647FF800EB; Tue, 13 Apr 2021 10:42:03 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1177DF800EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 10:41:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1177DF800EB
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A6BDEB124;
 Tue, 13 Apr 2021 08:41:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Explicitly set up the clock selector
Date: Tue, 13 Apr 2021 10:41:52 +0200
Message-Id: <20210413084152.32325-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>
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

In the current code, we have some assumption that the audio clock
selector has been set up implicitly and don't want to touch it unless
it's really needed for the fallback autoclock setup.  This works for
most devices but some seem having a problem.  Partially this was
covered for the devices with a single connector at the initialization
phase (commit 086b957cc17f "ALSA: usb-audio: Skip the clock selector
inquiry for single connections"), but also there are cases where the
wrong clock set up is kept silently.  The latter seems to be the cause
of the noises on Behringer devices.

In this patch, we explicitly set up the audio clock selector whenever
the appropriate node is found.

Reported-by: Geraldo Nascimento <geraldogabriel@gmail.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199327
Link: https://lore.kernel.org/r/CAEsQvcvF7LnO8PxyyCxuRCx=7jNeSCvFAd-+dE0g_rd1rOxxdw@mail.gmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index a746802d0ac3..17bbde73d4d1 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -296,7 +296,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 
 	selector = snd_usb_find_clock_selector(chip->ctrl_intf, entity_id);
 	if (selector) {
-		int ret, i, cur;
+		int ret, i, cur, err;
 
 		if (selector->bNrInPins == 1) {
 			ret = 1;
@@ -324,13 +324,17 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		ret = __uac_clock_find_source(chip, fmt,
 					      selector->baCSourceID[ret - 1],
 					      visited, validate);
+		if (ret > 0) {
+			err = uac_clock_selector_set_val(chip, entity_id, cur);
+			if (err < 0)
+				return err;
+		}
+
 		if (!validate || ret > 0 || !chip->autoclock)
 			return ret;
 
 		/* The current clock source is invalid, try others. */
 		for (i = 1; i <= selector->bNrInPins; i++) {
-			int err;
-
 			if (i == cur)
 				continue;
 
@@ -396,7 +400,7 @@ static int __uac3_clock_find_source(struct snd_usb_audio *chip,
 
 	selector = snd_usb_find_clock_selector_v3(chip->ctrl_intf, entity_id);
 	if (selector) {
-		int ret, i, cur;
+		int ret, i, cur, err;
 
 		/* the entity ID we are looking for is a selector.
 		 * find out what it currently selects */
@@ -418,6 +422,12 @@ static int __uac3_clock_find_source(struct snd_usb_audio *chip,
 		ret = __uac3_clock_find_source(chip, fmt,
 					       selector->baCSourceID[ret - 1],
 					       visited, validate);
+		if (ret > 0) {
+			err = uac_clock_selector_set_val(chip, entity_id, cur);
+			if (err < 0)
+				return err;
+		}
+
 		if (!validate || ret > 0 || !chip->autoclock)
 			return ret;
 
-- 
2.26.2

