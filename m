Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B922C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:27:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D434E2256F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 02:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D434E2256F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 696B51817;
	Wed, 23 Dec 2020 03:26:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 696B51817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608690422;
	bh=73pTW9JpidDcAbhyZ0TvCalUsSUEWMMVkqFaTAMvmd4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/KMo7RCrE0HETVL0rFhORZ2q7lDXN3hiTyhBH1uW2sZNRAdRxbvgZg7yBnQDzmpY
	 NtOAEui97MYYFlOqF4XTZbo7oQCMpO/lWZpptbN44EmOK6jERgZ43CWETPJmDBCIRe
	 rKyterHNMuQnx9lQ+14QjAX/u1Ox5+t0tM5T+6Jc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C3EFF8021C;
	Wed, 23 Dec 2020 03:26:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33007F8027D; Wed, 23 Dec 2020 03:26:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6403F8021C
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 03:26:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6403F8021C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KuPhzIwS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8795922202;
 Wed, 23 Dec 2020 02:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608690363;
 bh=73pTW9JpidDcAbhyZ0TvCalUsSUEWMMVkqFaTAMvmd4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KuPhzIwSuhTYyYhPsKIZtD7/uYfGRUbvuScA6DFzkaDzgpq/BIJAjQvWQmaeywBOc
 EGvBt5ejEW0lWXAe6xZoPN0L73ItP9EeDjZjXaujoe7cBx8QlRWR2x3GGZg9A2ze0P
 rh3MK+8XcJ2P2dn972xg5nHclaJH09xdehWMDrIghTY/gE8stEr0S29oHz8Jb1LJVn
 ix7Q2TlIvGr78ItHwy5xT57LMIzeU+OO7NpZ3FfCW0LV6bl8c3WPawKZAOuFUd2FuJ
 wgByb/+nw5bp6oSpCv2KAmi5hTBNm3gVRK2t66FBLO9knNSxvNvNLC3ig6qElvX0xc
 2MQGeO4EWLi4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 37/38] ALSA: hda/hdmi: packet buffer index must be
 set before reading value
Date: Tue, 22 Dec 2020 21:25:15 -0500
Message-Id: <20201223022516.2794471-37-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022516.2794471-1-sashal@kernel.org>
References: <20201223022516.2794471-1-sashal@kernel.org>
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
index b249b1b857464..bab2b06c62b1c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1055,11 +1055,11 @@ static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
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

