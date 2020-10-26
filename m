Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C74C388F7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:07:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7315241A7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gIMPBV+C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwTgG+gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7315241A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3C811670;
	Wed, 28 Oct 2020 09:06:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3C811670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603872443;
	bh=KJYE8gFCxcABOu+mEh1/geb/uvls5Kdzq9bEPy3r3WA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gIMPBV+CJqk/JIubmZdqyxf1/zvy5zIf1TrWVYmZGL2b6w22oHOE7FvPpYkMoEro4
	 7xA/MODM7PsYHXpfwjihZkMWdmYG+uXKc/7s7+ENINV5ulrg8B9AykSkfwLH8FSSEY
	 72zPgY1kL1YmF06A2GkeZAuz/PBzZgwV8ynX/dwI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08B40F800E1;
	Wed, 28 Oct 2020 09:06:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDA8AF800CC; Mon, 26 Oct 2020 17:57:32 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92C63F800CC
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 17:57:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92C63F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mwTgG+gh"
Received: from localhost.localdomain (unknown [192.30.34.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6CE52224A;
 Mon, 26 Oct 2020 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603731442;
 bh=KJYE8gFCxcABOu+mEh1/geb/uvls5Kdzq9bEPy3r3WA=;
 h=From:To:Cc:Subject:Date:From;
 b=mwTgG+ghrS6T6iSLk4o3A1Hvrlvx5MPbBTjN2iUiafRZQfdvqPlnxkZ8Z0xcC3188
 Eej8oZZx9Il5aXSINQD6i5Rzj6f2zBZrcRuJhE+niebQA4k52ngNOlat02e12LuFIt
 SktXasRb5POhEX2YkF2Y9meQRuhVvgcmUxwfA88M=
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: make snd_kcontrol_new name a normal string
Date: Mon, 26 Oct 2020 17:52:18 +0100
Message-Id: <20201026165715.3723704-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2020 09:06:29 +0100
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
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

From: Arnd Bergmann <arnd@arndb.de>

When building with W=2, there are lots of warnings about the
snd_kcontrol_new name field being an array of 'unsigned char'
but initialized to a string:

include/sound/soc.h:93:48: warning: pointer targets in initialization of 'const unsigned char *' from 'char *' differ in signedness [-Wpointer-sign]

Make it a regular 'char *' to avoid flooding the build log with this.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/control.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index e128cff10dfa..77d9fa10812d 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -42,7 +42,7 @@ struct snd_kcontrol_new {
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
 	unsigned int device;		/* device/client number */
 	unsigned int subdevice;		/* subdevice (substream) number */
-	const unsigned char *name;	/* ASCII name of item */
+	const char *name;		/* ASCII name of item */
 	unsigned int index;		/* index of item */
 	unsigned int access;		/* access rights */
 	unsigned int count;		/* count of same elements */
-- 
2.27.0

