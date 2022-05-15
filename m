Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0EAC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 15 May 2022 13:07:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C89116E1;
	Sun, 15 May 2022 15:06:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C89116E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652620044;
	bh=rcWyG8sDcN+A/O/JcaDQqUzixyKYoAbCJdt2M1/U4BI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i53yb3j32v1I8hCEjbxd1EezDvUubAfKYqTy1oYgcf0sN+y3hp2CKacJGadWt3Bla
	 /wwXtlPO4tIuNu5FHDwSC5+ekU3Y2sFvNiX7asPgqNIwEu5qmS/AVOLvzuyusigX1t
	 VcPaN+Jh5LwkBLGqd6gnAMSEJ+cen99BlAw+ixkM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3226F80169;
	Sun, 15 May 2022 15:06:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32F7CF8012C; Sun, 15 May 2022 15:06:32 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1E1B5F8012C
 for <alsa-devel@alsa-project.org>; Sun, 15 May 2022 15:06:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E1B5F8012C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1652619988689560890-webhooks-bot@alsa-project.org>
References: <1652619988689560890-webhooks-bot@alsa-project.org>
Subject: Weaknesses in alsa_info on new Ubuntu systems
Message-Id: <20220515130632.32F7CF8012C@alsa1.perex.cz>
Date: Sun, 15 May 2022 15:06:32 +0200 (CEST)
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

alsa-project/alsa-utils issue #146 was opened from mhampl:

There are some weaknesses on current Ubuntu systems (e.g. release 22.04) where the alsa_info scripts does not deliver the desired information:

The command "tree" is no more provided by default (but can be installed in addition)
This results in the error message
"./alsa-info.sh: line 661: tree: command not found"
and causes missing output in "Sysfs card info"

The command "dmesg" requires administrative authorizations (e.g. "sudo dmesg | grep ...")
This results in the error message
"dmesg: read kernel buffer failed: Operation not permitted"
and causes missing output in "ALSA/HDA dmesg"

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/146
Repository URL: https://github.com/alsa-project/alsa-utils
