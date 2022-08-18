Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C512BC00140
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Aug 2022 12:57:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEE951616;
	Thu, 18 Aug 2022 14:56:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEE951616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660827419;
	bh=EgheZtYjuHdfV9Mpsjm+dBdGrnifs/sBwfyBJlLH+sk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tHzpQfA5ECJPyjEO6kXd6dgrTTCDbn0lIejXAAt7+9Yw6PTzwRM2XVnR94afvL1xR
	 IgoMuIcRB7iSqQa127L0K8UTAemoZljZPpAKNtMlPbSxo6xpK7uVYeNOQSbqD5frqN
	 zx6zTeRr/VtHW1B7QguiNXqKqy5qGxvFSm39pQQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87E61F8013D;
	Thu, 18 Aug 2022 14:56:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EE5CF80430; Thu, 18 Aug 2022 14:56:06 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C7675F800B5
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2022 14:56:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7675F800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1660827363369755030-webhooks-bot@alsa-project.org>
References: <1660827363369755030-webhooks-bot@alsa-project.org>
Subject: Add ASUS ROG Zenith II Extreme configuration
Message-Id: <20220818125606.8EE5CF80430@alsa1.perex.cz>
Date: Thu, 18 Aug 2022 14:56:06 +0200 (CEST)
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

alsa-project/alsa-lib pull request #263 was opened from nabajour:

This points iec958_device to the correct PCM device.

complements this [ALSA kernel patch](https://bugzilla.kernel.org/show_bug.cgi?id=211005).

Request URL   : https://github.com/alsa-project/alsa-lib/pull/263
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/263.patch
Repository URL: https://github.com/alsa-project/alsa-lib
