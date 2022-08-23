Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE27C32774
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 06:40:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9176F1654;
	Tue, 23 Aug 2022 08:39:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9176F1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661236834;
	bh=Z1LMO+W+wszexh5hNyqmWgp4oYI+MQaDcl+ze1Jj2Co=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jB4W/a+Hyi8W06aEJt1hzeQQCEvc220xgXnq/3htnfw+SeYC+xYmh6xo74czNr9AA
	 /I3HMScdRn3fiG5jBo12zC4p5JkdwdWDUm5R26J6Sx7qo5lEGhvhHDajPC3VIRgj9s
	 hulnXlCyec8eXg2DxdUtAX0WsoFhlAAFLILAwAY0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AD00F80152;
	Tue, 23 Aug 2022 08:39:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67C7DF8020D; Tue, 23 Aug 2022 08:39:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 32336F800A7
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 08:39:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32336F800A7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661236771808708906-webhooks-bot@alsa-project.org>
References: <1661236771808708906-webhooks-bot@alsa-project.org>
Subject: Adding Focusrite Scarlett 2i4 gen2
Message-Id: <20220823063942.67C7DF8020D@alsa1.perex.cz>
Date: Tue, 23 Aug 2022 08:39:42 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #203 was opened from PatrickLang:

This cleans up the Focusrite Scarlett 2i4 Gen2 device a bit. This device is split into two stereo pairs for output, and has 2 mic/line/instrument inputs. There are no toggles or mixer controls exposed to Alsa.

It has hardware switches for:
- Headphones - can monitor line outputs 1+2 or 3+4
- Headphone input/playback mix
- Monitor out (Line 1+2)
- Each input has a level pot, and switches for pad and Z (line/inst)
- There is 1 physical +48v switch

Please let me know if any more info would be helpful. I have captured some more notes showing before/after state at https://gist.github.com/PatrickLang/79a3090eea6f2d640179457b5d428134#scarlett-2i4-2nd-gen---initial-state

I'm planning to write a UCM2 profile for the more complicated Focusrite Scarlett 18i8 Gen2 next which has more inputs, but also multiple mix busses controllable through Alsa

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/203
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/203.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
