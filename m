Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72515D0E6C7
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:14:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9225CED1;
	Mon, 21 Oct 2024 10:14:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9225CED1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1729498489;
	bh=ZND+pJ3gQC6iceQE4vHCGnD3ShRCYad+p8lWfl/dA/I=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=khlzKsXL/4wetYgCbk33hmbGMfWYqzJxa+u5HLeqNOsMWVt8lPYpnfewtgqRk7pys
	 slbFJQJ1M7IEzrBRuOmCWKQjYqJmnfQH8Ixdg0tS6LRCuGK8v4Tylr04Fch9XVZ4/x
	 S2zjplj+XATyCTbFNDkbOYitwK1kDMpnqZWK0hj4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23543F80631; Mon, 21 Oct 2024 10:13:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B884F80638;
	Mon, 21 Oct 2024 10:13:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80CA1F80448; Fri, 18 Oct 2024 11:07:34 +0200 (CEST)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 86D59F80149
	for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2024 11:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86D59F80149
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Vinod Koul <vkoul@kernel.org>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10 0/1] soundwire: cadence: Fix error check in
 cdns_xfer_msg()
Date: Fri, 18 Oct 2024 12:07:13 +0300
Message-ID: <20241018090714.399076-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.20.125]
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-02.aladdin.ru (192.168.1.102)
X-MailFrom: D.Dulov@aladdin.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 5H2Y5AX6B4IWSXT44HOF3C5WX5AHCIIF
X-Message-ID-Hash: 5H2Y5AX6B4IWSXT44HOF3C5WX5AHCIIF
X-Mailman-Approved-At: Mon, 21 Oct 2024 08:13:14 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5H2Y5AX6B4IWSXT44HOF3C5WX5AHCIIF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Svacer reports redundant comparison in cdns_xfer_msg(). The problem is
present in 5.10 stable release and can be fixed by the following
upstream patch that can be cleanly applied to 5.10 stable branch.
