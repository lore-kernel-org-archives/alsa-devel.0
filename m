Return-Path: <SRS0=+QmS=EH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB1C2D0A3
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:22:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D054E221FE
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U3Zh798r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M97OGdos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D054E221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C8A216A6;
	Sun,  1 Nov 2020 18:21:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C8A216A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604251353;
	bh=1RLxWMvU80jaaPPwvWGgr+tyssSzOrKEgSYaCXfycSI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=U3Zh798r6bKnXj8HIBG8woXbgCWVYgMMs/HiUftOUWU8zLpsM4o4bp5PU1x3UmjNn
	 EVlLU6hoB+NyefCQdFdz+2LaADW/g3nPOH+zxPg1jUyJvsw+1ltVQjWNq6lBUrmTyn
	 lv8ILm9GoYt6iyXCKLpD+CDhdnzGLmbakIaYa7lA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7737F8015F;
	Sun,  1 Nov 2020 18:21:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4727FF80162; Sun,  1 Nov 2020 18:21:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8F58F8015D
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2020 18:21:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8F58F8015D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="M97OGdos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604251296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=j4Fd3vNf6QkiJ2K1fA3WX6EFw4MpOCKOi1CDGbw0lNw=;
 b=M97OGdosgypfbEJvXncD6gA8+YsXQr6xfKAnrLy/GJ/zViOz/i9BepOUp2+fadoMPNvbfS
 Nq28O1KlDEkOziHvuYCQASm6zrGdqmPcRxz3l4aOjjn8T5uPL8vemHmZiiJhjf3KnRfJsA
 n3Hc/VPo8nLRw7zcdwPJKYxHdG5YGro=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-0Brb1J9HOQacQao50gQgrg-1; Sun, 01 Nov 2020 12:21:35 -0500
X-MC-Unique: 0Brb1J9HOQacQao50gQgrg-1
Received: by mail-oo1-f69.google.com with SMTP id 4so4688188ooc.21
 for <alsa-devel@alsa-project.org>; Sun, 01 Nov 2020 09:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=j4Fd3vNf6QkiJ2K1fA3WX6EFw4MpOCKOi1CDGbw0lNw=;
 b=AXVYNGeS80efoF0ogtFBkIqCXK7dYWG91w2xYxu1yoRawrP2Tymr49uY4YxM46odyF
 IvU+S+8e0kzRHNzbkyob8huc60p7PRsA+kgfCmthnLchFuqL2Oc/TLjxSusBW/0fCbUi
 PX/k4wHao/ia2Xx38npJ4gCI9Fg9b25zbLSuvxxX1TzA3kkwLGZl328gU5K4BMBS/xTM
 TTlwEgO3BjEdNFQATuC9oN71EBrgoJtbgN9JyNA2N+CZOd30JLJDRmGxvRVY9DPYH61A
 eN8gWd++qBiw9/VNNOBWcIo9NaR7OOHISaJFjYGRXpYkJNgvrPKkj76EazQ/3eHq4znI
 SnVQ==
X-Gm-Message-State: AOAM5309XRHWPibv6fKO2MAFi7EXQsO2d6/fMGVLwUj18fByBnBE3gVe
 Far2a1SMk865aPR3K4nCKoOXhf3QcBFrpJVA+qTWPVN/hQ8P6p1w2C0ZqDStXGDn5wutjEq88bu
 Tr5tr0isJZU6NMBnou6Axrlc=
X-Received: by 2002:a05:6808:696:: with SMTP id
 k22mr8123484oig.107.1604251294252; 
 Sun, 01 Nov 2020 09:21:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhggkrimbcrzhi+3d89K9YE9zyRIbl7xcXdDmd6ao4Lvit7XtdyjCGL1x9+BZ19J1MOGOvMA==
X-Received: by 2002:a05:6808:696:: with SMTP id
 k22mr8123461oig.107.1604251293781; 
 Sun, 01 Nov 2020 09:21:33 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id x13sm2965686otg.66.2020.11.01.09.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2020 09:21:33 -0800 (PST)
From: trix@redhat.com
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 kuninori.morimoto.gx@renesas.com, srinivas.kandagatla@linaro.org
Subject: [PATCH] ASoC: wcd9335: remove unneeded semicolon
Date: Sun,  1 Nov 2020 09:21:28 -0800
Message-Id: <20201101172128.2305539-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Cc: Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/wcd-clsh-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 817d8259758c..73258e292e7e 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -507,7 +507,7 @@ static bool wcd_clsh_is_state_valid(int state)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 /*
-- 
2.18.1

