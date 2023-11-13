Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71A2C4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Nov 2023 11:57:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 250121F2;
	Mon, 13 Nov 2023 12:56:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 250121F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699876647;
	bh=BtJxjRD9fIrWLjBWH1NClqhUxSq9z09/erGQKsITDqk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dog/l+TjNN6BE4ksKhTPjXFBNW/jttrdisc8dUGtQpVRTz84ZfOQF6C7RIoSPPEts
	 MJstWDLJzzmSURIaf22/uZLmIH3eMHuy5+fV9LOM1zZbR7PPdTpj1iboKtCoUGSwFc
	 6EDkobq8AR41wEGArpb5xii6XVJ2mOscFjaO6Yi0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7EA96F805B6; Mon, 13 Nov 2023 12:54:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 021EFF805BB;
	Mon, 13 Nov 2023 12:54:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FD07F802E8; Mon, 13 Nov 2023 11:22:15 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25DD8F80093
	for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2023 11:22:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25DD8F80093
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id B8F39B80927;
	Mon, 13 Nov 2023 10:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40302C433C8;
	Mon, 13 Nov 2023 10:22:07 +0000 (UTC)
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: linux-media@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	alsa-devel@alsa-project.org
Subject: [RFC PATCH 0/8] v4l-utils: add v4l-audioX support
Date: Mon, 13 Nov 2023 11:18:41 +0100
Message-ID: <20231113102202.258725-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: SRS0=a+Jp=G2=xs4all.nl=hverkuil-cisco@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XN2CMY7CKBI6DF4AGTPSLFFJEAP2SV67
X-Message-ID-Hash: XN2CMY7CKBI6DF4AGTPSLFFJEAP2SV67
X-Mailman-Approved-At: Mon, 13 Nov 2023 11:54:41 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XN2CMY7CKBI6DF4AGTPSLFFJEAP2SV67/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series adds support for v4l-audioX M2M devices.

It is an initial version and it needs a bit more work. Mainly adding
support for the new V4L2_CTRL_TYPE_FIXED_POINT, but that requires
some more work in the driver patch series.

At least this series will get the basic support in place and adds
a vim2m-audio test to the test-media regression test script.

Regards,

	Hans


