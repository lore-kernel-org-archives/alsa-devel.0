Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842E5C63793
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 09:51:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5055460725
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 09:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5055460725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A547A16AA;
	Thu, 22 Jul 2021 11:50:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A547A16AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626947479;
	bh=Kbwlt8w6o/6jn6C+GN3lvDJvqGRuUEe+9My7sEXYggo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tFmPGZXecfLNTqlIOG6pY+yQRvNEj+lVKu/sdZtVLjmSs/j3eVYtdK3AHfV25CI8B
	 UWU6TkbAqlx+f6ABesDMzEzCqNkRU86+EaQSdb5LLajGBfUw/J9KaROg2CXsUIUFJj
	 sCR3NUkPMvaNQJsIiloeJ/dvvR8hP1rObuDPapnw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E983F800DA;
	Thu, 22 Jul 2021 11:50:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19D38F80256; Thu, 22 Jul 2021 11:50:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8E50F800DA
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 11:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8E50F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AJezXu+m"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B025161248;
 Thu, 22 Jul 2021 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626947415;
 bh=Kbwlt8w6o/6jn6C+GN3lvDJvqGRuUEe+9My7sEXYggo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AJezXu+mELcrPCJVhsc9iZCYFWmV7Z9eW/ZDCHrITUf2A+bECIQ00tScc50hYk7sd
 iMzI8mc5c7H6if5RfAn7KeUWMOsT3QSV6J8SUOg31CJ6f1TdrvuX8FFNa+wQR4uDDq
 VLLlf1pDMaHtgqCJP9VctcVMIOTpZmDUXc7bXpvIJF9M3NsYIpJ4g5csh6OS1gwbNK
 pkpNQnBmBXRhashshkyK1iKOfR0qRHXEzG1hYncpv7CqVnvlINdRDRlA9Qnj90TiQ6
 fWjAlo4pBOEX2AbW8bOqur+FPyBUDfbm1Ya90ZTuS0fhGvREV1QJxq3iP18opxjt3Q
 IORwo97aI9PTw==
Received: by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1m6VLD-008lGf-CD; Thu, 22 Jul 2021 11:50:07 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] docs: sound: kernel-api: writing-an-alsa-driver.rst:
 replace some characters
Date: Thu, 22 Jul 2021 11:50:01 +0200
Message-Id: <21abe5fa495a05ac1f998ed66184a77e19ac89cc.1626947264.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947264.git.mchehab+huawei@kernel.org>
References: <cover.1626947264.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Takashi Iwai <tiwai@suse.de>,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@protonmail.com>, Maxime Ripard <maxime@cerno.tech>
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

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 255b7d3bebd6..176b73583b7a 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3368,7 +3368,7 @@ This ensures that the device can be closed and the driver unloaded
 without losing data.
 
 This callback is optional. If you do not set ``drain`` in the struct
-snd_rawmidi_ops structure, ALSA will simply wait for 50 milliseconds
+snd_rawmidi_ops structure, ALSA will simply wait for 50 milliseconds
 instead.
 
 Miscellaneous Devices
-- 
2.31.1

