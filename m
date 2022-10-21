Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1D6C38A2D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Oct 2022 22:26:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E456F9A2B;
	Sat, 22 Oct 2022 00:25:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E456F9A2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666391177;
	bh=rkeoNosBtpqJBt0/QT+qQBqro98gOopdOxRj+TGEhvc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OowVES7bmzx9UbSFmlx4jQ3MEXqOQ9L74X/ztyKd4r9H4Hna+3634MsGZ+a5q2l8t
	 3F4FC+BXtSAcfqY0cb5cGxpJkXUcD6q/eJnsljIVLEzfpdm5saHwGvDSxkqy46EYFr
	 Hrti5knkNPcLa62dGANCUCxlG6vKODcZhWAZDfmM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75931F80134;
	Sat, 22 Oct 2022 00:25:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 616FDF80118; Sat, 22 Oct 2022 00:25:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5FCB8F80118
 for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2022 00:25:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FCB8F80118
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1666391117712142944-webhooks-bot@alsa-project.org>
References: <1666391117712142944-webhooks-bot@alsa-project.org>
Subject: Using snd_device_name_hint() with iface "card"
Message-Id: <20221021222524.616FDF80118@alsa1.perex.cz>
Date: Sat, 22 Oct 2022 00:25:24 +0200 (CEST)
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

alsa-project/alsa-lib issue #277 was edited from MathisMARION:

Hello,

I have been experimenting with the `alsa` library, and I tried to use the `snd_device_name_hint()` function to print information about devices. It doesn't seem documented [here](https://www.alsa-project.org/alsa-doc/alsa-lib/group___control.html) so I looked up for examples online, and explored the source code as well.

Looking at the [source code](https://github.com/alsa-project/alsa-lib/blob/master/src/control/namehint.c#L582), it seems like the function should be able to take `"card"` as a valid interface. However when I run this function, it returns `ENOENT`. I ran my program with `gdb` and found that [this call](https://github.com/alsa-project/alsa-lib/blob/master/src/control/namehint.c#L639) to `add_card()` was returning the error. `add_card` calls `snd_config_search` which loops through a list to find a match. In my case I found out that the list contained `"cards"` (with an `s`), while the code was searching for `"card"` so I am left wondering if this was done on purpose. Moreover I can get info about my sound cards using `/proc/asound/cards` (with an `s` again) so it makes me doubt even more...

I am running Ubuntu 20.04.5, and have installed `libasound2-dev` version `1.2.2-2.1ubuntu2.5`. I can give more info about my setup if needed, I am just unsure what other info would help as of right now.

Here's a simple program reproducing my issue:
```c
#include <alsa/asoundlib.h>
#include <stdio.h>

int main()
{
    void **hints;
    int ret;

    ret = snd_device_name_hint(-1, "card", &hints);
    if (ret) {
        printf("snd_device_name_hint: %s\n", snd_strerror(ret));
        return EXIT_FAILURE;
    }
    snd_device_name_free_hint(hints);
    return EXIT_SUCCESS;
}

```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/277
Repository URL: https://github.com/alsa-project/alsa-lib
