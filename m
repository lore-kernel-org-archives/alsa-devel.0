Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3F4C433EF
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jun 2022 05:38:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D55E1743;
	Sat,  4 Jun 2022 07:37:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D55E1743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654321087;
	bh=XWBgYq8cTfSQUy1RNoUd/BMH2uotnJ+Jta7Ovpr0g30=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CPcccrSU9zzGvLyLzWKY/ddh7oII2l907MFOgwniNpaOHCuF/Dh8MaHua7+9o/B5E
	 mb9y7hLDWeB6C1tzSu/gDzUQ5vzIOoXTusL+C/+mTxp/NxLzVMkcPPbXumlk/kDc18
	 8RDXZE8nuMPmygMR+8XxtQq2pMc/eLj0FBAllRIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15BAAF80169;
	Sat,  4 Jun 2022 07:37:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F295EF8016D; Sat,  4 Jun 2022 07:37:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 769A4F800E8
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2022 07:37:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 769A4F800E8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1654321030337070942-webhooks-bot@alsa-project.org>
References: <1654321030337070942-webhooks-bot@alsa-project.org>
Subject: Fixes for veyron chromebooks
Message-Id: <20220604053714.F295EF8016D@alsa1.perex.cz>
Date: Sat,  4 Jun 2022 07:37:14 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #164 was opened from jenneron:

Add PlaybackVolume and JackControl. I didn't add JackControl for headset mic because internal mic breaks after switching to headset and back

Add symlink to VEYRON-I2S, so ucm config will get probed

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/164
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/164.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
