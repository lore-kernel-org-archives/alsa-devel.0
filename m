Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63A7C433F5
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Oct 2022 22:51:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6E432331;
	Mon,  3 Oct 2022 00:50:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6E432331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664751068;
	bh=oRaeNM+kB4XeFHB9RkLIcAmmI+eFA6AzdtTYAyQE01c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WZRThJOXSxl7+2/aqt4p3EEUD+zjA4mPB3cIPkzwfdIzXY04bytVnZhU4dsTGKUjD
	 sd8xcWiV3NLJ3DyFSYhk3zwo6Iy0B4BgJPGR9tfJOU2hplDODZOWS4LD9TfKYZendE
	 28VWplc59YThqWgtD7o9WtE+Y0KGL5Fbd+4QCTUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CCF8F8013D;
	Mon,  3 Oct 2022 00:50:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85E4AF80246; Mon,  3 Oct 2022 00:50:15 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79250F800CC
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2022 00:50:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79250F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="F9CoZiYV"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4073BB80D9C;
 Sun,  2 Oct 2022 22:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ACCC433C1;
 Sun,  2 Oct 2022 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664751006;
 bh=oRaeNM+kB4XeFHB9RkLIcAmmI+eFA6AzdtTYAyQE01c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F9CoZiYVoFagvS4pxe+nNcfHXHPgENUDZ77i+mCcg7x34qd14yBgzMU6Mvz9qMOyI
 lMBqoPEhZKJP6gVpWCUDRh2WXNSXkDXW/YfoyZpzHIqsvKoHv/hTqL+lTzx26sTiXz
 IAOcpKVukJAXpMN5YsZ7PWc/fD7mVg6F4Il3f9SsBfzg2HGEivbkoBrVam7nzh62x2
 RMrxo5lkvV4JDdYbhGYjKkwkVjBY1zoSuCc2HelGbK22v3UY3btJlZkLoKl093R7Nv
 Gnh8NOUKst6Lq+uHYDgeCSoeUQ+2xmOTQYNS05sI1ZJ0B5Vi+1gQOlI1EEb3oUfGpS
 x8SLs+xaiHgfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 15/29] ALSA: hda/hdmi: Fix the converter reuse
 for the silent stream
Date: Sun,  2 Oct 2022 18:49:08 -0400
Message-Id: <20221002224922.238837-15-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221002224922.238837-1-sashal@kernel.org>
References: <20221002224922.238837-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, pierre-louis.bossart@linux.intel.com,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, tiwai@suse.com, kai.heng.feng@canonical.com,
 mkumard@nvidia.com, ville.syrjala@linux.intel.com
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

From: Jaroslav Kysela <perex@perex.cz>

[ Upstream commit 5f80d6bd2b01de4cafac3302f58456bf860322fc ]

When the user space pcm stream uses the silent stream converter,
it is no longer allocated for the silent stream. Clear the appropriate
flag in the hdmi_pcm_open() function. The silent stream setup may
be applied in hdmi_pcm_close() (and the error path - open fcn) again.

If the flag is not cleared, the reuse conditions for the silent
stream converter in hdmi_choose_cvt() may improperly share
this converter.

Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20220913070216.3233974-1-perex@perex.cz
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6c209cd26c0c..22766810635b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1267,6 +1267,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	set_bit(pcm_idx, &spec->pcm_in_use);
 	per_pin = get_pin(spec, pin_idx);
 	per_pin->cvt_nid = per_cvt->cvt_nid;
+	per_pin->silent_stream = false;
 	hinfo->nid = per_cvt->cvt_nid;
 
 	/* flip stripe flag for the assigned stream if supported */
-- 
2.35.1

