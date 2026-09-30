Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CF5CA5FC4
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:27:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D792B60269;
	Wed, 30 Sep 2026 23:27:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D792B60269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790803634;
	bh=0y1reuxmu0xha+5l109WIPSaNzS8uovl0bKsvzue7C0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SHBSw+nHRzc8Z3e4iywE6FLWjI3MjoL8BXafxIkQ8pU291IHKjGkH6RHDgI0Fgfal
	 amso4+kZGuKBTV3ob+SuQckO+m+oxcw86UuKRyGUkTSycG5pZvx6glPOXj1BjZLNKK
	 7Yt/nApepu0UKUa0/yLHc/STNjZdBXeXTncWa/mQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D20F4F805F7; Wed, 30 Sep 2026 23:26:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C06AF80549;
	Wed, 30 Sep 2026 23:26:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36453F80542; Wed, 30 Sep 2026 23:26:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.225.140
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790803593;
	b=FHTdXNnIXx8P5X8wdiYykKDUReaCJXiHeyJfuhIYfWxKYno8bNMmzHzy5yhfTHPPbKo0
	 HTRnnFXIfKI9BDVMVXdWmsjomXDwBk7mSfOEfdOHBlzS5v6fv5DsmWQIDRtrScqoi8F0f
	 zKMq6j+bPOhMu5rxnS1BVzPS8XmXrViirnDTEYJEpWx8KSR1nNsaThV8SsgE/TF7/yoSX
	 VI1y5OZSvyM+7q1QiXvDW7N0M72wnLYRo9d6glngs8/RNu3vk0lEVm5kKM3QNGPp+hOCU
	 5yoVAN78eMyngRCDAQ9bmbOSFzD+v8i/qTS9TwjqiFNEcgyAZFkI31Q/BjmaP27jKhg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790803593;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0y1reuxmu0xha+5l109WIPSaNzS8uovl0bKsvzue7C0=;
	b=ImjOmW4T6LSBByOsHJNoBtQggWeQQtZNnb8GJnvjDE/Lp0Nv3DhlwCY3ef4y+AJpM7Vb
	 2IfCDL755DjrdjBDqyjMxUGB/099VvJDkCfJU+h83UcPXeVeoEQvFL6VtHwObUXuxNPnP
	 ibCZzfSdCFkTDEiyiRcrCEglBMlTIIps4Wk7rEYppRkdN75N8COmCf+fVvSVMeQIvatTN
	 BUbpWJ/NK8+01GgdhhDzo+D6n+HBZAWRvTPhStHoRaQZsHjL7kjVGgn4Wzbd5D7ErVLOc
	 VCkXdwaJbw6DmgSXbFJS699LQBz4WOjDVLiZxH7ri/Arj9yIzJEXwLIMbmSe3o3imwQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TA3snQKS;
	arc=none smtp.remote-ip=74.125.225.140
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 551D2F80495
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2026 23:26:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 551D2F80495
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TA3snQKS
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a01ff8c098so325585e9.3
        for <alsa-devel@alsa-project.org>;
 Wed, 30 Sep 2026 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803591; x=1791408391;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PcNAjgtFv1vr3H1HrcX5VEOsxdqlzVkln685sfXLRLg=;
        b=TA3snQKSNnLgHPMwqRz+MLKlqawI+MphqbD8GWXUhNPxX6hpop4n8WPsmPaWd8x76K
         LTaGMas7CLB+iah/AOZzJKo5xWdnzFe71Ol/No0MQurYwkWg7NKkBrQlV4b8an0rhifv
         kMKBbvsHlnJzu547skOWO53uzuP/bvxsmox/DDetG9Q3Y8muFgGNYFHumhNE5+5whLxx
         1aKWkrG5rdulgQOlspnXToO/R+Oj+VjyogVFPp7BjCwG9OzBatFff6uvq7dMGBQRcgnl
         pWbUTqD73HJ+Bf9j1HzqvHAnj9smoA6f7dmdswU9d6LgSMRyMjsTvydGdgFEbbnvRa+S
         V4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803591; x=1791408391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PcNAjgtFv1vr3H1HrcX5VEOsxdqlzVkln685sfXLRLg=;
        b=fMBd8/kjhh0aG4HRNsbqHSnUaMiR6i2HRdUjBAIMbBUhe1SC2174kM6y/GOGm/gmCY
         TyIxH2OehpXjj7QgUuw0wSEvwaadfOKQDmY5cY48IGqvHyhImM4LObRyXypqXarar76W
         zrwm8+MZgvEMSNfIQD01sE4Sc4f/Kc7a/Jh4qdBuUMUYUM4zWUK2Ap1+3Ip562LFMZKW
         XsFL6UHqERgDylUUR2cRW6Y8uLuVbyX5Vi1yKBXbABvrUtViVr0UAhqKfaQ3GC9mrwcs
         Lx2JKmL3qZgUG6m6ysptHNOJtCskxFSVcvxqm6g6MklbAwLPDcdvPmPWWj74oCCQ3ygE
         XEPQ==
