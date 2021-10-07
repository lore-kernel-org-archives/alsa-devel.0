Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1236C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 10:06:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BFF610E6
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 10:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82BFF610E6
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B6871664;
	Thu,  7 Oct 2021 12:05:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B6871664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633601182;
	bh=LAsIJzDTyxJvL539Kt8KZmRGuapvBiY/jnYzu0ZH25g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mcuser2TXuc1lMpl3X2fzZ2BWtHsk4z+5KCIaVpD2ooQdVdsKzzl3bq4K0StER1da
	 bR1u/nvTIW1XbAA/USZ96sETYDaOLEA002DCdHmBHjJWr0Cf9bb7LHD4qRYlrGD3ox
	 jYkg6ATQF7DA35oYRPGTKE2TbcDFevZIbj0PgGio=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28C8AF802A0;
	Thu,  7 Oct 2021 12:05:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 740B6F804BB; Thu,  7 Oct 2021 12:05:17 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 50979F8028B
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 12:05:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50979F8028B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1633601114061436892-webhooks-bot@alsa-project.org>
References: <1633601114061436892-webhooks-bot@alsa-project.org>
Subject: Double snd_dlobj_unlock()
Message-Id: <20211007100517.740B6F804BB@alsa1.perex.cz>
Date: Thu,  7 Oct 2021 12:05:17 +0200 (CEST)
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

alsa-project/alsa-lib issue #181 was edited from johado:

In dlmisc.c:snd_dlobj_cache_get0() there is a call to snd_dlobj_unlock() in the __err: path which should not be there.
All lock/unlock are done by the callers to this function.

```
--- a/src/dlmisc.c
+++ b/src/dlmisc.c
@@ -359,7 +359,6 @@ snd_dlobj_cache_get0(const char *lib, const char *name,
                free(c);
              __err:
                snd_dlclose(dlobj);
-               snd_dlobj_unlock();
                return NULL;
        }
        c->dlobj = dlobj;
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/181
Repository URL: https://github.com/alsa-project/alsa-lib
