Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC8CC433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Dec 2021 09:28:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39544185D;
	Sun, 19 Dec 2021 10:27:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39544185D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639906115;
	bh=4o+CCYyIeN/CaotC58JjZ4yybHl1AyPF/RHPO7IZqZE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Aao9KF+vWPOQn/b5Ic6akQStyuY7hHNjmQB/IAE5bxjXDm/qnt/7r2OH54MMywECS
	 uIJNvcVSbrPxCT3J5o/LuXhAoUL/EG5xBZahnog6ooZkpbtiRThz5ydEr89D6iJOEW
	 BEkTZTONpt9D2CsSOrGXwfvFlP98p2AMeHf1n9Mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0EFFF8026A;
	Sun, 19 Dec 2021 10:27:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EE92F8012A; Sun, 19 Dec 2021 10:27:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5AAA4F8012A
 for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2021 10:27:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AAA4F8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639906055141784906-webhooks-bot@alsa-project.org>
References: <1639906055141784906-webhooks-bot@alsa-project.org>
Subject: Missing profile 7.1
Message-Id: <20211219092742.4EE92F8012A@alsa1.perex.cz>
Date: Sun, 19 Dec 2021 10:27:42 +0100 (CET)
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

alsa-project/alsa-utils issue #128 was opened from raven2cz:

Hello,
I have several years profile 7.1 which is missing now around 1.5-2months. I already write these issues 
* https://bbs.archlinux.org/viewtopic.php?id=272280
* https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1309

It seems that the problem can be in alsa-utils.
```
control.45 {
                iface PCM
                name 'Playback Channel Map'
                value.0 0
                value.1 0
                value.2 0
                value.3 0
                value.4 0
                value.5 0
                comment {
                        access read
                        type INTEGER
                        count 6
                        range '0 - 36'
                }
        }
```
I already try to change kernels, not help. See inside the issues whole test env. 

Can you help me?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/128
Repository URL: https://github.com/alsa-project/alsa-utils
