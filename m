Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FA3C27C53
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:56:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CFE883B;
	Tue,  4 Jun 2024 09:56:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CFE883B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717487785;
	bh=/fiIiiYbJFRNvZ7FP9BHekn9qQAHxsiruF9zvi9/kK4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=orQEbgGfwd3OfB0xVXyRuZ8Hod3SCuKWIiNFzC6TILsYbN8tS3JAtDG2R86zg59WK
	 6wQcMD9bvkmDA9XFw4JuBwI4HBe0fDFJpKlRpt2AbfdcuexPQ4Q+79rYUp0GrwUmRk
	 ZMWZvQFOJe5Ig/oQBYDvEQ+/xy4IBDOKSEoO2ORY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6929F805CB; Tue,  4 Jun 2024 09:55:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E10A5F805D5;
	Tue,  4 Jun 2024 09:55:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DC93F802DB; Tue,  4 Jun 2024 09:54:48 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4BD30F8003A
	for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2024 09:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BD30F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=o4zwSauH
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C9E03CE1053;
	Tue,  4 Jun 2024 07:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1D8C4AF09;
	Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487555;
	bh=/fiIiiYbJFRNvZ7FP9BHekn9qQAHxsiruF9zvi9/kK4=;
	h=From:To:Cc:Subject:Date:From;
	b=o4zwSauH9GbTo/xlsMQYytCJC5Rl+06wVlBsyC6ATPqM9sWzsAvra6bqIlJu46xBK
	 +j2Eq/qhdq6EPCG8KKWClJJQ40P6cTtM/8HO4ZMvBNgP+T/fKlX/tmI8lgu0TLIoE2
	 PZp2n6Jtd1ZxIsz/wGJPrO5vtbAVx9oBuKLShSxzuvl2Ncn928Ylkg6UacMpS6Uisl
	 fwK+MVggsjjD+zyyjPXnUZD5Qw9sNLbxa4mh5R0n3B0x1bIRvZHL6cq8Bc6zbwmZGJ
	 Ig2ZGs7QLPskYIKugr9jkU+AVOYwDyYlbddjt6dL/XW41A7d1ZfxyjmI+x9i0/lfJY
	 XHdtLqJB3Bwtg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sEOy8-000000005QL-3SGj;
	Tue, 04 Jun 2024 09:52:33 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] soundwire: bus: suppress probe deferral errors
Date: Tue,  4 Jun 2024 09:52:09 +0200
Message-ID: <20240604075213.20815-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 46DUZXOWLL3LBIMZLERA2CYN66UVJYTZ
X-Message-ID-Hash: 46DUZXOWLL3LBIMZLERA2CYN66UVJYTZ
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/46DUZXOWLL3LBIMZLERA2CYN66UVJYTZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The soundwire bus code is incorrectly logging probe deferrals as errors.

This series addresses that, cleans up the soundwire bus logging and
drops the unused soudwire driver name field.

Johan


Changes in v2
 - drop probe error message completely
 - drop soundwire driver name field
 - cleanup probe warning messages
 - drop probe debug message


Johan Hovold (4):
  soundwire: bus: suppress probe deferral errors
  soundwire: bus: drop unused driver name field
  soundwire: bus: clean up probe warnings
  soundwire: bus: drop redundant probe debug message

 drivers/soundwire/bus_type.c  | 21 ++++-----------------
 include/linux/soundwire/sdw.h |  2 --
 2 files changed, 4 insertions(+), 19 deletions(-)

-- 
2.44.1