X-Gm-Message-State: AFuF++nuDPMOT7ETbLG6IjR7jl+QrJYxCB5xhAw1i4If2BSoYDd068KB
	6DHaCLP3IWg7CFzBlkQBFQW7bZboTcOg7Le062pPUsWrtLu61FQqYrJi1/+sFUdfRerPVA==
X-Gm-Gg: AYBFou1QKusArLVC0IQQGKb1XrVp1i2pd3Z8nEaJpDtcc34hkcKsHsJw1BPvBnXTIho
	RoWMkf8ljL31L4AX40rvQEKWWwaEWXEkl3JOCE9mYuCpWf8Upf/VV+FO9gRKaFeLABWEYRBW2YK
	daTJE6tzxY6jciQEjt2/t7fdHB9T4vsTFZkJ8sm+y7j3lJo+EcoiPtm1mwIE1S+LoZMPFxeAxzq
	CkMmwpDoLtUQbQTiAXjTR0T5yYyE4cn7Y4zJBuuwG8w1rY5gB5G5SB693RM3aaJ95hH8J9Sdt/s
	UXyDgK7BeWbpxud6e3RqaylVWwXrCXySFyCE7gWXZaPFkFf6zLyMGNt8nRYhMrk5N8U5ruX4rGM
	IJyOAtmFzmjkTRr6Y+55UazYyqeMB4R+z7poZM+nV+b6opQkqU+3ize5tPxFp0ysd/4dxtEUsIJ
	oYlAaARkAU/MEZRZHAIPIOLm3IM7nVJYXMcDCsMxJUc4JINqyPLu+8nI9FbQloYuXBMJXqjNhG0
	8zU41SOpsKIdD8EafZTta2i6Abw/DdBD5FGmAUcoTzEmxCnSGbH3dAlH6+Q6OgYzBby7ng=
X-Received: by 2002:a05:600d:8645:10b0:49e:7d74:7b7a with SMTP id
 5b1f17b1804b1-4a01afe1e11mr33766515e9.6.1790803591267;
        Wed, 30 Sep 2026 14:26:31 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b06a2d732sm1698561f8f.33.2026.09.30.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:26:30 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz,
	tiwai@suse.de,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] control: remap - fix numid table corruption on element
 removal
Date: Thu,  1 Oct 2026 02:26:24 +0500
Message-ID: <20260930212624.30308-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AAQGD4IW4LXAEDJKLHOT4ICTRJUNXK77
X-Message-ID-Hash: AAQGD4IW4LXAEDJKLHOT4ICTRJUNXK77
X-MailFrom: mikhail.v.gavrilov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AAQGD4IW4LXAEDJKLHOT4ICTRJUNXK77/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Removing a control element from a card that is opened through the
remap plugin corrupts the heap of every process holding the remapped
handle. UCM profiles that use MixerRemap or CtlRemap put this plugin
between PipeWire's ACP and the card, so on such a card WirePlumber
crashes some time after a driver takes controls away -- inside an
unrelated free(), far from the cause. Found with a USB interface whose
vendor controls come from a separate HID driver: unloading it removes
nine elements from the live card, and WirePlumber later died with
SIGSEGV or SIGABRT in free().

remap_forget_numid_child() drops the element's entry by moving the rest
of the numid table down one slot, then increments numid_items instead
of decrementing it. Every removal therefore grows the table past its
allocation: the loop goes on comparing beyond the end, and the next
removal's memcpy() writes there. Valgrind reports the invalid read at
the comparison and invalid writes in memcpy(), 0 and 8 bytes after the
block allocated in remap_numid_new().
With the fix, the same sequence -- the driver unloaded ten times, nine
elements removed each time, under a UCM profile that uses remap -- runs
clean under valgrind.

Decrement the count, use memmove() since source and destination
overlap, and stop at the first match: an entry for a real child numid
is unique, as remap_find_numid_child() adds one only when none is
found.

Fixes: d5f19bca ("control: remap - add sync feature")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 src/control/control_remap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/control/control_remap.c b/src/control/control_remap.c
index 80a0f43b..b18ac4cc 100644
--- a/src/control/control_remap.c
+++ b/src/control/control_remap.c
@@ -219,9 +219,10 @@ static void remap_forget_numid_child(snd_ctl_remap_t *priv, unsigned int numid_c
 	for (index = 0; index < priv->numid_items; index++) {
 		if (numid[index].numid_child != numid_child)
 			continue;
-		memcpy(&priv->numid[index], &priv->numid[index + 1],
+		memmove(&priv->numid[index], &priv->numid[index + 1],
 				(priv->numid_items - 1 - index) * sizeof(*numid));
-		priv->numid_items++;
+		priv->numid_items--;
+		return;
 	}
 }
 
-- 
2.43.0

