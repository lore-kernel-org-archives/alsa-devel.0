Return-Path: <SRS0=YoTX=4X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F1C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:13:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E202072A
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JKhp9YmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E202072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86794820;
	Fri,  6 Mar 2020 09:12:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86794820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583482410;
	bh=7uij8nOKWsZSHWeK6H6Sg/Nb1j6J285Ug2BG3DnrF+8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JKhp9YmOp4AuE0VKMZS57Gsuc0mJGbBwn2utDt6Myyg7pzfMmcVnsaV2vMdjzQj4T
	 pvjA1j5LLf/e4HzQqnd4E/eZ7zq0wOzQVJpl0SC1Es81j4ca5KqLHuqOEuHrqklSr6
	 p4eL3fCPXnsETQnuRHglMyIWAaW9TQJYJyGjyjzY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85331F801EC;
	Fri,  6 Mar 2020 09:12:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EF2CF801ED; Fri,  6 Mar 2020 09:12:37 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7FF41F80125
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2020 09:12:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FF41F80125
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A9553AF65
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2020 08:12:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix missing braces in some struct inits
Date: Fri,  6 Mar 2020 09:12:31 +0100
Message-Id: <20200306081231.7940-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

The struct s1810c_state_packet contains the array in the first field
hence zero-initialization requires a more couple of braces.  Fix the
compile warning pointing it out:
   sound/usb/mixer_s1810c.c: In function 'snd_sc1810c_get_status_field':
   sound/usb/mixer_s1810c.c:178:9: warning: missing braces around initializer [-Wmissing-braces]

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 8dc5efe3d17c ("ALSA: usb-audio: Add support for Presonus Studio 1810c")
Link: https://lore.kernel.org/r/202002210251.WgMfvKJP%lkp@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_s1810c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_s1810c.c b/sound/usb/mixer_s1810c.c
index 816879a07f82..6483e47bafd0 100644
--- a/sound/usb/mixer_s1810c.c
+++ b/sound/usb/mixer_s1810c.c
@@ -175,8 +175,8 @@ static int
 snd_sc1810c_get_status_field(struct usb_device *dev,
 			     u32 *field, int field_idx, uint16_t *seqnum)
 {
-	struct s1810c_state_packet pkt_out = { 0 };
-	struct s1810c_state_packet pkt_in = { 0 };
+	struct s1810c_state_packet pkt_out = { { 0 } };
+	struct s1810c_state_packet pkt_in = { { 0 } };
 	int ret = 0;
 
 	pkt_out.fields[SC1810C_STATE_F1_IDX] = SC1810C_SET_STATE_F1;
-- 
2.16.4

