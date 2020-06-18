Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537B6C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2C321D90
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SF0/rQvz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu3uFGdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2C321D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 587AB42;
	Thu, 18 Jun 2020 03:12:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 587AB42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592442798;
	bh=2RWuC1I4HdtIrFZE3PM5UhPef8qY+Xc5s/9pa45NXFw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SF0/rQvzq537jZIKc6w5A6HhlwXT5g3AcMmyLJ06EkpvgEFTOSX5cFJPNwlZE9CHg
	 3VRtbGWD8ks8WhWXYPvPShQd/TqtE/M1Yp5Wt5rDMJEjWtZPv2PyeDi7D52vddyzO4
	 xuX7klRJs3XL+ajTTE7hUIZpQPf0qksgfiYdHVps=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC4E3F802E9;
	Thu, 18 Jun 2020 03:08:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A29DF802E9; Thu, 18 Jun 2020 03:08:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBA5CF802E7
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:08:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBA5CF802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Gu3uFGdw"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 98C2121D79;
 Thu, 18 Jun 2020 01:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442521;
 bh=2RWuC1I4HdtIrFZE3PM5UhPef8qY+Xc5s/9pa45NXFw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gu3uFGdw0FRW05niVqK1zPhO0/v2Zyy65RqjEpeKQWLaH4mLaOwhT8iBDWcI1dpYY
 zBPRMusA+wbXSEmbyLIAU4GiujqF8X/iH7Oj/041IX4yGwT3mRelwFV5qDRAPjBRET
 WQco4+TSf+MWmerwwx7SiAWxGFdNZiBK1nn3gl7U=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 026/388] ALSA: isa/wavefront: prevent out of
 bounds write in ioctl
Date: Wed, 17 Jun 2020 21:02:03 -0400
Message-Id: <20200618010805.600873-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7f0d5053c5a9d23fe5c2d337495a9d79038d267b ]

The "header->number" comes from the ioctl and it needs to be clamped to
prevent out of bounds writes.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200501094011.GA960082@mwanda
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/wavefront/wavefront_synth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index c5b1d5900eed..d6420d224d09 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -1171,7 +1171,10 @@ wavefront_send_alias (snd_wavefront_t *dev, wavefront_patch_info *header)
 				      "alias for %d\n",
 				      header->number,
 				      header->hdr.a.OriginalSample);
-    
+
+	if (header->number >= WF_MAX_SAMPLE)
+		return -EINVAL;
+
 	munge_int32 (header->number, &alias_hdr[0], 2);
 	munge_int32 (header->hdr.a.OriginalSample, &alias_hdr[2], 2);
 	munge_int32 (*((unsigned int *)&header->hdr.a.sampleStartOffset),
@@ -1202,6 +1205,9 @@ wavefront_send_multisample (snd_wavefront_t *dev, wavefront_patch_info *header)
 	int num_samples;
 	unsigned char *msample_hdr;
 
+	if (header->number >= WF_MAX_SAMPLE)
+		return -EINVAL;
+
 	msample_hdr = kmalloc(WF_MSAMPLE_BYTES, GFP_KERNEL);
 	if (! msample_hdr)
 		return -ENOMEM;
-- 
2.25.1

