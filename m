Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D8ECE58D
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 15:37:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A81218DE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kVnSzaTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A81218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E05E86E;
	Wed,  9 Oct 2019 17:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E05E86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570635434;
	bh=0TooBOv7NvymHvvdUSDXTBNcgjKGWB5XJmBd6myIbIQ=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kVnSzaTUxIpIRBnt9bP4nelfBAS9lhgkAgurN1ASG5521tFdLvnivaS8r5JarScyR
	 IOKYXDgqEctI6dk1ULVqYt6ozXDCKYBKEI3nhhKP24Z9+9K3JlFozuPvONqhYKp1ke
	 sIENNxtqOUQjU0JZnt8zEFU2FbfFQea3Lrb6bVEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 052FAF802BE;
	Wed,  9 Oct 2019 17:36:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE25CF802FB; Wed,  9 Oct 2019 17:36:21 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FF95F800AE
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 17:36:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FF95F800AE
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D09F1A019D;
 Wed,  9 Oct 2019 17:36:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 105A21A0084;
 Wed,  9 Oct 2019 17:36:17 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net
 (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C5392060B;
 Wed,  9 Oct 2019 17:36:16 +0200 (CEST)
From: Daniel Baluta <daniel.baluta@nxp.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org
Date: Wed,  9 Oct 2019 18:36:13 +0300
Message-Id: <20191009153615.32105-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>,
 linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com,
 linux-imx@nxp.com
Subject: [alsa-devel] [PATCH 0/2] ASoC: simple_card_utils.h: Fix two
	potential compilation errors
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

For this to happen we symbol DEBUG to be defined.

Daniel Baluta (2):
  ASoC: simple_card_utils.h: Add missing include
  ASoC: Fix potential multiple redefinition error

 include/sound/simple_card_utils.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
