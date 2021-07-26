Return-Path: <SRS0=yf6i=MS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3AC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 09:36:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA35760F02
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 09:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA35760F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elbitsystems.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95A5A171A;
	Mon, 26 Jul 2021 11:35:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95A5A171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627292183;
	bh=RRrDsjLuFKhjCXVUOuWdSphoLWo1d3sXFAT7Pypdo54=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ToZtSmq03M4vRRfPNWg1hkalhn/rDXw5hnUf1bQN0ViQHs/EzDCrLXVdFuUQqOC7A
	 tfgepm4uQFmQ5RYwqza/elMZL0ISTY8JTbWti7OrcxfHB7uJglJnBuTvJCFlVYgLsy
	 XFnbCZdAXMg8uV+fdJHIo3dPRXrGnE/fBqvfl/To=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C4340F80253;
	Mon, 26 Jul 2021 11:35:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3140AF8025A; Mon, 26 Jul 2021 11:35:31 +0200 (CEST)
Received: from mail1.elbitsystems.com (mail1.elbitsystems.com [185.145.28.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BDEBF8020D
 for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2021 11:35:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BDEBF8020D
X-IPAS-Result: =?us-ascii?q?A2DrAwCmgf5g/5cKEaxagQkJgVCBI1mBJoFNlh+VNIYuF?=
 =?us-ascii?q?IFoCwEBAQ4BQQQBAYRYgn8mNQgOAgQBAQEBAwIDAQEBAQUBAQYBAQEBAQEFB?=
 =?us-ascii?q?IEOhS86DIZ2RRkBFWsmAQQbgmqBfqoKgTQaAmWEaIVIgTqBZYQIU0iFanuCU?=
 =?us-ascii?q?CaIWAkBEgEoByqFQwSDRAcfDAQNDidwIwgVBzYtERQWkU2MGo06khYHgymDb?=
 =?us-ascii?q?IU2lQwrEoE5giqLXoYlA5B6lgqgB4UHAgQCBAUCFoFhAYEicDMaI4M6TxcCj?=
 =?us-ascii?q?1IBAo0ngSsCBgsBAQMJih0zXgEB?=
Received: from unknown (HELO Router1) ([17.10.151]) by mail1.elbitsystems.com
 with ESMTP; 26 Jul 2021 12:35:04 +0300
Received: from DM1 (Not Verified[17.12.51]) by Router1 with Something New
 (v8,2,6,11305)	id <B60fe81c80001>; Mon, 26 Jul 2021 12:35:04 +0300
Received: from AHHFA02.localdomain (unknown [17.12.8])	(using TLSv1.2 with
 cipher
 DHE-RSA-AES256-SHA256 (256/256 bits))	(No client certificate requested)	by
 Forcepoint Email with ESMTPS id 2F42ABDC0674B735A185	for
 <alsa-devel@alsa-project.org>; Mon, 26 Jul 2021 12:35:04 +0300 (IDT)
Received: from Out1 ([0.50.252])	by AHHFA02.localdomain with ESMTP id
 16Q9Z485004165-16Q9Z486004165	for <alsa-devel@alsa-project.org>;
 Mon, 26 Jul 2021 12:35:04 +0300
Received: from HMX23 (Not Verified[0.54.63]) by Out1 with Something New
 (v8,2,6,11305)	id <B60fe81c80000>; Mon, 26 Jul 2021 12:35:04 +0300
Received: from HMX13 (0.54.33) by HMX23 (0.54.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 12:35:03 +0300
Received: from HMX13 ([fe80::b177:53d2:424a:6c01]) by HMX13
 ([fe80::b177:53d2:424a:6c01%6]) with mapi id 15.01.2176.012;
 Mon, 26 Jul 2021 12:35:03 +0300
From: Kabaz Shlomo <shlomo.kabaz@elbitsystems.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Writing  a driver for   multiple Codecs with  one mcAsp 
Thread-Topic: Writing  a driver for   multiple Codecs with  one mcAsp 
Thread-Index: AdeCAQm06nqs+ybVRlmihh3RDpt8vA==
Date: Mon, 26 Jul 2021 09:35:03 +0000
Message-ID: <dca6978e3cfa47b9b2b719df4cc9c93a@elbitsystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.54.230]
MIME-Version: 1.0
X-SEG-SpamProfiler-Score: -1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

Hello ,

I am trying to  add to the DM8148  board  functionality  that support  mu=
ltiple Codecs  for One  McAsp  .
The development env is DVRRDK4  of TI .

Does any one know how  can I do it ?
OR what are the concept of adding such support ?

Regards ,
=20 Shlomo Kabaz .


The information in this e-mail transmission contains proprietary and busi=
ness=20
sensitive information.  Unauthorized interception of this e-mail may cons=
titute=20
a violation of law. If you are not the intended recipient, you are hereby=
=20
notified that any review, dissemination, distribution or duplication of t=
his=20
communication is strictly prohibited. You are also asked to contact the s=
ender=20
by reply email and immediately destroy all copies of the original message=
.
