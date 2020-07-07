Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA70C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:02:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42FB206CD
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PsN2zL45";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0Vc3BPL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42FB206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 330F81676;
	Tue,  7 Jul 2020 21:01:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 330F81676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594148545;
	bh=lVBf7fxSxe7emcr0EKVOi3A6xFFfZYFbJ/0I9CPmT1g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PsN2zL45VtX3P4bpWsh9DfPP/ZuDbsaWdy9l4szkxkIMjHrFZJ2E167q8zquPoy7X
	 Jv4HqhRrGPh38+vnn0//T9d3gFuCFK/riRPckBd4trjO8xK84tCbMtr0Pow1u2IPAQ
	 6mqxQWxBHffM594NedeHccmrRePrxNiGdpMriovA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F46AF800D0;
	Tue,  7 Jul 2020 20:59:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71320F80257; Tue,  7 Jul 2020 20:59:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D40BF80216
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 20:59:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D40BF80216
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0Vc3BPL6"
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DE81206E9;
 Tue,  7 Jul 2020 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594148377;
 bh=lVBf7fxSxe7emcr0EKVOi3A6xFFfZYFbJ/0I9CPmT1g=;
 h=From:To:Cc:Subject:Date:From;
 b=0Vc3BPL6ns4zmsJOKmjw/muNFMR6lYCkjw8gaGzyaHtvi59yjbMqvTKTGRTzYkmFf
 ePcSOY2IaTZc58HbxU+XJTnT39PtvHVjNKQC9kAqkNh4n6XPVg/qpiXr+VbP360bDl
 gVkiC/6URN4V3Q/iYXAosk8CXNY5hU4i/cQdZBK0=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/4] crypto: add sha256() function
Date: Tue,  7 Jul 2020 11:58:14 -0700
Message-Id: <20200707185818.80177-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-efi@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@google.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.01.org,
 Ard Biesheuvel <ardb@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

This series adds a function sha256() to the sha256 library so that users
who want to compute a hash in one step can just call sha256() instead of
sha256_init() + sha256_update() + sha256_final().

Patches 2-4 then convert some users to use it.

Eric Biggers (4):
  crypto: lib/sha256 - add sha256() function
  efi: use sha256() instead of open coding
  mptcp: use sha256() instead of open coding
  ASoC: cros_ec_codec: use sha256() instead of open coding

 drivers/firmware/efi/embedded-firmware.c |  9 +++-----
 include/crypto/sha.h                     |  1 +
 lib/crypto/sha256.c                      | 10 +++++++++
 net/mptcp/crypto.c                       | 15 +++----------
 sound/soc/codecs/cros_ec_codec.c         | 27 ++----------------------
 5 files changed, 19 insertions(+), 43 deletions(-)


base-commit: 57c8aa43b9f272c382c253573c82be5cb68fe22d
-- 
2.27.0

