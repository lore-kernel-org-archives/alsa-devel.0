Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D02C432C3
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:22:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D0C2333B
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D0C2333B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D8C017C2;
	Wed, 23 Dec 2020 03:22:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D8C017C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608690175;
	bh=ByjQs1YoUc/0ujkBrb1y2ptoYeB7i9eLo3wbOY18TCs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IJHhnSergU6V9r/hQ95l1LlXbmLFJ6PDQwGDkt/Zh6fYoRMuLvdV1W4D0K+yRTAWe
	 XifZPk4IQmXKwv9kwcBaovbN/yVOW/i/ItH6syNh9Yql6HWIke4Gbt6fN+jdRiDzmE
	 HyG3W89aBW/An9wMvIe1cRsvhxHkNIKx3FOPqoK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AD32F804D6;
	Wed, 23 Dec 2020 03:21:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BCA0F804E2; Wed, 23 Dec 2020 03:21:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 470ACF801D5
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 03:20:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 470ACF801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aEaoj0qi"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2471225AC;
 Wed, 23 Dec 2020 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608690056;
 bh=ByjQs1YoUc/0ujkBrb1y2ptoYeB7i9eLo3wbOY18TCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aEaoj0qiFAqMhS7GT6K1hDHd+EfVEbnJd9HVV1cYysRPHcA4EEwDnT+vjHtHUeodz
 LZPgdlJPhu2roZRtNrGXYpGumFM1RSNwGdK8xcNbhWzAYmVDOZfQi8kTZHFuPM65Jl
 +Pfn0MqoFVIlC/XtfDZx3pUo0H0EE97F3UJxLzEXuCIcmbr3/sIxeZv+wMjaZcaGVn
 EVJ7ScTC4PCJ97Lrkh25msFRIckLFe8PlQCjHD6XQal2vvFq7Om79H4h5Yq1ioLHO7
 uuI1QR3yHnFMuwDtMeWHjSUGVFjB0+aJByAfiWFYdggtkJwLf2oUAkjXi4dMt7sxlk
 sdd7Wh5I6ZEIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 126/130] ALSA: hda/hdmi: packet buffer index must
 be set before reading value
Date: Tue, 22 Dec 2020 21:18:09 -0500
Message-Id: <20201223021813.2791612-126-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 46c3bbd9827952f92e250fa6ee30a797a4c4e17e ]

The check for infoframe transmit status in hdmi_infoframe_uptodate()
makes the assumption that packet buffer index is set to zero.

Align code with specification and explicitly set the index before
AC_VERB_GET_HDMI_DIP_XMIT. The packet index setting affects both
DIP-Data and DIP-XmitCtrl verbs.

There are no known cases where the old implementation has caused driver
to work incorrectly. This change is purely based on code review against
the specification (HDA spec rev1.0a).

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20201211131613.3271407-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index df4771b9eff24..0faee80e28b66 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -645,11 +645,11 @@ static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
 	u8 val;
 	int i;
 
+	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
 	if (snd_hda_codec_read(codec, pin_nid, 0, AC_VERB_GET_HDMI_DIP_XMIT, 0)
 							    != AC_DIPXMIT_BEST)
 		return false;
 
-	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
 	for (i = 0; i < size; i++) {
 		val = snd_hda_codec_read(codec, pin_nid, 0,
 					 AC_VERB_GET_HDMI_DIP_DATA, 0);
-- 
2.27.0

