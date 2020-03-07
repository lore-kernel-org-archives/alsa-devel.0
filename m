Return-Path: <SRS0=bYd2=4Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35502C10F25
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 23:18:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6482073D
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 23:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pi8M2vyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6482073D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2902D9F6;
	Sun,  8 Mar 2020 00:17:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2902D9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583623100;
	bh=YGDHXYagiFWZlrWFdwsAuY4JWWfI6mAT7mrgIjHyIIA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pi8M2vyoGMJbkdPjsPist3pnMe+fT9FSweP9hV83NFV396vNXypXeXUMzS4Rc/NAX
	 gyY9qysXS3y5MyGubEB4N5nrINDSdm3KymevNsSIrjIPXBvEBqIHnW+ku1kP+zuC3X
	 LCz3s7+p3CMZqm1xr46XQWCXeOppbk64M9dp0nx8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CC6EF80245;
	Sun,  8 Mar 2020 00:17:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 117CFF8025F; Sun,  8 Mar 2020 00:17:11 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 07B57F8012D
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2020 00:17:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07B57F8012D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1583623027269628048-webhooks-bot@alsa-project.org>
References: <1583623027269628048-webhooks-bot@alsa-project.org>
Subject: alsaucm could not open configuration
Message-Id: <20200307231711.117CFF8025F@alsa1.perex.cz>
Date: Sun,  8 Mar 2020 00:17:11 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #16 was opened from nicolasfella:

When I run `alsaucm listcards` on my system I get:
```
ALSA lib utils.c:261:(uc_mgr_config_load) could not open configuration file /usr/share/alsa/ucm2/HDA-Intel/HDA-Intel.conf  
alsaucm: error failed to get card list: No such file or directory
```
happ
My audio card is a `HDA Intel PCH`

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/16
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
