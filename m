Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B932C63797
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Jan 2023 23:45:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82B7A9E2D;
	Fri, 13 Jan 2023 00:44:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82B7A9E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673567128;
	bh=jfdHidMabXXieYkDUpm+UdOLlSTN6GG3E7NjYRUcBVI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=iIyjMB7XHjS+y8X9BS48Kv5rdUI2ersCni9iv+g9uS25OLDC0Zllte0GfI3PV5rk4
	 Qk/0EhnF8bMz43e0GjP20CdtqruxTitgqtYPCB2C3lIgbPxsPHu0A1EdVtWdhp3j67
	 9a78EnsAaWoX/MYdahRe0AnKZXc42N6HlOnotwb8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B59DF804C1;
	Fri, 13 Jan 2023 00:44:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DFC9F804BD; Fri, 13 Jan 2023 00:44:36 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4EAEF8013D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 00:44:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4EAEF8013D
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TgUpO3rj
Received: by mail-pj1-x1032.google.com with SMTP id n12so20732449pjp.1
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2023 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TW7nZwtXvq7y1k60RlWkCYmvZPHsdjErvYSMre+x70E=;
 b=TgUpO3rjKMdZJgZeVdg7uctPo7kKRZgIIyGRegrat8L9LyUHv20NH4AYc2W3oDbSoS
 xt+hOOZSY0ot694vl2uB7XnOwESc/T9A8W6XDK/95t6EPjv9+/HhadlsenouW0cOtfvZ
 T6KgiMSs8yQexs1BDHppi+GWKEox7wzNaHMKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TW7nZwtXvq7y1k60RlWkCYmvZPHsdjErvYSMre+x70E=;
 b=JwVuUwY9U0uhtQgsNggLE0UPFL+TToLB5TauTbD1amtA2UPAgJfyO4PBUbSCvfMIEX
 NDCABoInM6/Fzhvrt7VA56yvNWBckoiWRByIgSrnworMw8jeow17nxHn5Y0vXxymtQ9t
 6hUcMIjqQifAtzBk6aJMRR9OCTAeit5dD6kcgdfNazlgI003m7cnTovZK8uT1VpouGmQ
 gmkvY+ZUDaf/3+jiNUSSl7sEd9vWEi1oFN76+Ar4E1pXby7ahVFZ4Beti4ZAWNqrl1xF
 3UeaonL6TjKKI8DGgz2r1LbmckJ+x9J08zQ+c4oH5/v8tH72xvFqLOlAqrqNc4z9Kjf/
 Bm9A==
X-Gm-Message-State: AFqh2kpeGx41RuwG6CPPgLSX5ex74JpaqunH3pDADuoZYJFh17EPEufI
 l6OWw9WRchLrrn6cPKcUQiEuDcu3UKf7J7g=
X-Google-Smtp-Source: AMrXdXuGqL1XPNVNHP2b6b+8ibsLXWK8aQ4mD/Yq4R15qGn1FuQDgTqlPMY7Lw4Su8xj06A8tbXhtQ==
X-Received: by 2002:a17:902:a9c8:b0:194:4a0e:3024 with SMTP id
 b8-20020a170902a9c800b001944a0e3024mr8044907plr.62.1673567071063; 
 Thu, 12 Jan 2023 15:44:31 -0800 (PST)
Received: from localhost ([2620:15c:9d:4:3375:381:fcab:585f])
 by smtp.gmail.com with UTF8SMTPSA id
 o1-20020a170902d4c100b0019320b4f832sm1730979plg.178.2023.01.12.15.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jan 2023 15:44:30 -0800 (PST)
From: cujomalainey@chromium.org
To: alsa-devel@alsa-project.org
Subject: [PATCH] ucm: add existence checks to geti calls
Date: Thu, 12 Jan 2023 15:44:26 -0800
Message-Id: <20230112234426.1714071-1-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
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
Cc: Curtis Malainey <cujomalainey@chromium.org>, tiwai@suse.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Curtis Malainey <cujomalainey@chromium.org>

Right now in snd_use_case_geti you cannot tell if the item being queried
exists or not when being checked. This also means the only way to check
for the existence of something in the client of the library is to
iterate over the list of mods/devs even if we know exactly the name we
are looking for. We have functions that do exactly this internally so
lets return this information in a logical fashion through geti.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 src/ucm/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/ucm/main.c b/src/ucm/main.c
index 2ff4d3f3..39edf3ae 100644
--- a/src/ucm/main.c
+++ b/src/ucm/main.c
@@ -1321,6 +1321,9 @@ long device_status(snd_use_case_mgr_t *uc_mgr,
 		if (strcmp(dev->name, device_name) == 0)
 			return 1;
 	}
+	dev = find_device(uc_mgr, uc_mgr->active_verb, device_name, 0);
+	if (!dev)
+		return -ENOENT;
 	return 0;
 }
 
@@ -1335,6 +1338,9 @@ long modifier_status(snd_use_case_mgr_t *uc_mgr,
 		if (strcmp(mod->name, modifier_name) == 0)
 			return 1;
 	}
+	mod = find_modifier(uc_mgr, uc_mgr->active_verb, device_name, 0);
+	if (!mod)
+		return -ENOENT;
 	return 0;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

