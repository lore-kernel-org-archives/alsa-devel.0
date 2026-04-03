Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A07E85368
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 20:08:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE804601F8;
	Fri,  3 Apr 2026 22:08:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE804601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775246912;
	bh=ehgci3nVxAkBJd45BL0t2Os4O056afqgyzLA1A/sNx8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=uyl69E20eUsjfLej7B+YvsmVYQlCZ0zSYN17OvjARPGq07ml6Y+RcUaNotG9tZJrs
	 xPU/wxMPCN0ybKswnDQCgCj6phBz47fo6w6/3uFcfmq6LQq6S0gLBODzh+jVCkDU0t
	 5mGUWceNXQhZlbCNsQrkfIlavTfYq257Y2dd4XrQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B3A1F805EA; Fri,  3 Apr 2026 22:07:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E255F805E3;
	Fri,  3 Apr 2026 22:07:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D202DF8055B; Fri,  3 Apr 2026 22:07:47 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B47AF8003C
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 22:07:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B47AF8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a2f19e23921b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/737@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/737@alsa-project.org>
Subject: ucm2 USB-Audio: add RME Fireface 802 (CC+USB mode) and UFX III,
 fix typos in existing UCX/UCX-II
Date: Fri,  3 Apr 2026 22:07:47 +0200 (CEST)
Message-ID-Hash: WHID2XMZ3P7HFB5G6SDXCIUI3CE3QVAU
X-Message-ID-Hash: WHID2XMZ3P7HFB5G6SDXCIUI3CE3QVAU
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WHID2XMZ3P7HFB5G6SDXCIUI3CE3QVAU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #737 was opened from huddx01:

Adds UCM profiles for RME Fireface 802 and UFX III devices and fixes a pre-existing bug in the existing UCX/UCX-II profiles.

New devices:
- Fireface 802 CC mode (0424:3fdd, 22ch) - tested on Debian Trixie
- Fireface 802 USB/driver mode (2a39:3fcd, 30ch) - tested, but my driver/module not yet stable enough for upstream submission
- Fireface UFX III CC mode (2a39:3fde, 94ch) - tested on Debian Trixie

Additional Bug fixes - I noticed while looking at the RME dir:
- Fireface-UCX-HiFi.conf: 9 occurrences of PlackbackPriority -> PlaybackPriority
- Fireface-UCX-II-HiFi.conf: 10 occurrences of PlackbackPriority -> PlaybackPriority,
  typo "AES3 XLR Ouptut" -> "AES3 XLR Output" (transposed letters)

Channel layout sources:
- CC mode channel count verified via /proc/asound/card*/stream0
- USB mode channel layout derived from Wireshark USB captures, see:
  https://github.com/huddx01/oscmix/wiki/Fireface-802
  https://github.com/huddx01/oscmix/wiki/Fireface-UFX-III

alsa-info output for Fireface 802 CC mode attached below.

[alsa-info.txt](https://github.com/user-attachments/files/26470990/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/737
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/737.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
