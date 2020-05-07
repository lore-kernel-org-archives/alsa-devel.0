Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E70EC47247
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:33:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF632073A
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eL6XXAdo";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8F+m6WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF632073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7453A1832;
	Thu,  7 May 2020 16:32:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7453A1832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588861984;
	bh=Yb5y0lYInmvdLijf6VySfaZegMdUZWauZBvkY0cLI1k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eL6XXAdoEzMiFcnD5QmpJkXQxQ/k0rHAGYGhF51uy9MqtM0AwUMZ0lmUDQJMu3ptx
	 aDtqQmUfejvtj4Zj5YnHUbJQ4R2Bt+22scJYmIWyvwtv0emFZkDkQFNFyBzhP6BlRG
	 RxEZVwopPW/kpiIgYP5J8NqRI/BacgkYUU7dqyUc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93D5EF8028F;
	Thu,  7 May 2020 16:29:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51249F80291; Thu,  7 May 2020 16:29:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4EB7F80277
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 16:29:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4EB7F80277
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q8F+m6WF"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8A89420870;
 Thu,  7 May 2020 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588861772;
 bh=Yb5y0lYInmvdLijf6VySfaZegMdUZWauZBvkY0cLI1k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q8F+m6WFphWFhDTtU/VSXisbbJ52gDshpk1EbkGtO+DHrvalUFcr99xOC2gL+tTJ/
 oW1jO7HYDcQXszUCxa4tmw7OGrIIxfY6VikwOJkW/dVF3NkN9RJcgHo/f1DCgIN1Rr
 yNCSWu6LBaPN7R8ekA9Hy30tFXaLplZBJ3MT7Zzs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/20] ALSA: hda: Match both PCI ID and SSID for
 driver blacklist
Date: Thu,  7 May 2020 10:29:08 -0400
Message-Id: <20200507142917.26612-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142917.26612-1-sashal@kernel.org>
References: <20200507142917.26612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 977dfef40c8996b69afe23a9094d184049efb7bb ]

The commit 3c6fd1f07ed0 ("ALSA: hda: Add driver blacklist") added a
new blacklist for the devices that are known to have empty codecs, and
one of the entries was ASUS ROG Zenith II (PCI SSID 1043:874f).
However, it turned out that the very same PCI SSID is used for the
previous model that does have the valid HD-audio codecs and the change
broke the sound on it.

Since the empty codec problem appear on the certain AMD platform (PCI
ID 1022:1487), this patch changes the blacklist matching to both PCI
ID and SSID using pci_match_id().  Also, the entry that was removed by
the previous fix for ASUS ROG Zenigh II is re-added.

Link: https://lore.kernel.org/r/20200424061222.19792-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0d7981eda2c4f..8e1eb5f243a27 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2214,9 +2214,10 @@ static const struct hdac_io_ops pci_hda_io_ops = {
  * some HD-audio PCI entries are exposed without any codecs, and such devices
  * should be ignored from the beginning.
  */
-static const struct snd_pci_quirk driver_blacklist[] = {
-	SND_PCI_QUIRK(0x1462, 0xcb59, "MSI TRX40 Creator", 0),
-	SND_PCI_QUIRK(0x1462, 0xcb60, "MSI TRX40", 0),
+static const struct pci_device_id driver_blacklist[] = {
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith II / Strix */
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creator */
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
 	{}
 };
 
@@ -2239,7 +2240,7 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
-	if (snd_pci_quirk_lookup(pci, driver_blacklist)) {
+	if (pci_match_id(driver_blacklist, pci)) {
 		dev_info(&pci->dev, "Skipping the blacklisted device\n");
 		return -ENODEV;
 	}
-- 
2.20.1

