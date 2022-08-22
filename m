Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09159C28D13
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Aug 2022 06:46:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D29D71622;
	Mon, 22 Aug 2022 08:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D29D71622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661150802;
	bh=/WBrEXie/csTYo53Auw5ej2TTTqSrde835TPpGpxMLQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l9qIK3E583dsZVNCjdDKjtA7N8gRVZDOafuVaW8vmFpo2gJ947phziKEth4MFosPM
	 O0ckh1WflGmnsKDiGq+gObeRW4dvb8rFk9HCYsDfr0zd5ATefAzta7i21x8VM0577B
	 huozcBLNMeuu6nALKVyWb3NH6oMXL6Dp+VvFqLuo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A662F80152;
	Mon, 22 Aug 2022 08:45:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B44A2F8026A; Mon, 22 Aug 2022 08:45:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1FDA8F80152
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 08:45:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FDA8F80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661150747490509987-webhooks-bot@alsa-project.org>
References: <1661150747490509987-webhooks-bot@alsa-project.org>
Subject: missing sound on kernel-5.15
Message-Id: <20220822064550.B44A2F8026A@alsa1.perex.cz>
Date: Mon, 22 Aug 2022 08:45:50 +0200 (CEST)
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

alsa-project/alsa-lib issue #264 was opened from chihhao-chen:

I am testing many types of headsets on Android platform with different kernel versions.

On kernel-5.10, calling sequence before playback is
snd_usb_hw_params -> set highest sampling rate, no SAMPLING_FREQ_CONTROL USB request in this stage
snd_pcm_release
snd_usb_hw_params -> set proper sampling rate, still no SAMPLING_FREQ_CONTROL USB request 
snd_usb_pcm_parepare -> in configure_endpoint SAMPLING_FREQ_CONTROL USB request  was sent

With the same calling sequence, a slightly behavior change on kernel-5.15 is
snd_usb_hw_params -> set highest sampling rate, SAMPLING_FREQ_CONTROL USB request  was sent
snd_pcm_release
snd_usb_hw_params -> set proper sampling rate, SAMPLING_FREQ_CONTROL USB request  was sent too
(because configure_endpoint was moved to snd_usb_hw_params function)
snd_usb_pcm_parepare -> no SAMPLING_FREQ_CONTROL USB request  because of USB EP flag check

I checked all USB packets and confirmed audio data output was correct.
But there may be missing sound problem for the first sound with many headsets (for example Samsung headset).
I found this issue is related to two-times sampling rate set request.
(I tried forcibly skip first USB request, everything became okay.)
So do you guys know why configure_endpoint was moved to snd_usb_hw_params?
Or could you provide patch for this problem?

Many thanks
Chihhao

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/264
Repository URL: https://github.com/alsa-project/alsa-lib
