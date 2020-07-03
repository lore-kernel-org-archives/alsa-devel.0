Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43945C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C215B20836
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EYKQt55u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psByuhp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C215B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23E7F16C9;
	Fri,  3 Jul 2020 10:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23E7F16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593763294;
	bh=0m0PqSPG6ho64BTubRWkyfjgHecGjhnT4uj/8xUJT84=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EYKQt55uXnJjQWt5/vK492i3XUNp0PrahpQGwyinNjYLLoUVUWuV0banVvQGY5vSf
	 /fFjBO2s/zE5BOUqEyoWi1d0ueS8i9+bYBz15Z6+JAxVSS5Kf60lgqX3qXyMTBrIm/
	 C0CAwIG1tv/YZ3cvoqp4ruIAC4+SJ8rmSQwhi/dU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A75E3F8021D;
	Fri,  3 Jul 2020 10:00:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60C25F80229; Fri,  3 Jul 2020 10:00:42 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 900BEF800E2
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 10:00:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 900BEF800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="psByuhp/"
Received: by mail-pf1-x441.google.com with SMTP id t11so8811003pfq.11
 for <alsa-devel@alsa-project.org>; Fri, 03 Jul 2020 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Yj8qm+ZjMMuqpW6byI8D4mcOU1e39mK/6D2s6ZESy0=;
 b=psByuhp/4WBy1N9pkVM213Zmxq+FgXa1BBvYSpe5y4mNAB/o2zVIi81M3jzOVz4BxR
 PkE6XeE1mcDcQ2ZLOnk2NzwWsligeHLCvP7X3L/RcaRBxtjUfkCjjWQ6cfUMa3ZM0+nz
 WbI1NCxYflS1whwzvPmJljfFz89i5RgiUg/ANFs7Aa4afLPl81FD2PV4o246+f0O4zxh
 JLBPaq+vCk1lpMfTpxw7P5kelFmWPDbhDiE0cRpUuoMnvPwYrdHvaiVK6F30T5Kr6oGg
 rcVFrSbZoN2JksuyFEXUf51XxL+0LZxw1dZoO9t3w9LOkoRCHybmXi8ekXB6JaRwZcDp
 bPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Yj8qm+ZjMMuqpW6byI8D4mcOU1e39mK/6D2s6ZESy0=;
 b=O0d4qdIzUQEOlPHyhw1Y/OrKDRyCJRBoJPGmWzdSmEZyYBIj2zDUwBPpMPOgzYhcpI
 ZOx1JX1EufiGZGmJ1bhj4/j7oqv9geooG1RNi6+RdoKsMltV7h87XAUa1iQ85cfh5HM7
 twdJToi/Gtp1zIAmaAL55IK8oHI8yBXZBXtDuHyH0lJWzIFATCUx5zQEHns9yG8tI5K7
 oXWKmBy1eklrEtSl+2N4woaq5NjsepgEKYocMIQdU1Iqg46bRYxlsFxzvjUZj4D2OM3Q
 arbpKMkbWjtBk5xp+1FqIgQlB4Tvf84qz8KdVM+xGivMxK+HElO22oduM78Y32eDeJQQ
 I6BQ==
X-Gm-Message-State: AOAM533MxgF+v8JumSuBIZ8PVnqpUs39DGqQaw5Dpex4GQ9T2g4gRnDL
 XbpqBYRjj2Qu9YUb2S2xXQy8RMaWyn4=
X-Google-Smtp-Source: ABdhPJwRIIlkAgcfUcKIKxgPQ+QqSaMCkQUGC8zA339FUNFmF4ZuaqfTyDFZERMNg9fPqmCfG0bqNw==
X-Received: by 2002:a63:6442:: with SMTP id y63mr26861019pgb.18.1593763234991; 
 Fri, 03 Jul 2020 01:00:34 -0700 (PDT)
Received: from f3.nvidia.com (ae055068.dynamic.ppp.asahi-net.or.jp.
 [14.3.55.68])
 by smtp.gmail.com with ESMTPSA id 17sm8956411pfv.16.2020.07.03.01.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 01:00:33 -0700 (PDT)
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/2] Fix Lenovo ThinkPad X1 Carbon 7th gen bass volume
Date: Fri,  3 Jul 2020 17:00:03 +0900
Message-Id: <20200703080005.8942-1-benjamin.poirier@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.com>,
 Hui Wang <hui.wang@canonical.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Vincent Bernat <vincent@bernat.ch>, Even Brenden <evenbrenden@gmail.com>
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

This is an updated version of the patchset to fix the low output volume on
the Lenovo ThinkPad X1 Carbon 7th gen. With these patches, the volume
output with the Linux driver matches the one with the Windows driver.
Volume control is effective and headphone output is unaffected.

Multiple users of this machine have reported a low output volume [1] when
using a kernel with commit d2cd795c4ece ("ALSA: hda - fixup for the bass
speaker on Lenovo Carbon X1 7th gen"). Many have tried these patches or a
similar workaround using `hda-verb` and prefer this configuration[2].

As noted in patch 2, the changes also depend on an associated alsa-ucm-conf
change.

[1]
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3227516
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3240090
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3296637
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3304699
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3343871
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3349803
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3361380
...

[2]
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3343252
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3344118
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3345062
https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3345107
...

Changes:

v1
==
https://lore.kernel.org/alsa-devel/20200211055651.4405-1-benjamin.poirier@gmail.com/

v2
==
* patch 1
Shortened log

* patch 2
Change log to replace experimental observations by information from diagram
posted on kernel.org bugzilla.
Select exactly the desired connection for node 0x17 (bass speakers) instead of
reusing alc295_fixup_disable_dac3().
Control node 0x21 (headphones) connection to avoid the volume "wobble"
effect described in the log.
Include SET_CONNECT_SEL command in fixup since it is not done by the hda
core.
Rename one control to reflect its new function and to use as a condition in
the ucm config.


Benjamin Poirier (2):
  ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon 7th quirk subdevice
    id
  ALSA: hda/realtek - Replace Lenovo Thinkpad X1 Carbon 7th quirk

 sound/pci/hda/patch_realtek.c | 57 ++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 5 deletions(-)

-- 
2.27.0

