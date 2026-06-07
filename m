Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB16CD8C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:47:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87586601BE;
	Sun,  7 Jun 2026 19:46:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87586601BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780854423;
	bh=j4h4tXYG+ti60tT+xtBRPeiqIWq/51ySO9A1rO+6VfY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=KgAghxwmqLasQsSDyGBnVnuc9bgP7kjG1KzQtAC857b4ukZ4rcEJertsAfpLblGBa
	 XHnuD8rPU8wEQpkYjh5qQT81HFbVcUWONGFB7v4wwZfxE5e09h+x+WxmaEQt67WPd7
	 +HVolD2HR7aad/FWG3LcSLE5+RMOqYTATlZPM/WQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB7E2F805FB; Sun,  7 Jun 2026 19:46:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AACEF805EE;
	Sun,  7 Jun 2026 19:46:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5566FF8055B; Sun,  7 Jun 2026 04:56:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780800981;
	b=OHhHpkxNE07qUyfx7k96ARA1MyFuN1gKAAKjj8obdG7t1Humg+19eW2vAN+jbcHGsbKF
	 qSTsUPpE3XMZZHUlP10m1C3YZwla/4P5mDmW58d6eepDiKSmUi9VhSgCGduCdv+8Yp0qY
	 Du1/mStdt0MYVNjjbshjcA/Qdile9LDAFG77G9j0gCo256Czy0uGFEFA+/Rnaj2oEMm0f
	 y+hpdIxcbaly/IEDTqiyGVw+T5Tfq4nvQKfi8cdZqKJdT8rpn/b1bHHC20Ax1k/LFlr/M
	 GdfQuUhADM6FO7+I6saJCtpdERuNTd9dSKZ6zn6dYNlnbhQfyZKSXYFmBsPbOT0AEdw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780800981;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j4h4tXYG+ti60tT+xtBRPeiqIWq/51ySO9A1rO+6VfY=;
	b=I5wdN1TfEuHdiR9im63BxD4CIvCgnqMnVjys1lTRAZr9xk8hT8iOfysucSRw+YLR6Qwk
	 yEdB3fN9CqfTZ3/pZIFGQhiPBtzqQMNpLByeCCwNQlQi6pXlAMAT2GthQT+NpAnZxqPe+
	 NAiJj/G2ke8d0mx+DJW0MkwS/las4cmnr8UYZGjoBDDH5SMMU15s8zFGEalFI5OcZL/0S
	 5LdS19t5YRItV/KpKK2C+wJYt8U/j68n0CMmvzO+E8ODmJyvdVkjscfDt3Vz+L5q0Ap8m
	 6iN00gbEmPDbPuNGP6aAXjtfXeeI9qN6v0kg4K0kfHT3+RBFcr3SZxmSjUNBKb/W2MQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L1z7fBsx;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A3B07F8051D
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 04:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3B07F8051D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L1z7fBsx
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8422f395a4aso1913541b3a.0
        for <alsa-devel@alsa-project.org>;
 Sat, 06 Jun 2026 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780800978; x=1781405778;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKG8K6ZfgHZwdRHzwdJFm5PX+/nn9D4GakA15V/0O0o=;
        b=L1z7fBsxbguxUaC2fNGbiTakhmN2CXl2Wv0iII+rO1a2QDTm7wxOEWWoWkkcrHPbLn
         rMpL4zy+2qIWBEazBN9G4xUDgylX+GsxxZd/TIzX6FtxCKBAIJzVCixmgkzAMJ0eMD4m
         SWEsPN8sRiLSd1+uGr9EnkSarhuYtzoLII/HAtRjy80K1taLrE9gumJHB0FvV/wAg5bs
         PbvBYstJmTycN6dcYYuBXpzqtb9NtZx78s1GhtjQBxoKSGU/E90JV/GGn9K3hlh5wIyS
         57m2Kg+h/zAwnvNJXqDQ3X4/DSQrlSf6LjNuvXFqB0e+d7mOkkmiHzND5QNm4JWuhLb9
         Drrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780800978; x=1781405778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKG8K6ZfgHZwdRHzwdJFm5PX+/nn9D4GakA15V/0O0o=;
        b=os1t0nJff4fzGGPhLNqZwInKBQT4QdfxTxBdlvcYNAiwujReqtrO7Wr5mpeX6zLzWX
         mJrAmaC+7uwUyVBx6ncIFwP023IT4LLeM6yDFhjSAaiEnbOm4j31KXrGo1mgF9xI8uXB
         pc0qcaPlSOCSHFG7Pa63OKcTmLVDVxn5nQqPH3K1K6HpLYj+/lxRz3yZaqKG4UZoekh1
         OYZZy6S8FdzoD6VzpxpvSNX3UMy1rTjySN5XyhT1QJS2wkBn5FwNxkIY4bOip67TaYE0
         XxSPXlh092fouMashz+hhCcN9krfY6yXFS69Vn+n+XVfn67tp7fixsXtQf64W2pnqOcE
         GYSg==
