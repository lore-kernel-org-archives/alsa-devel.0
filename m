Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB1CC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:57:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F192080A
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F3tGLiE5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyHH9QCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F192080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07F631668;
	Tue, 13 Oct 2020 13:56:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07F631668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602590232;
	bh=LCf87qwfRfVquJSMBSLMadZoYFzd1py4QT5QAhXaufg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F3tGLiE5gZr/IMSmY/n1hoehyMZY9HJRiv9NRT+vTqJAXCXk53yQxBkKPvOru6QN0
	 WDpcHe0jdwkLSTBx96RPPjX7l3DPO1pEHe++yUVwHChSMLHD7UXCdKzkRmt5DGfp0i
	 kk4iSiI9gEXe1pwoBK0dIc1DGrvRNNdbisyEjkkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7C96F80274;
	Tue, 13 Oct 2020 13:55:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D016F8026B; Tue, 13 Oct 2020 13:54:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE777F801A3
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 13:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE777F801A3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JyHH9QCe"
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de
 [95.90.213.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DDFE02237B;
 Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602590081;
 bh=LCf87qwfRfVquJSMBSLMadZoYFzd1py4QT5QAhXaufg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JyHH9QCeB8AXRiKhLf5T0okefLPKawlctsELk2byhCQhFbhreY7avPbvXcqz7SAbd
 CAkVeoUSHS0632g8d59QsZUrIDk6q2WZ6F0ZVZzbHKfAokPnspSnkpVOjxziHS0qF1
 Eic2Kwbet0jM+7a+fBbVxrXsfCNdxBkQlS1SiFso=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kSIt4-006CUU-EW; Tue, 13 Oct 2020 13:54:38 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH v6 29/80] docs: remove sound API duplication
Date: Tue, 13 Oct 2020 13:53:44 +0200
Message-Id: <135fc08ee65363ee7a916705487cfdf928a3673b.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Pragat Pandya <pragat.pandya@gmail.com>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Michael Walle <michael@walle.cc>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Jacob Keller <jacob.e.keller@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Harald Seiler <hws@denx.de>, Leonard Crestez <leonard.crestez@nxp.com>
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

The sound API is documented on two different parts:
under Documentation/driver-api/sound.rst and under
Documentation/sound/kernel-api/alsa-driver-api.rst.

The alsa-driver-api.rst seems more complete, and APIs
are split per type. There's just one missing kernel-doc
markup there.

Add it and drop the duplicated one.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/index.rst            |  1 -
 Documentation/driver-api/sound.rst            | 54 -------------------
 .../sound/kernel-api/alsa-driver-api.rst      |  1 +
 3 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 Documentation/driver-api/sound.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 5ef2cfe3a16b..90d02c5fb155 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -28,7 +28,6 @@ available subsections can be seen below.
    component
    message-based
    infiniband
-   sound
    frame-buffer
    regulator
    iio/index
diff --git a/Documentation/driver-api/sound.rst b/Documentation/driver-api/sound.rst
deleted file mode 100644
index afef6eabc073..000000000000
--- a/Documentation/driver-api/sound.rst
+++ /dev/null
@@ -1,54 +0,0 @@
-Sound Devices
-=============
-
-.. kernel-doc:: include/sound/core.h
-   :internal:
-
-.. kernel-doc:: sound/sound_core.c
-   :export:
-
-.. kernel-doc:: include/sound/pcm.h
-   :internal:
-
-.. kernel-doc:: sound/core/pcm.c
-   :export:
-
-.. kernel-doc:: sound/core/device.c
-   :export:
-
-.. kernel-doc:: sound/core/info.c
-   :export:
-
-.. kernel-doc:: sound/core/rawmidi.c
-   :export:
-
-.. kernel-doc:: sound/core/sound.c
-   :export:
-
-.. kernel-doc:: sound/core/memory.c
-   :export:
-
-.. kernel-doc:: sound/core/pcm_memory.c
-   :export:
-
-.. kernel-doc:: sound/core/init.c
-   :export:
-
-.. kernel-doc:: sound/core/isadma.c
-   :export:
-
-.. kernel-doc:: sound/core/control.c
-   :export:
-
-.. kernel-doc:: sound/core/pcm_lib.c
-   :export:
-
-.. kernel-doc:: sound/core/hwdep.c
-   :export:
-
-.. kernel-doc:: sound/core/pcm_native.c
-   :export:
-
-.. kernel-doc:: sound/core/memalloc.c
-   :export:
-
diff --git a/Documentation/sound/kernel-api/alsa-driver-api.rst b/Documentation/sound/kernel-api/alsa-driver-api.rst
index c8cc651eccf7..d24c64df7069 100644
--- a/Documentation/sound/kernel-api/alsa-driver-api.rst
+++ b/Documentation/sound/kernel-api/alsa-driver-api.rst
@@ -132,3 +132,4 @@ ISA DMA Helpers
 Other Helper Macros
 -------------------
 .. kernel-doc:: include/sound/core.h
+.. kernel-doc:: sound/sound_core.c
-- 
2.26.2

