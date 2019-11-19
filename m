Return-Path: <SRS0=I/J9=ZL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6BFC432C0
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:52:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AE02230E
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BRokDfon";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJknM9XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AE02230E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBD3E1687;
	Tue, 19 Nov 2019 11:51:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBD3E1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574160718;
	bh=PcBF8RdJ+3C7un2/mNjBN9AdpWBvuca3uLRq/d6z/Cs=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BRokDfonL5XcfkQhWrpS3lxXjj8fIjn8ouKwW82YPPAQqUM1ab00vgoOJ5zWYBqxr
	 EHql5YV9q15ED+1NvmpaHVHQwyRPz3JSl6c13tjsm748iYHM8GKKB6w2WV/MTeTnqb
	 OCTaLQwJAvwSSEfsn+4VbnPEMYlkFTIYgHrTtlFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C99FF80137;
	Tue, 19 Nov 2019 11:51:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81CF6F80137; Tue, 19 Nov 2019 11:51:06 +0100 (CET)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E230BF80135
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2019 11:51:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E230BF80135
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="BJknM9XM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574160662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ESRDlT7hNZgOF/vVvhVTPxK93xDPT4eEO3AYLANc1I=;
 b=BJknM9XMleSPlNRXQaA/k5p8Zk62kqMiQkKumpqRO1vqQt6R/AWD0OSJ+b4RLo7JVfYTbe
 taBC25JRR1hq7UP8g/1PWYltiyDCle/4ZlOO8SMwye0dCuImEzQ3mDHmk/9jz1aBZNwXBI
 Uu64Dwzpr4RpXOkqB3zhN+cBMJbDmKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Bm7zS63xPoKPfcfVrdu3vw-1; Tue, 19 Nov 2019 05:48:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 033EC8018A2;
 Tue, 19 Nov 2019 10:48:31 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-49.ams2.redhat.com
 [10.36.117.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E01CB2935F;
 Tue, 19 Nov 2019 10:48:29 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jaroslav Kysela <perex@perex.cz>
Date: Tue, 19 Nov 2019 11:48:22 +0100
Message-Id: <20191119104822.15053-4-hdegoede@redhat.com>
In-Reply-To: <20191119104822.15053-1-hdegoede@redhat.com>
References: <20191119104822.15053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Bm7zS63xPoKPfcfVrdu3vw-1
X-Mimecast-Spam-Score: 0
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH alsa-lib 4/4] ucm: parser: Fix snprintf usage
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

There is no need to manually 0 terminate the buffer with snprintf,
only strncpy has the very unfortunate behavior of not guaranteeing 0
termination.

Likewise there is no need to substract one from the buffer size of
the buffer passed to snprintf.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/ucm/parser.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 319e3c1a..305d36c5 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -71,7 +71,6 @@ static void configuration_filename2(char *fn, size_t fn_len, int format,
 	snprintf(fn, fn_len, "%s/ucm%s/%s/%s%s",
 		 snd_config_topdir(), format >= 2 ? "2" : "",
 		 dir, file, suffix);
-	fn[fn_len-1] = '\0';
 }
 
 static void configuration_filename(snd_use_case_mgr_t *uc_mgr,
@@ -96,7 +95,6 @@ static void configuration_filename(snd_use_case_mgr_t *uc_mgr,
 	}
 	if (env) {
 		snprintf(fn, fn_len, "%s/%s/%s%s", env, dir, file, suffix);
-		fn[fn_len-1] = '\0';
 		return;
 	}
 
@@ -1712,11 +1710,10 @@ int uc_mgr_scan_master_configs(const char **_list[])
 	struct dirent **namelist;
 
 	if (env)
-		snprintf(filename, sizeof(filename)-1, "%s", env);
+		snprintf(filename, sizeof(filename), "%s", env);
 	else
-		snprintf(filename, sizeof(filename)-1, "%s/ucm2",
+		snprintf(filename, sizeof(filename), "%s/ucm2",
 			 snd_config_topdir());
-	filename[sizeof(filename)-1] = '\0';
 
 #if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun) && !defined(ANDROID)
 #define SORTFUNC	versionsort
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
