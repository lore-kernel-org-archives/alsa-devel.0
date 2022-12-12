Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C9AC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Dec 2022 13:53:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BB1429C1;
	Mon, 12 Dec 2022 14:52:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BB1429C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670853223;
	bh=8NQ2yYvJE9GIMsCi3LRAdY8S2/zPeVhGFmNsRnCjWdM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ltkbuux8qCur01z53KC8s7aZEt2HMqt6LTonxjFS4lGBoN9dUv23nmc9LDTv5rpnA
	 wslL3IHPYmQGycf62hHuzVWUr4Yhj5hGlCBqlfWo0mBQl8w3A81H8meDaQ+4429Gev
	 NU8j0mIEeoF7PnW/zdmeFG4dEK6M0NrP1FzYap6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 038A3F80494;
	Mon, 12 Dec 2022 14:52:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E26BAF804B4; Mon, 12 Dec 2022 14:52:51 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23B30F80115
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2022 14:52:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23B30F80115
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=f3GK4VaD
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C27B0610A3;
 Mon, 12 Dec 2022 13:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7950CC433EF;
 Mon, 12 Dec 2022 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1670853167;
 bh=8NQ2yYvJE9GIMsCi3LRAdY8S2/zPeVhGFmNsRnCjWdM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f3GK4VaDFJyGOecjUilKvy7qN+ZYeOqYUY06a391havLb/3OazAZ9ah51IT/R333W
 RGqXgX4gtjep3HAXPa4G0uAR6fKcAsiWB8yVlYG/6zpGRU6IMjQ3hLhUQQRT5G42Sf
 tGUX59gSorSR2ek5fWkDjNBO9+M3G5JrHIIDujzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Subject: [PATCH 4.14 06/38] ALSA: seq: Fix function prototype mismatch in
 snd_seq_expand_var_event
Date: Mon, 12 Dec 2022 14:19:07 +0100
Message-Id: <20221212130912.414488781@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212130912.069170932@linuxfoundation.org>
References: <20221212130912.069170932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 kernel test robot <lkp@intel.com>, Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 patches@lists.linux.dev, Kees Cook <keescook@chromium.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 05530ef7cf7c7d700f6753f058999b1b5099a026 ]

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed.

seq_copy_in_user() and seq_copy_in_kernel() did not have prototypes
matching snd_seq_dump_func_t. Adjust this and remove the casts. There
are not resulting binary output differences.

This was found as a result of Clang's new -Wcast-function-type-strict
flag, which is more sensitive than the simpler -Wcast-function-type,
which only checks for type width mismatches.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202211041527.HD8TLSE1-lkp@intel.com
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20221118232346.never.380-kees@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index ab1112e90f88..6f413c711535 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -126,15 +126,19 @@ EXPORT_SYMBOL(snd_seq_dump_var_event);
  * expand the variable length event to linear buffer space.
  */
 
-static int seq_copy_in_kernel(char **bufptr, const void *src, int size)
+static int seq_copy_in_kernel(void *ptr, void *src, int size)
 {
+	char **bufptr = ptr;
+
 	memcpy(*bufptr, src, size);
 	*bufptr += size;
 	return 0;
 }
 
-static int seq_copy_in_user(char __user **bufptr, const void *src, int size)
+static int seq_copy_in_user(void *ptr, void *src, int size)
 {
+	char __user **bufptr = ptr;
+
 	if (copy_to_user(*bufptr, src, size))
 		return -EFAULT;
 	*bufptr += size;
@@ -163,8 +167,7 @@ int snd_seq_expand_var_event(const struct snd_seq_event *event, int count, char
 		return newlen;
 	}
 	err = snd_seq_dump_var_event(event,
-				     in_kernel ? (snd_seq_dump_func_t)seq_copy_in_kernel :
-				     (snd_seq_dump_func_t)seq_copy_in_user,
+				     in_kernel ? seq_copy_in_kernel : seq_copy_in_user,
 				     &buf);
 	return err < 0 ? err : newlen;
 }
-- 
2.35.1



