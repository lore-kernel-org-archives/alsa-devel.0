Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD95C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 16:49:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB0364F11
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 16:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB0364F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4EFD168A;
	Thu, 18 Mar 2021 17:48:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4EFD168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616086163;
	bh=qmOszGXrQigjPGMkDGlorZKFnhmuGhktRmahODN9b3Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wnf0DgLT/I1Qw4yzyv3EbIlo5fkuVSGfa56+Gk1QYCOAYta6KEdPr/f0byR6FMR35
	 hEdQwO34MA1AIl4iIPnRDWwQ3e+jO/ANm6Ix8FG9BZqmheqkxtP1ohHETmqUB0bUJ0
	 IHOEUwqd+t12QIbt+ffpELLJNl9JKS57fCmU/I+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 617B8F80163;
	Thu, 18 Mar 2021 17:48:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F745F80165; Thu, 18 Mar 2021 17:48:32 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DF2EF800C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 17:48:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DF2EF800C8
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EEACAAC24;
 Thu, 18 Mar 2021 16:48:23 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib] conf: Fix invalid free at parse_args()
Date: Thu, 18 Mar 2021 17:48:14 +0100
Message-Id: <20210318164814.16052-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Hills <mark@xwax.org>
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

The previous fix for memory leaks introduced a few regression.
The major one is the assert hit in the error path reaching with NULL
or uninitialized sub object.  Also, in other code paths, it's possible
that an already released sub object gets freed again.

Fix those bugs by initializing the sub object properly and add a NULL
check before calling snd_config_delete().

Fixes: ad5f255b4767 ("conf: fix memory leak on the error path in parse_args()")
Reported-and-tested-by: Mark Hills <mark@xwax.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/conf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/conf.c b/src/conf.c
index 14b14b597e16..1bcd65c87b94 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -5080,6 +5080,8 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
 		const char *new = str;
 		const char *tmp;
 		char *val = NULL;
+
+		sub = NULL;
 		err = parse_arg(&new, &varlen, &val);
 		if (err < 0)
 			goto _err;
@@ -5104,6 +5106,7 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
 		err = snd_config_search(subs, var, &sub);
 		if (err >= 0)
 			snd_config_delete(sub);
+		sub = NULL;
 		err = snd_config_search(def, "type", &typ);
 		if (err < 0) {
 		_invalid_type:
@@ -5169,7 +5172,8 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
 		err = snd_config_add(subs, sub);
 		if (err < 0) {
 		_err:
-			snd_config_delete(sub);
+			if (sub)
+				snd_config_delete(sub);
 			free(val);
 			return err;
 		}
-- 
2.26.2

