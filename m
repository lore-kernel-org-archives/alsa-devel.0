Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F78C4167B
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Dec 2023 13:22:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1C0A843;
	Fri,  8 Dec 2023 14:22:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1C0A843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702041766;
	bh=INYEZxBxqRaIsm66kA/f8L3nXnHuIjoICI5+h0zKKFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=efkJFpWbAo4XlKHbWCvgC8tq+ajLR6E8OslXdeXhR4lU0UxGitgW5pmfhHAnNQwVY
	 iu7yqxcS/qlRI51h9ocKCFW2Mcn07kyPDmRCrq0QCcEoj8nFgfHwy0BPohT+O8O+Ox
	 DjA/kovkoiCJO1iToMHo18MQN91PlH/8OgHqlJLk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11717F805C2; Fri,  8 Dec 2023 14:22:02 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1880DF805A9;
	Fri,  8 Dec 2023 14:22:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14B5FF80587; Fri,  8 Dec 2023 14:21:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 02824F800E4
	for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2023 14:21:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02824F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UPLrSRc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702041712; x=1733577712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=INYEZxBxqRaIsm66kA/f8L3nXnHuIjoICI5+h0zKKFM=;
  b=UPLrSRc7g8rrJ5gatxRpLhsSIgizY2i/WVLDxU/DNgrQXihH+WIFjHsD
   +AAcKP1S7PJqisDiuojESn79Khxqtvr6JzbKABva8Q/Dlrms6J9wjHDg4
   CvXIgYPvK/hCWTWCgaiKy5/r07M+QYA/pwsPvY9dxkStXi+INiOTZ6/HY
   h6XO0qM6kLIMBw/1yOBIn5hNT1bcY05qE2NZUEoynce95JoYvouESVtUi
   A78Gh9f5m25AhwFA/AJceBzGqxio3rKe10s1J6umTbQajD8GAv32A7TC6
   PEGXQiuP4+Xmz3fXKcCZ6OY8kD1cGF9a1pZpQTC6onO07d91AQFq02qX2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394141777"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600";
   d="scan'208";a="394141777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2023 05:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915948520"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600";
   d="scan'208";a="915948520"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2023 05:21:48 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: linux-sound@vger.kernel.org,
	tiwai@suse.de
Cc: kai.vehmanen@linux.intel.com,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>
Subject: [PATCH 1/2] ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB
Date: Fri,  8 Dec 2023 15:21:26 +0200
Message-ID: <20231208132127.2438067-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208132127.2438067-1-kai.vehmanen@linux.intel.com>
References: <20231208132127.2438067-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VKWYOMVNJHS5IMQXSFL7XDQT3SZLHX4B
X-Message-ID-Hash: VKWYOMVNJHS5IMQXSFL7XDQT3SZLHX4B
X-MailFrom: kai.vehmanen@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VKWYOMVNJHS5IMQXSFL7XDQT3SZLHX4B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add one more older NUC model that requires quirk to force all pins to be
connected. The display codec pins are not registered properly without
the force-connect quirk. The codec will report only one pin as having
external connectivity, but i915 finds all three connectors on the
system, so the two drivers are not in sync.

Issue found with DRM igt-gpu-tools test kms_hdmi_inject@inject-audio.

Link: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/3
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Saarinen <jani.saarinen@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index dff2d7221982..88d7e037a57c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1994,6 +1994,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8715, "HP", 1),
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
 };
-- 
2.43.0

