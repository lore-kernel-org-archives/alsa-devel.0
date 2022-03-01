Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE090C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Mar 2022 04:29:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C60F61B02;
	Tue,  1 Mar 2022 05:28:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C60F61B02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646108942;
	bh=tHMMXZI3mUnOXlmWKmma10/Rbnj12FJTzh12Lh9Pfh8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQd8Bj4XnMnbZ5EGDnPleNCh/QtWbrsObMJUcwMxa+N+BUMJp+f6A43x27E930L3H
	 vjyYyhrz5mVXIK6fM0CTRhezUzgOXGiSk3Cr8ssOvZHqirOqA7HsPqYelIqdAU0ZRL
	 3v6ceIcSPhIEc7XflBNm8f+ktjroJJ41xGEQV2sY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61579F801D8;
	Tue,  1 Mar 2022 05:28:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A95DF80227; Tue,  1 Mar 2022 05:28:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 40C75F80167
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2022 05:28:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40C75F80167
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1646108881728133917-webhooks-bot@alsa-project.org>
References: <1646108881728133917-webhooks-bot@alsa-project.org>
Subject: Issue in pcm_dsnoop.c in alsa-lib
Message-Id: <20220301042808.6A95DF80227@alsa1.perex.cz>
Date: Tue,  1 Mar 2022 05:28:08 +0100 (CET)
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

alsa-project/alsa-lib issue #213 was opened from TE-N-ShengjiuWang:

Hi Takashi Iwai, Jaroslav Kysela

    We encountered an issue in the pcm_dsnoop use case, could you please help to have a look? 

    Issue description:
    With two instances for dsnoop type device running in parallel, after suspend/resume,  one of the instances will be hung in memcpy because the very large copy size is obtained.

#3 0x0000ffffa78d5098 in snd_pcm_dsnoop_sync_ptr (pcm=0xaaab06563da0)
at pcm_dsnoop.c:158
dsnoop = 0xaaab06563c20
slave_hw_ptr = 64
old_slave_hw_ptr = 533120
avail = 187651522444320

   Reason analysis: 
   The root cause that I analysis is that after suspend/resume,  one instance will get the SND_PCM_STATE_SUSPENDED state from slave pcm device,   then it will do snd_pcm_prepare() and snd_pcm_start(),  which will reset the dsnoop->slave_hw_ptr and the hw_ptr of slave pcm device,  then the state of this instance is correct.  But another instance may not get the SND_PCM_STATE_SUSPENDED state from slave pcm device because slave device may have been recovered by first instance,  so the dsnoop->slave_hw_ptr is not reset.  but because hw_ptr of slave pcm device has been reset,  so there will be a very large "avail" size. 

   Solution:
   I didn't come up with a fix for this issue,  seems there is no easy way to let another instance know this case and reset the  dsnoop->slave_hw_ptr,  could you please help?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/213
Repository URL: https://github.com/alsa-project/alsa-lib
