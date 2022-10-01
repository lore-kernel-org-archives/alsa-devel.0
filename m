Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48465C433F5
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Oct 2022 14:22:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 147B81B30;
	Sat,  1 Oct 2022 16:21:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 147B81B30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664634146;
	bh=Gjn9JrLT9hqKrG2tOHuA+1H8QNVrefPyfnpPlkBWwug=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sexuad28qM6PYYWjRmyS2si5gpcCHsZmfiPhfJjSaHvn06nkT7ZPeonoQ5HS15BRJ
	 6kzbDjg7hGSdwD+IX7APUuo0y6cDCSUxFK+XVOLtqa0aYF3mvF2XQzkO2AJTH0YKu1
	 sCos3hmyyXsdZiy88h5OWTAmnv+Ui9eGcS+Xf9qg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB001F804C2;
	Sat,  1 Oct 2022 16:21:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C2B6F804CF; Sat,  1 Oct 2022 16:21:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CF03F80171
 for <alsa-devel@alsa-project.org>; Sat,  1 Oct 2022 16:21:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CF03F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="BS3GDZXf"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="Ez4lvjxg"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C01852199B;
 Sat,  1 Oct 2022 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1664634087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CCWdqjo/cYVhghfKNvjY4x+OiHd5FsnclqiZVfJ+KfY=;
 b=BS3GDZXfO0ycr4XiExXCySlLAo06ue+wxU0aKQgMWyYr2QDOqm66gPE2+fhSP93t6pa61K
 67RWbL6LMN7Xc8kVtFKWbjMngsU1q1+LBFdm3opfa0OT7jz3LdEkTuYe59q9oEApWGy6b1
 B8Te/5ZTH1DhJhrnwOR3UgCbntrgHqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1664634087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CCWdqjo/cYVhghfKNvjY4x+OiHd5FsnclqiZVfJ+KfY=;
 b=Ez4lvjxgUUo30JNdpKl6gAVm9ik6JQvSj1XIlZZ2I4hbS5jjVztM5hhWfZmFJ2vWcB47gw
 s1O2pORZC1VlpGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A501113A7F;
 Sat,  1 Oct 2022 14:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FAacJ+dMOGOjEgAAMHmgww
 (envelope-from <tiwai@suse.de>); Sat, 01 Oct 2022 14:21:27 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Fix position reporting on Poulsbo
Date: Sat,  1 Oct 2022 16:21:24 +0200
Message-Id: <20221001142124.7241-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Hans de Goede <hdegoede@redhat.com>
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

Hans reported that his Sony VAIO VPX11S1E showed the broken sound
behavior at the start of the stream for a couple of seconds, and it
turned out that the position_fix=1 option fixes the issue.  It implies
that the position reporting is inaccurate, and very likely hitting on
all Poulsbo devices.

The patch applies the workaround for Poulsbo generically to switch to
LPIB mode instead of the default position buffer.

Reported-and-tested-by: Hans de Goede <hdegoede@redhat.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/3e8697e1-87c6-7a7b-d2e8-b21f1d2f181b@redhat.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2a93bc64c2d8..6ff19dd0d10c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2547,7 +2547,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
 	/* Poulsbo */
 	{ PCI_DEVICE(0x8086, 0x811b),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE |
+	  AZX_DCAPS_POSFIX_LPIB },
 	/* Oaktrail */
 	{ PCI_DEVICE(0x8086, 0x080a),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE },
-- 
2.35.3

