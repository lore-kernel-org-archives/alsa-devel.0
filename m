Return-Path: <SRS0=30w1=H5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7919AC433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 27 Feb 2021 10:58:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A850A64EC4
	for <alsa-devel@archiver.kernel.org>; Sat, 27 Feb 2021 10:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A850A64EC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53CFC1681;
	Sat, 27 Feb 2021 11:57:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53CFC1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614423522;
	bh=vqOTbKEtm6nlQuURqI9Nb0pMeEB45vGMiL5l+3hQ8wY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AVgipC7lJZI+5HEWV1g35ID+Ikw0wJQjdVPUSxG8ceYtia24b8dF8SJK4vomhe8PI
	 6eSAhvlUY6/MTKFlcV0FJlr7a1ew7eodxAtB2faTGn8cuDl5Fdzc7HHkmjpb5JRbUd
	 A1OTz4HHx9PZY/H4gZrkkal5elJNdVtrfYZGeNas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C02A4F80169;
	Sat, 27 Feb 2021 11:57:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFB86F8016A; Sat, 27 Feb 2021 11:57:49 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97510F80159
 for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2021 11:57:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97510F80159
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DB492AD74
 for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2021 10:57:37 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Drop bogus dB range in too low level
Date: Sat, 27 Feb 2021 11:57:37 +0100
Message-Id: <20210227105737.3656-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
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

Some USB audio firmware seem to report broken dB values for the volume
controls, and this screws up applications like PulseAudio who blindly
trusts the given data.  For example, Edifier G2000 reports a PCM
volume from -128dB to -127dB, and this results in barely inaudible
sound.

This patch adds a sort of sanity check at parsing the dB values in
USB-audio driver and disables the dB reporting if the range looks
bogus.  Here, we assume -96dB as the bottom line of the max dB.

Note that, if one can figure out that proper dB range later, it can be
patched in the mixer maps.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=211929
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b1c78db0d470..b004b2e63a5d 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1307,6 +1307,17 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 			/* totally crap, return an error */
 			return -EINVAL;
 		}
+	} else {
+		/* if the max volume is too low, it's likely a bogus range;
+		 * here we use -96dB as the threshold
+		 */
+		if (cval->dBmax <= -9600) {
+			usb_audio_info(cval->head.mixer->chip,
+				       "%d:%d: bogus dB values (%d/%d), disabling dB reporting\n",
+				       cval->head.id, mixer_ctrl_intf(cval->head.mixer),
+				       cval->dBmin, cval->dBmax);
+			cval->dBmin = cval->dBmax = 0;
+		}
 	}
 
 	return 0;
-- 
2.26.2

