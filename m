Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F21C433E7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:45:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD4D206A1
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hKC/It9c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="quJJfzfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD4D206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A490817FE;
	Fri, 16 Oct 2020 19:44:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A490817FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602870315;
	bh=CyUOXawtAJ/YtX3lSH33JcvAa+eCNOiuYGK0b1leo7c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hKC/It9cM9ixjVeGtl7ByWEFYqSHd8cviR9Fk0YJUdnGD8p2vCi+Db5xE0TJBUXX6
	 HBsJq7uluoKWZPKJR3bhwf1YO9rjKVWyaRY0/MFkd5RBtWxmbmCSdBkp4VtYS6y0Xq
	 +fZi8kR2Ob/HDxMNaOfbe+4ksfvOB0jnqvfjUiCU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D44FF8020D;
	Fri, 16 Oct 2020 19:44:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 029B6F80217; Fri, 16 Oct 2020 19:44:22 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AC00F8012A
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 19:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AC00F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="quJJfzfn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=ulZhfOaT326t3jGYse1j4xMTDwyENBzxSWrUOICpdO0=; b=quJJfzfnf2yaTN/ghqHd4IS8j1
 Qr0FYhlAtq0SkYxc82uQo+8qU+XouBmOdnQvkP9GvhrFYQM5liTSxedt1OLPwG5cTb2VvU/4rVZAV
 siLHLWjQnxzlCyWjblJDdOiO3i62CImUeobXVuHg89702qFRSV8lj6qgI6fyV4Z5kHtn2/iEJ4Rdi
 x1MadF5GDGpsBQCWV2JUj6/9CoeVYSVafwO7Xj1KDQp/l20cVWhEyMvV8bHCNn5qK1dYWONPZJR2J
 frmH6ahoMYQNNIuHdrTQ8bk6k2EJrl85ZciACqeg2S39UMEGvw95CWJtZzQx2F0k7+3duyg5SQ5ww
 TJVhEZzA==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTTlx-0002zY-JA; Fri, 16 Oct 2020 17:44:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] sound: sparc: dbri: fix repeated word 'the'
Date: Fri, 16 Oct 2020 10:44:05 -0700
Message-Id: <20201016174405.17745-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org,
 Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.com>
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

Change the duplicated word "the" to "Then the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Joe Perches <joe@perches.com>
---
v2: use "Then the" instead of just "The". (Joe Perches)

 sound/sparc/dbri.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201016.orig/sound/sparc/dbri.c
+++ linux-next-20201016/sound/sparc/dbri.c
@@ -620,7 +620,7 @@ A circular command buffer is used here.
 while another can be executed. The scheme works by adding two WAIT commands
 after each sent batch of commands. When the next batch is prepared it is
 added after the WAIT commands then the WAITs are replaced with single JUMP
-command to the new batch. The the DBRI is forced to reread the last WAIT
+command to the new batch. Then the DBRI is forced to reread the last WAIT
 command (replaced by the JUMP by then). If the DBRI is still executing
 previous commands the request to reread the WAIT command is ignored.
 
