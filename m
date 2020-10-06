Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A4C4363D
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:05:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3AE20760
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iPk7HoAg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT7YO5mX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3AE20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B3C616C7;
	Tue,  6 Oct 2020 16:04:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B3C616C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601993100;
	bh=Lj8LmYIDdDAeKpaYHWSshOa9hH6sWSOg/YlZHcnjBx4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iPk7HoAgZsfgCdw7VXajWbWrj4KRoHDC4zbgi33m0b+VSROuCbQdzXEAlJ4IErOGN
	 rSt5lBlJjfKGOzpkRHdpk6S4AQ6nrvLgcBcP9nHPj4urJc8G2SPy6S+WvrZTFNPy6h
	 no2+srD5gKTRAFKgeX5uOZg1Ema2G/fn5X0zXIK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B810F8012B;
	Tue,  6 Oct 2020 16:04:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7747AF80163; Tue,  6 Oct 2020 16:04:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7F82F80128
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 16:03:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7F82F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rT7YO5mX"
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de
 [95.90.213.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A664A22208;
 Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601993034;
 bh=Lj8LmYIDdDAeKpaYHWSshOa9hH6sWSOg/YlZHcnjBx4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rT7YO5mXT3SGjUM0qXRLog3cbipq+By3tZJ6+2qtUVrK0GpL1bb2QcBHOc+1OEh9q
 O1L0bn8RYXfNetbSJvGPRZcR1ceyfhHVAQNgdw5cyom92gu0bENZBM8MxLwTXPqL7o
 adJlfz4NWC7gmleMLmxMW+HCT551Hel0dPtUUrRw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
 (envelope-from <mchehab@kernel.org>)
 id 1kPnZI-0019Fk-9j; Tue, 06 Oct 2020 16:03:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 28/52] docs: remove sound API duplication
Date: Tue,  6 Oct 2020 16:03:25 +0200
Message-Id: <bce75a21aa86d04a67ba784d1a7e07a40608338b.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, Pragat Pandya <pragat.pandya@gmail.com>,
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
index 6e7c702e0268..987d6e74ea6a 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -27,7 +27,6 @@ available subsections can be seen below.
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

