Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86155606A31A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=LHaPvPEk
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2470601F7;
	Mon, 23 Nov 2026 07:04:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2470601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795413889;
	bh=+lubJB7tsDIpcD5NwlWuoAW/ZK8gw3gxhfqjr4Cfrao=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LHaPvPEkLbIC05O9Gh+yqqKLBXPOOIWHzn9sChVWqDlmvbektSnbPiUjWQQd4nQta
	 ZSnSbRQvEDcAROtvU3Ey3xuQRMYWmN4iaWOf8KSF+kMTCDu8yHah5OAOkKUCcoueLH
	 WANx7PN46psl0HI/hZAFCRG52Z8YFeB8UaPOcAGQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3698F805FE; Mon, 23 Nov 2026 07:04:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D3DBF805FE;
	Mon, 23 Nov 2026 07:04:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DD0EF80552; Mon, 23 Nov 2026 07:04:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795413847;
	b=YJzT0Y8xER7QH5pBGkJ2fs1fDATcVnwPe3AaQId+1gFHfEI+wR8wIjL+BAswCPTiRsK4
	 lp9uTkrO181QEiSAodbg0un1dokJt6VmroOTZkssBduMcCmqFRQMaXrUhiK8WEezVhHDq
	 tFtptDvs5AgzxzcjUP2a2+wpFI4c0iQm5hbGzYE18viUhB1j3MMc76g14ZXSSYrlHdhsB
	 M/mSFaGvyLPC6bSEOxW9rKpgEIAAwzBSgaBCut4xXvTr33Dbz/S2zs/Z8Q3dyt2LZUZMS
	 vHRDJOvImexw0T5ZC920U4Z3GDJxpEAXjMWb9wvvsbvQdP4o2RIgP4Yy/FcD0hYRyeA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795413847;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=+lubJB7tsDIpcD5NwlWuoAW/ZK8gw3gxhfqjr4Cfrao=;
	b=DQah7LdcE3K7qvkz5tbgBCvUUthyH6aU6G3BE2LqWvGuWV4LMWBNh1AqramPS9g3Vo8D
	 ScIo67+2wGDle20znK1T7jAeiRjx5Br639+f+l/sKRlABB2sZEo84/48XBU+Wiukq3Og3
	 M3PxTC+i0MajWVP+508fT1YHrYcEm/YQ0i54fpdBhz1s7XuKxLj7fSd2YJzYmf7DqKUt7
	 jvlfSVSlXzp8EEdLhpZQfU6hy79lCVel9WSUdUnRcXbT9YHyogmN62JNtVcfxWpDm96Ax
	 /tGNLXSTxb+isO26dJQchg+UOS9tfuiF7w+KbPro6NnK0UmGkCgzIiKRNl/xnRstvow==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 41686F800B5
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 07:04:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41686F800B5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ea97615204e800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/921@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/921@alsa-project.org>
Subject: USB-Audio: ALC4080: Add MSI MPG Z890I EDGE TI WIFI (0db0:da75)
Date: Mon, 23 Nov 2026 07:04:08 +0100 (CET)
Message-ID-Hash: OXT7QM4JWHBUVW37ULVEP7OS6H7A6SC2
X-Message-ID-Hash: OXT7QM4JWHBUVW37ULVEP7OS6H7A6SC2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OXT7QM4JWHBUVW37ULVEP7OS6H7A6SC2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #921 was opened from oukawa:

The onboard Realtek ALC4080 on the MSI MPG Z890I EDGE TI WIFI
(Intel Z890) uses USB ID 0db0:da75, which is missing from the
ALC4080 list, so UCM fails with "UCM is not supported for this
USB device".

Tested on Ubuntu live: with this ID added, the Realtek/ALC4080
profile loads and the outputs work.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/921
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/921.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
