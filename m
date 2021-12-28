Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC3CC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Dec 2021 20:00:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CED7B167C;
	Tue, 28 Dec 2021 20:59:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CED7B167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640721628;
	bh=JHv90Kvh5EWY3BLQq6SEZrlUub12DqquWY7q8EFLd7I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6fKhp4uX6e6DmgX6lFb6iIJRr52HO8ZOCHIj3pLH0wwDNjSKf8R1Z1gx25u6pFcL
	 N/loM2e9oV0a02GQoPkhAuwmXdAZGyqWoqxWTG2xxhAGMhRX5ZKeYP83jVrMmm2CD3
	 b97AbEPf6R0d+ZMGhEnqcOK8AaL1FrmNyXcKFe1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5410BF801EC;
	Tue, 28 Dec 2021 20:59:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7543FF80224; Tue, 28 Dec 2021 20:59:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 22821F800D3
 for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2021 20:59:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22821F800D3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1640721571321252108-webhooks-bot@alsa-project.org>
References: <1640721571321252108-webhooks-bot@alsa-project.org>
Subject: [patch] /usr/share/alsa/speaker-test/sample_map.csv is not accurate, 
 not affecting operation of speaker-test
Message-Id: <20211228195936.7543FF80224@alsa1.perex.cz>
Date: Tue, 28 Dec 2021 20:59:36 +0100 (CET)
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

alsa-project/alsa-utils issue #133 was opened from ZjYwMj:

With alsa-utils 1.2.6:
```
--- a/usr/share/alsa/speaker-test/sample_map.csv	2021-12-06 18:44:25.000000000 +0000
+++ b/usr/share/alsa/speaker-test/sample_map.csv	2021-12-28 19:48:02.390305957 +0000
@@ -1,2 +1,2 @@
-0, "Front Left", "/usr/share/alsa/samples/Front_Left.wav"
-1, "Front Right", "/usr/share/alsa/samples/Front_Right.wav"
+0, "Front Left", "/usr/share/sounds/alsa/Front_Left.wav"
+1, "Front Right", "/usr/share/sounds/alsa/Front_Right.wav"
```
Although this file is not accurate, it does not affect the operation of speaker-test. Perhaps the paths to the files are hard coded within speaker-test. Still, I find it a minor bug.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/133
Repository URL: https://github.com/alsa-project/alsa-utils
