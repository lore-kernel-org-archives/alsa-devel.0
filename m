Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B5CC4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Dec 2022 15:04:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79787180D;
	Thu,  8 Dec 2022 16:03:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79787180D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670511888;
	bh=vdiXkJ1ZnI24LVcXWZTMABTwKnWl/rBcRysHizaAti4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aawplL115HLiHpJ10M5dVImxfvwFy9l5rJCTCSMyEvbI+lg9bu7n51jPkFSNRXnzL
	 msCXYDg2SbzNwOYg8ec2prGQtKoS59qmi9L2KCi83bkmItH57PuTEtcieSL3rRnNmb
	 yk5neEDhzikuRKTdB8isS9Aqek+AaE5spd4Bilqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32631F801D8;
	Thu,  8 Dec 2022 16:03:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF361F8020D; Thu,  8 Dec 2022 16:03:56 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BE0AFF800F8
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2022 16:03:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE0AFF800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1670511826576553106-webhooks-bot@alsa-project.org>
References: <1670511826576553106-webhooks-bot@alsa-project.org>
Subject: What device should I have
Message-Id: <20221208150356.EF361F8020D@alsa1.perex.cz>
Date: Thu,  8 Dec 2022 16:03:56 +0100 (CET)
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

alsa-project/tinycompress issue #21 was opened from Duty-rok:

Hello, I am tesing your library now.
lsmod says that kernel has snd_compress module loaded.

I have file.mp3 and try to execute cplay next way:
    $ cplay file.mp3

Next logs were written to output:
    Unable to open Compress device 0:0
    ERR: cannot open device '/dev/snd/comprC0D0': No such file or directory

I looked through the contents of the /dev/snd/ folder and found nothing that had prefix 'compr'.

So, what device should I have to test it?

Issue URL     : https://github.com/alsa-project/tinycompress/issues/21
Repository URL: https://github.com/alsa-project/tinycompress
