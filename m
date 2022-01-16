Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AD1C433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Jan 2022 22:33:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66F8F1771;
	Sun, 16 Jan 2022 23:32:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66F8F1771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642372392;
	bh=evV4p5VUjAUwohYv6i5iaGk/o9V2YL7ntB7i4kQnp5o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CRXhAuZ3IswT6Xa8HpjU760F5eUuo0aSka94mcs6Pu7PHSyvb+B7kmk6qCsXGDJli
	 Yo56ygTrP8GNH+NDmX1JQMg7q9ZWpaTKQpQxMkNftZKgreScdppOQ+6c4o2A+f+v/N
	 pdHGsBkdYQYZGpoiqh4/CaQAbxeaEbA88pj6og1o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03284F800BF;
	Sun, 16 Jan 2022 23:32:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEAC2F804CC; Sun, 16 Jan 2022 23:32:17 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 49F24F800BF
 for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2022 23:32:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49F24F800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1642372328656722069-webhooks-bot@alsa-project.org>
References: <1642372328656722069-webhooks-bot@alsa-project.org>
Subject: WIP: Add UCM for PinePhone
Message-Id: <20220116223217.AEAC2F804CC@alsa1.perex.cz>
Date: Sun, 16 Jan 2022 23:32:17 +0100 (CET)
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

This UCM config is copied from https://gitlab.com/pine64-org/pine64-alsa-ucm/, which is BSD-3-Clause licensed.

This UCM has been tested via Pulseaudio's ALSA_CONFIG_UCM2 environment variable, but I've not yet tested that this UCM, when included in this package, is correctly recognised on a PinePhone as part of this

Todo:

* [ ] Test that this UCM is correctly recognised on a PinePhone.

See also:
* https://gitlab.com/pine64-org/pine64-alsa-ucm/-/merge_requests/1
* https://gitlab.com/pine64-org/pine64-alsa-ucm/-/issues/3

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/134
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/134.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
