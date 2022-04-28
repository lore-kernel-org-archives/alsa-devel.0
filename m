Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E06CC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Apr 2022 15:29:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CC8015E2;
	Thu, 28 Apr 2022 17:28:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CC8015E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651159766;
	bh=ALpSzuYvlhrsk1tu4G8vN90Yq1eOEb+p3lozYG0382A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lkjq58pcDAyUeVPshQvnZkUQ4ITYCI6dg/f1cl9fc3BBKA6EgwNycryieNBDjfFQ+
	 lSlM8AhvJboY/tkMIaRsj6wpO3zNvnoLEY7x4u+DS4SzNe63goHJ2s7EuBI2l9EMxC
	 9G/AfRwnMVPS43cIMKLCi8E7DQyXZ30g/nSN0nuI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D07FF8014E;
	Thu, 28 Apr 2022 17:28:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECE27F8016E; Thu, 28 Apr 2022 17:28:29 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F02BEF8012B
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2022 17:28:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F02BEF8012B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1651159701066536903-webhooks-bot@alsa-project.org>
References: <1651159701066536903-webhooks-bot@alsa-project.org>
Subject: Play jitter coming from dshare
Message-Id: <20220428152829.ECE27F8016E@alsa1.perex.cz>
Date: Thu, 28 Apr 2022 17:28:29 +0200 (CEST)
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

alsa-project/alsa-lib issue #221 was opened from davidboulangerlatour:

I have an application which plays a wav file (using dshare) at with a specific period (ie. every 720ms). This always worked well up to recently after upgrading alsa-lib from 1.1.7 to 1.2.4. With 1.2.4, the cycles look like this [750ms, 750ms, 750ms, 625ms], normally it would be [720ms, 720ms, ...].

When doing a bisect to find the issue, I found this commit to be the cause:
```
7265e603bf880a9ec2cd01c3cf2afbd7709e5af4 is the first bad commit
commit 7265e603bf880a9ec2cd01c3cf2afbd7709e5af4
Author: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
Date:   Wed May 15 11:56:33 2019 +0530

    pcm: dshare: Added "hw_ptr_alignment" option in configuration for alignment of slave pointers
    
    This change adapt the fix commit 6b058fda9dce
    ("pcm: dmix: Add option to allow alignment of slave pointers")
    for dshare plugin
    
    Issue is that snd_pcm_wait() goes back to waiting because the hw_ptr
    is not period aligned. Therefore snd_pcm_wait() will block for a longer
    time as required.
    
    With these rcar driver changes the exact position of the dma is returned.
    During snd_pcm_start they read hw_ptr as reference, and this hw_ptr
    is now not period aligned, and is a little ahead over the period while it
    is read. Therefore when the avail is calculated during snd_pcm_wait(),
    it is missing the avail_min by a few frames.
    
    An additional option hw_ptr_alignment is provided to dshare configuration,
    to allow the user to configure the slave application and hw pointer
    alignment at startup
    
    Signed-off-by: Vanitha Channaiah <vanitha.channaiah@in.bosch.com>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

 src/pcm/pcm_dshare.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)
```

I tried the more recent 1.2.6 with the same issue. I also tried all the "hw_ptr_alignment" options with no success.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/221
Repository URL: https://github.com/alsa-project/alsa-lib
