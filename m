Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF76DC54798
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Mar 2024 10:13:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF21784A;
	Sat,  9 Mar 2024 11:13:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF21784A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709979221;
	bh=ZLWxTNvadb4hyjem5uvWUCn8AIITYg1bzbW2sx4kDIU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nFH61O5yImkOAA25jNQFWbtLuaukLJC/R0cVR4VVE6I9aW0TJd+eaAKR+/OaQ3fhe
	 5cnWGg8cwavV9MejWyNnWvgrvR0faCTjuE6p60HVsmrsShOEdJM2B0KQ6My66/TzM9
	 ImDkWtSzDLsVHZXC7+ELmsqfz2X8FUx2RJDPoCbo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85AD0F805C5; Sat,  9 Mar 2024 11:12:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3FA3F805C4;
	Sat,  9 Mar 2024 11:12:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60C54F8024E; Mon,  4 Mar 2024 10:57:14 +0100 (CET)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 93F08F8014B
	for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2024 10:57:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93F08F8014B
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Vinod Koul <vkoul@kernel.org>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15/6.1 0/1] soundwire: stream: use consistent pattern
 for freeing buffers
Date: Mon, 4 Mar 2024 12:55:41 +0300
Message-ID: <20240304095542.4799-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.20.125]
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)
X-MailFrom: D.Dulov@aladdin.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: NRUJKND5M2QI6YR2IUZS4UQXHI2WKODZ
X-Message-ID-Hash: NRUJKND5M2QI6YR2IUZS4UQXHI2WKODZ
X-Mailman-Approved-At: Sat, 09 Mar 2024 10:09:25 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NRUJKND5M2QI6YR2IUZS4UQXHI2WKODZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Svacer reports NULL-pointer dereference and double free issues in
do_bank_switch() in case sdw_ml_sync_bank_switch() returns an error
not on the first iteration of the list_for_each_entry() loop. These 
problems are present in 5.10, 5.15 and 6.1 stable releases. These problems
have been fixed by the following upstream patch that can be cleanly
applied to 5.10, 5.15 and 6.1 branches.
