Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1873BC46466
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:14:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE1A207BC
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BL/TECW2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PpQB70I4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE1A207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF5E317BB;
	Mon,  5 Oct 2020 21:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF5E317BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601925267;
	bh=bAdU0KnsbJTZORMK2Xa7UWu9R1TZjhGEmqD1ayWxRgk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BL/TECW21R+lTVs5NdbAkJS8DvOJVIyi22Oey8Kc6pdLWbk5FijTawTz8BOYoJh4x
	 NlXXyby0kAH1Ap69uvjuZKqZKHPvyJ3bBy1iIw00YbCX3tuVzw3bx3GDm53cQfGtUY
	 GKnkVKLGo1olSbFy8MIAhNssQf80+ZiSc6HSwNtk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B74C3F8025A;
	Mon,  5 Oct 2020 21:12:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBBF3F8025A; Mon,  5 Oct 2020 21:12:47 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED58CF8025A
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 21:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED58CF8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="PpQB70I4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Ot1efaYDsvjq482gOdoiX5oT+UdfmdDcyr15Je6NkZQ=; b=PpQB70I4VaC3UCCrlmu+5H8l6F
 GOMwcinQddJahEiIJ29fsjwftgacq9j5vKrg1zl2WV+85YUGlQ6azUSjYx+jR3iPqjgeRW05g9WgG
 zqUP21XdU17RacM3lMUi6zuozZL9HABJSW5JZDRzpTlo0w6KMBCiRlITgCvXZMmrO/1G3dZB9Av7N
 WlEXwKqqUm8NlVGswUKe/6+Kf0Qc6EQhhGm1n/20QE8z6wDFH+uLWZBlaojMYNdrqJyU5tEZLHF33
 vl8mXcPNCemn8Sqzq0w90qRTue8o8Jc+vfocE5jKd6pJnn9Pb7auyG+fSFB+ag//kW5TxM43lLMui
 hXDdUTFA==;
Received: from [2601:1c0:6280:3f0::2c9a] (helo=smtpauth.infradead.org)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPVuY-00078v-TU; Mon, 05 Oct 2020 19:12:39 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sound: sparc: dbri: fix repeated word 'the'
Date: Mon,  5 Oct 2020 12:12:34 -0700
Message-Id: <20201005191234.12715-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>,
 Takashi Iwai <tiwai@suse.com>
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

Drop the duplicated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/sparc/dbri.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-59-rc8.orig/sound/sparc/dbri.c
+++ lnx-59-rc8/sound/sparc/dbri.c
@@ -620,7 +620,7 @@ A circular command buffer is used here.
 while another can be executed. The scheme works by adding two WAIT commands
 after each sent batch of commands. When the next batch is prepared it is
 added after the WAIT commands then the WAITs are replaced with single JUMP
-command to the new batch. The the DBRI is forced to reread the last WAIT
+command to the new batch. The DBRI is forced to reread the last WAIT
 command (replaced by the JUMP by then). If the DBRI is still executing
 previous commands the request to reread the WAIT command is ignored.
 
