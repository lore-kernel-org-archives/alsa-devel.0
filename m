Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80EEC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 11:47:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA8B2074D
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 11:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="irA4uXYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA8B2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bollie.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77CEE1607;
	Fri, 15 May 2020 13:46:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77CEE1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589543225;
	bh=vM8WbzkE6e7/bB79BPcxTMcRyKrlOFGWGXujRNTdHeo=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=irA4uXYlf1b1WtkeeqyE6mKnoaoEAoHpbFCkuTBEIFa8m4d4IvcZJr1CpCwIq86wm
	 9DrMoOMIAsCHyR6/Bn8UFYmb+SkgGyPyCdJ6Xdw8w839EAcLRQbV/4W5+39XijEr4Y
	 tvxcFLDjZzHkdJB6jU3ZNwFXBNBj+VfN1dJJU/gU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A998F8022D;
	Fri, 15 May 2020 13:46:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07F18F80247; Fri, 15 May 2020 13:46:14 +0200 (CEST)
Received: from bollie.ca9.eu (bollie.ca9.eu [81.169.254.190])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA72AF800B8
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 13:46:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA72AF800B8
Received: by bollie.ca9.eu (Postfix, from userid 1000)
 id 7F4D2C607D; Fri, 15 May 2020 13:46:05 +0200 (CEST)
Date: Fri, 15 May 2020 13:46:05 +0200
From: Thomas Ebeling <penguins@bollie.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: fixing upper volume limit for RME Babyface Pro routing
 crosspoints.
Message-ID: <20200515114556.vtspnonzvp4xp44m@bollie.ca9.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Cc: tiwai@suse.com
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

In my initial patch, these were set too low.

Signed-off-by: Thomas Ebeling <penguins@bollie.de>
---
 sound/usb/mixer_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index bdff8674942e..aad2683ff793 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2191,7 +2191,7 @@ static int snd_rme_controls_create(struct usb_mixer_interface *mixer)
  * These devices exposes a couple of DSP functions via request to EP0.
  * Switches are available via control registers, while routing is controlled
  * by controlling the volume on each possible crossing point.
- * Volume control is linear, from -inf (dec. 0) to +6dB (dec. 46341) with
+ * Volume control is linear, from -inf (dec. 0) to +6dB (dec. 65536) with
  * 0dB being at dec. 32768.
  */
 enum {
@@ -2220,7 +2220,7 @@ enum {
 #define SND_BBFPRO_MIXER_VAL_MASK 0x3ffff
 #define SND_BBFPRO_MIXER_VAL_SHIFT 9
 #define SND_BBFPRO_MIXER_VAL_MIN 0 // -inf
-#define SND_BBFPRO_MIXER_VAL_MAX 46341 // +6dB
+#define SND_BBFPRO_MIXER_VAL_MAX 65536 // +6dB
 
 #define SND_BBFPRO_USBREQ_CTL_REG1 0x10
 #define SND_BBFPRO_USBREQ_CTL_REG2 0x17
-- 
2.26.2

