Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5DEECAAD3
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Aug 2022 05:28:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07D9316B2;
	Wed, 31 Aug 2022 07:27:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07D9316B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661923691;
	bh=Mj+ZH3M4sbl22i0J8G29GCzSx8FZ81QJj9E21o4q81s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GKn3KO5rI8Y+5pUBLeuP3jh2wIzYJzNyCAzq9C8EilnPiNkD/JFCShuLok8hcYcF9
	 FdfKo+EszNK5dzM7AJX4NaE5iE1oGLvScNwo7ftZm7qQvwwDAA6OfOcGBcXj9vcglz
	 jx62V894RqY8LgGWgUnOV1bGK3TEeq7QNuae9nYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95DC5F80236;
	Wed, 31 Aug 2022 07:27:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71C06F8042F; Wed, 31 Aug 2022 07:27:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A0116F8012A
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2022 07:27:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0116F8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661923634612883091-webhooks-bot@alsa-project.org>
References: <1661923634612883091-webhooks-bot@alsa-project.org>
Subject: How does PlaybackChannelPos# Work?
Message-Id: <20220831052718.71C06F8042F@alsa1.perex.cz>
Date: Wed, 31 Aug 2022 07:27:18 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #209 was opened from 13r0ck:

I found https://github.com/alsa-project/alsa-lib/commit/0ba999591b78e07a4b8e610ebced2c388197e36e but doesn't seem to work when setting audio jack output.

I have a mostly working configuration for a motherboard's 3.5mm audio jack output. The only problem is that the C/Sub and Rear jacks are flipped. I am assuming setting the `PlaybackChannelPos` in the speaker should work, but it doesn't for some reason.

```
SectionDevice."Speaker" {
    Commant "Speakers"
    Value {
        PlaybackChannel2 "BL"
        PlaybackChannel3 "BR"
        PlaybackChannel4 "FC"
        PlaybackChannel5 "LFE"
    }
}
```

Any help would be greatly appreciated!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/209
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
