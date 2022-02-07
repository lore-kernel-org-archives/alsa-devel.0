Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB91AC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Feb 2022 12:27:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4111916C2;
	Mon,  7 Feb 2022 13:26:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4111916C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644236848;
	bh=XNhcDDTemOBayVV82sFx9x1jQUmWWl5oXgIkNCJZPjg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7/Ka5J/Ze0gL8GHClReR9ZJG8BrymI3n1HguPoq7MoLb9MtYS64HJJ/ZVTdaTMli
	 OcFc/SCf0RhveXFSFbfj9wdK95AnD06bPs3XNdiSb7IX7vFewPaUSbjIZhcmyrMT6d
	 CougLZskdPonIvXdCFnZ7h5s5ujPf4pz6vg+GrvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E455DF8023B;
	Mon,  7 Feb 2022 13:26:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A5E5F800F5; Mon,  7 Feb 2022 13:26:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 08194F800F5
 for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2022 13:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08194F800F5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1644236790368707895-webhooks-bot@alsa-project.org>
References: <1644236790368707895-webhooks-bot@alsa-project.org>
Subject: Add UCM for PinePhone
Message-Id: <20220207122637.0A5E5F800F5@alsa1.perex.cz>
Date: Mon,  7 Feb 2022 13:26:37 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #134 was edited from tomfitzhenry:

Fixes https://github.com/alsa-project/alsa-ucm-conf/issues/124.

The DTS configuration has had a unique audio card name since 5.14:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi?h=v5.14#n436

This UCM config is copied from https://gitlab.com/pine64-org/pine64-alsa-ucm/, which was developed by many developers ( https://gitlab.com/pine64-org/pine64-alsa-ucm/-/merge_requests/1 ) and is BSD-3-Clause licensed.

I have tested that with this PR, the PinePhone has the expected HiFi and VoiceCall profiles.This testing found that the `File` directive in `SectionUseCase` needs to be absolute (for the symlink to work). I've fixed this in this PR: https://github.com/alsa-project/alsa-ucm-conf/pull/134/commits/5059e57a2197bb38848bbec10f589637df64679e.

See also:
* `alsa-info`: https://alsa-project.org/db/?f=5e331f5ef10bd167b3bd7640bfcf0e879100f80d
* `pa-info`: [pa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/8015083/pa-info.txt)
* https://gitlab.com/pine64-org/pine64-alsa-ucm/-/issues/3

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/134
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/134.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
