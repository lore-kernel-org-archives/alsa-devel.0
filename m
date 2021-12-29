Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74814C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Dec 2021 00:05:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12A4C169E;
	Wed, 29 Dec 2021 01:04:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12A4C169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640736301;
	bh=l2VrKlvU6p9kByWnXJuEa8x8nzfmzBjGvNrH2b/zaS4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vB8L9AytYL+Wwj712JvoY5PIyNyuwSaz3nouxZhkzNT6XJPOCnPwAWTobmMlQSUYh
	 +0kYjE/2P3ZIqvpZmdE/T7Ha8fZCWNBD4EtLrBYNyGUcgAEzEBXjgElaiPsTBUpUl/
	 8vt3/UcYEzq43mo0UQG/+BHXFavcDh6uG6txohfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F614F801EC;
	Wed, 29 Dec 2021 01:04:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CE2CF80224; Wed, 29 Dec 2021 01:04:08 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EB3AF800D1
 for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2021 01:04:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EB3AF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="p+RQPexC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=IVYHkITLQr3nGzfQ9BFyA8syiSU4wobqmDj3DPwcXk4=; b=p+RQPexClJebUkrQMSJaByEtT/
 D+iIffDom7L8JlusDZiFdwP1MJ7sA4Tuu5HqYc1HSczRzrANSPRuV/2BjIpSwTys/eLz8ZHBfPX+f
 50PdHaL8hgACC498S9uCNzzzCHmQ2dE5Hc7rKz422lW11RIHDFeqqo2cJFUTakZPHYCL6imrzaJKl
 ucPq8ab6RmeO1MSHY9AA0tHs0FXW9R07qll2K5O0Z++bcOXvj/w/nnSaB1GjgdOCB0TbD9o8ZYMkN
 BRzCy2jy1frxsN1TW0sfbHzRqWsp/eCbEhJ+uFzG54c4P/WQKwsI8R1rQjCUnnwMs+ZOvsRW667U6
 CNnsESyA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2MRX-001zfg-5C; Wed, 29 Dec 2021 00:03:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] mips: lantiq: add support for clk_set_parent()
Date: Tue, 28 Dec 2021 16:03:45 -0800
Message-Id: <20211229000345.24199-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, John Crispin <john@phrozen.org>,
 Jonathan Cameron <jic23@kernel.org>
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

Provide a simple implementation of clk_set_parent() in the lantiq
subarch so that callers of it will build without errors.

Fixes these build errors:

ERROR: modpost: "clk_set_parent" [sound/soc/jz4740/snd-soc-jz4740-i2s.ko] undefined!
ERROR: modpost: "clk_set_parent" [sound/soc/atmel/snd-soc-atmel-i2s.ko] undefined!

Fixes: 171bb2f19ed6 ("MIPS: Lantiq: Add initial support for Lantiq SoCs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
--to=linux-mips@vger.kernel.org --cc="John Crispin <john@phrozen.org>" --cc="Jonathan Cameron <jic23@kernel.org>" --cc="Russell King <linux@armlinux.org.uk>" --cc="Andy Shevchenko <andy.shevchenko@gmail.com>" --cc=alsa-devel@alsa-project.org --to="Thomas Bogendoerfer <tsbogend@alpha.franken.de>"
---
 arch/mips/lantiq/clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20211224.orig/arch/mips/lantiq/clk.c
+++ linux-next-20211224/arch/mips/lantiq/clk.c
@@ -164,6 +164,12 @@ struct clk *clk_get_parent(struct clk *c
 }
 EXPORT_SYMBOL(clk_get_parent);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
 static inline u32 get_counter_resolution(void)
 {
 	u32 res;
