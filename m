Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7C6C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:13:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5B62082F
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Eriq5c0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5B62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD17C16B9;
	Tue, 11 Feb 2020 17:12:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD17C16B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581437587;
	bh=v71zTC9feFzw4fKmUMM6qvViE4hfXDLP7fuWoSIlJ2k=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Eriq5c0vhcNGar5ruJe5opMq40N+yfVKhgehqcfrTZnPvgmnC9FmpXEtwAkjJPytY
	 Ota2iEBTBtv+qhmTfwS1+yDXe8yriFgs00UjDoSVvi76VBNkorpRWBT0LV+lCnPHbj
	 0msMaZ71hIRQQgbHRnPcZBPSifQ2bXXsw6+L7ku8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C70C3F80278;
	Tue, 11 Feb 2020 17:05:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09FC3F80279; Tue, 11 Feb 2020 17:05:26 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7864AF800E7
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 17:05:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7864AF800E7
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5C870B24A
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 16:05:22 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 11 Feb 2020 17:05:21 +0100
Message-Id: <20200211160521.31990-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: usb-audio: Fix UAC2/3 effect unit parsing
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

We've got a regression report about M-Audio Fast Track C400 device,
and the git bisection resulted in the commit e0ccdef92653 ("ALSA:
usb-audio: Clean up check_input_term()").  This commit was about the
rewrite of the input terminal parser, and it's not too obvious from
the change what really broke.  The answer is: it's the interpretation
of UAC2/3 effect units.

In the original code, UAC2 effect unit is as if through UAC1
processing unit because both UAC1 PU and UAC2/3 EU share the same
number (0x07).  The old code went through a complex switch-case
fallthrough, finally bailing out in the middle:

  if (protocol == UAC_VERSION_2 &&
      hdr[2] == UAC2_EFFECT_UNIT) {
         /* UAC2/UAC1 unit IDs overlap here in an
          * uncompatible way. Ignore this unit for now.
          */
         return 0;
   }

... and this special handling was missing in the new code; the new
code treats UAC2/3 effect unit as if it were equivalent with the
processing unit.

Actually, the old code was too confusing.  The effect unit has an
incompatible unit description with the processing unit, so we
shouldn't have dealt with EU in the same way.

This patch addresses the regression by changing the effect unit
handling to the own parser function.  The own parser function makes
the clear distinct with PU, so it improves the readability, too.

The EU parser just sets the type and the id like the old kernels.
Once when the proper effect unit support is added, we can revisit this
parser function, but for now, let's keep this simple setup as is.

Fixes: e0ccdef92653 ("ALSA: usb-audio: Clean up check_input_term()")
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206147
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index d659fdb475e2..81b2db0edd5f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -897,6 +897,15 @@ static int parse_term_proc_unit(struct mixer_build *state,
 	return 0;
 }
 
+static int parse_term_effect_unit(struct mixer_build *state,
+				  struct usb_audio_term *term,
+				  void *p1, int id)
+{
+	term->type = UAC3_EFFECT_UNIT << 16; /* virtual type */
+	term->id = id;
+	return 0;
+}
+
 static int parse_term_uac2_clock_source(struct mixer_build *state,
 					struct usb_audio_term *term,
 					void *p1, int id)
@@ -981,8 +990,7 @@ static int __check_input_term(struct mixer_build *state, int id,
 						    UAC3_PROCESSING_UNIT);
 		case PTYPE(UAC_VERSION_2, UAC2_EFFECT_UNIT):
 		case PTYPE(UAC_VERSION_3, UAC3_EFFECT_UNIT):
-			return parse_term_proc_unit(state, term, p1, id,
-						    UAC3_EFFECT_UNIT);
+			return parse_term_effect_unit(state, term, p1, id);
 		case PTYPE(UAC_VERSION_1, UAC1_EXTENSION_UNIT):
 		case PTYPE(UAC_VERSION_2, UAC2_EXTENSION_UNIT_V2):
 		case PTYPE(UAC_VERSION_3, UAC3_EXTENSION_UNIT):
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
