Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5481C352BE
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202F020771
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ry232IQY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nYkexzPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 770BA15E4;
	Thu, 16 Apr 2020 17:00:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 770BA15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587049285;
	bh=zOG/5BQPOtLkRZUPaq2fkmWdUSy0ZsX2yYjpGZQtqao=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ry232IQYieRL3U1FqZGxjD8aSqbb/ChH035iCIErpZdUbWbSkJ93Bl73hB4I1IWgb
	 9B1DueQr/1vsAWK4wlYNbHziljj6rxBKuvVb464mpUzA5j0tWIBHZ/neLEGgK/XTYA
	 h03C8xcTlBeMHr3cahbZf8gSTrTDj9LzFj6QAAXE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89DE0F80115;
	Thu, 16 Apr 2020 17:00:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE0F3F8027D; Thu, 16 Apr 2020 17:00:31 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEAADF80115
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 17:00:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEAADF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="nYkexzPU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=uYntwwOxHl+eWmrggy0D1lZ6buzvACNOsmvvl0lx4SM=; b=nYkexzPURS/EEaBQzLNs6ZJPtY
 iXXeif5/EFTvuipZKQz0BouVV3czxminJPIipTRWE+1tuUi/189SxUUAIXh+sMh1wE/AMHQuQhCLa
 wFYwxEplgeD16FEvzoPHa6ClGQ9ZK/lcHBr/wKiIYTFTwBYcbWmyCjfA5wAEpmDx1hjBN4Ke48VTI
 FVSQ48dRRq+fZWRGREvz+o/oEt4q2IrPWYh1DLPvCBPJb6QlCzuSz7qQojJXH6J7j6sucJumsagVP
 9EFeSRjp/5S4kgcB43Q9ag7iqI2D9LhbhvheItZ9PTRz6xXRXnZFT6OUTM6P3MZ8wTGzfngQoVLhQ
 tywJXWRA==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jP5zx-0001nv-Jg; Thu, 16 Apr 2020 15:00:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: MIPS ioremap cleanups v2
Date: Thu, 16 Apr 2020 17:00:04 +0200
Message-Id: <20200416150011.820984-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-mips@vger.kernel.org
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

Hi Thomas,

below is a bunch of cleanups for the MIPS ioremap code.  Compile tested
only.

Changes since v1:
 - don't remove cpu_has_64bit_gp_regs
 - add a new prep patch to stop txx9aclc-ac97 from poking into ioremap
   internals