X-Gm-Message-State: AOJu0Yy7VKnXJhXp5gfbs+dyISdpXNr+nkD730MUrlGPh0Mt1CCi7hJF
	jSfbvJLln/XgAQSJ/oaX/NfGnsKPKk/ZkjIadgZ2zU2myC8v5kNTJ+hd
X-Gm-Gg: Acq92OGTY6X8VKvJdyWXz9e+wbLh0mDkadRDh5Gv3sNRuBhbOvFix7XkjT2YXYffR0N
	Obb0nVKvEzmgmD+DLyOi3UQtCOzxRqqMrTQZYQWyFb4dMAjs5eG8Xj8ILj/L/+EgXvBOkeonW2L
	QDMI65/ybhj+lNOZleca/6zRUmsbBUc9UZkvhTTr7yTCmYErHRwIp7rnjBCrovL9ecJwwTYuhbq
	XkXEq/QXDFKZR7TFeOZ3AIn1tJFJIgu3MGIwJTmcrnNGkmkFAhUx5TRObgOko4ZCEuuHPQr+cki
	Pdp7x8O+Gy6Jt8VUgesGmfN9VizZVeydGr1ha5lZTScO3evneBWQoLsFJI1lRukucXUnXCuQngS
	Ir2IcWPabcaICzsXzaODtO7KpUbNRvysVoT+4hYPYajsLsj7+zu4lvp+ND/BjKWHixWRwgqJGev
	PoTXfYNU+sx33vNfKuIP0+1f18a80V8uQO99Pu1wR6cn38abAffMaKmw==
X-Received: by 2002:a05:6a00:a201:b0:842:6293:fc43 with SMTP id
 d2e1a72fcca58-842b66aa645mr6923455b3a.15.1780800978217;
        Sat, 06 Jun 2026 19:56:18 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282918b8csm13034210b3a.57.2026.06.06.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:56:17 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH 0/8] ALSA: check snd_ctl_new1() return before dereferencing
Date: Sun,  7 Jun 2026 10:56:05 +0800
Message-ID: <20260607025613.3604194-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ruoyuw560@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GGHIS2JE4J4SHMZ5CRT4TPNRQYOAFFSW
X-Message-ID-Hash: GGHIS2JE4J4SHMZ5CRT4TPNRQYOAFFSW
X-Mailman-Approved-At: Sun, 07 Jun 2026 17:46:22 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GGHIS2JE4J4SHMZ5CRT4TPNRQYOAFFSW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Several ALSA drivers dereference the pointer returned by snd_ctl_new1()
to adjust id.device, id.index, or store bookkeeping pointers before
calling snd_ctl_add().  snd_ctl_new1() can return NULL on allocation
failure, making these writes a NULL pointer dereference.

This series adds NULL checks to all affected call sites found by static
analysis.

Ruoyu Wang (8):
  ALSA: es18xx: check control allocation before private data setup
  ALSA: gus: check PCM volume control allocation
  ALSA: cmipci: check S/PDIF control allocations
  ALSA: es1938: check control allocation before private data setup
  ALSA: ice1712: aureon: check CS8415 control allocation
  ALSA: ice1712: check pro S/PDIF control allocations
  ALSA: ice1724: check S/PDIF control allocations
  ALSA: ymfpci: check S/PDIF control allocations

 sound/isa/es18xx.c              | 4 ++++
 sound/isa/gus/gus_pcm.c        | 2 ++
 sound/pci/cmipci.c             | 6 ++++++
 sound/pci/es1938.c             | 2 ++
 sound/pci/ice1712/aureon.c     | 2 ++
 sound/pci/ice1712/ice1712.c    | 8 ++++++++
 sound/pci/ice1712/ice1724.c    | 6 ++++++
 sound/pci/ymfpci/ymfpci_main.c | 6 ++++++
 8 files changed, 36 insertions(+)

--
2.34.1

