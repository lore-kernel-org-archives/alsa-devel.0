Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A061C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:25:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3C92083B
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UCE9DIHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3C92083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B744167C;
	Fri, 19 Jun 2020 19:25:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B744167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592587557;
	bh=xhnZNjD30KpzbgevAKvUO9PfvISuyPJ+vLNl3xTSVkA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UCE9DIHc4NL5OgqngsJsGIH2AFsLSqjpvrKAHtnxrKUVOaz9sHVJryChaX3XDZVgx
	 t88nbVQQaQG0BkC/YM8bTKj/rOZQ+ua7M6J1Rb7Mah/gYBDLHBRIT834eSAr2n2vZe
	 XIiATZCpzPWgyMwgZExy66P9X465ZlHl+ucwVQjw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87B01F8025F;
	Fri, 19 Jun 2020 19:24:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 971C3F8028A; Fri, 19 Jun 2020 19:24:16 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E9E4F800EF
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 19:24:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E9E4F800EF
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2FFD1AB64;
 Fri, 19 Jun 2020 17:24:05 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-lib 2/2] pcm: dmix: make lockless operation optional
Date: Fri, 19 Jun 2020 19:24:04 +0200
Message-Id: <20200619172404.26826-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200619172404.26826-1-tiwai@suse.de>
References: <20200619172404.26826-1-tiwai@suse.de>
Cc: Maarten Baert <maarten-baert@hotmail.com>
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

The recent overlooked bug about the unconditional semaphore usage in
the dmix implies that basically we've had no problem with the locking
in the practical usages over years.  Although the lockless operation
has a clear merit, it's a much higher CPU usage (especially on some
uncached pages), and it might lead to a potential deadlock in theory
(which is hard to reproduce at will, though).

This patch introduces a new configure option "--enable-lockless-dmix"
or "--disable-lockless-dmix" to let user choose the default dmix
operation mode, then the default value for the dmix
"direct_memory_access" option is set based on it.

A big question is which operation mode should be default: it's hard to
decide, but in this patch, I bet for disabling the lockless in the
end as the performance loss is significant.

But the user can enable the lockless operation at any time; at build
time, with the configure option above, and at run time, by specifying
the dmix "direct_memory_access" option, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac         | 13 +++++++++++++
 src/pcm/pcm_direct.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/configure.ac b/configure.ac
index 4577c417037a..75d037d5509a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -629,6 +629,19 @@ if test "$build_pcm_mmap_emul" = "yes"; then
   AC_DEFINE([BUILD_PCM_PLUGIN_MMAP_EMUL], "1", [Build PCM mmap-emul plugin])
 fi
 
+if test "$build_pcm_dmix" = "yes"; then
+AC_MSG_CHECKING(for default lockless dmix)
+AC_ARG_ENABLE(lockless-dmix,
+  AS_HELP_STRING([--enable-lockless-dmix],
+    [use lockless dmix as default on x86]),
+  lockless_dmix="$enableval", lockless_dmix="no")
+if test "$lockless_dmix" = "yes"; then
+  AC_MSG_RESULT(yes)
+  AC_DEFINE([LOCKLESS_DMIX_DEFAULT], "1", [Lockless dmix as default])
+else
+  AC_MSG_RESULT(no)
+fi
+fi
 
 dnl Create PCM plugin symbol list for static library
 rm -f "$srcdir"/src/pcm/pcm_symbols_list.c
diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 665340954cf3..c38ba3190f1a 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1892,7 +1892,11 @@ int snd_pcm_direct_parse_open_conf(snd_config_t *root, snd_config_t *conf,
 	rec->slowptr = 1;
 	rec->max_periods = 0;
 	rec->var_periodsize = 0;
+#ifdef LOCKLESS_DMIX_DEFAULT
 	rec->direct_memory_access = 1;
+#else
+	rec->direct_memory_access = 0;
+#endif
 	rec->hw_ptr_alignment = SND_PCM_HW_PTR_ALIGNMENT_AUTO;
 	rec->tstamp_type = -1;
 
-- 
2.16.4

