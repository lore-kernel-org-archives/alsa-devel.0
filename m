Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F42C4CECE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:06:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C52217D9
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Mduaj4Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C52217D9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0179D1666;
	Mon, 14 Oct 2019 17:05:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0179D1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571065568;
	bh=cLjLkoW5Mf9q//+2+N3c4CUk0N35lpZsXgqleoYlXr4=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mduaj4CvOkRrfCj2nPQfETrvq1VazC6PrtIRyh0IfHgNempFlpgtjAzDU/JpNk93P
	 3TswvTkVyCKwm9APTGtHF8f2dIqkOVoiDGWpdkQgxJCJwOZI6md6TEEjTzGh7htXCC
	 tNINGSUWcjNhqdiFP5Tp7Wrb5GY7MElrTJ4GM1Do=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DD5AF80362;
	Mon, 14 Oct 2019 17:05:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C10D4F80369; Mon, 14 Oct 2019 17:05:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8AFF5F80322
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 17:05:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AFF5F80322
MIME-Version: 1.0
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1571065513405306101-webhooks-bot@alsa-project.org>
References: <1571065513405306101-webhooks-bot@alsa-project.org>
Message-Id: <20191014150515.C10D4F80369@alsa1.perex.cz>
Date: Mon, 14 Oct 2019 17:05:15 +0200 (CEST)
Subject: [alsa-devel] TypeError: 'device' is an invalid keyword argument for
	this function
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #13 was edited from paddygoat:

Hello again!

I upgraded Alsa lib to 1.1.7 and tested ok. A small error as below when running in Jupyter Notebook, Python 3.6::

`#inp = alsaaudio.PCM(alsaaudio.PCM_CAPTURE, alsaaudio.PCM_NONBLOCK)
 # UltraMic384K 16bit r0, USB Audio

    inp = alsaaudio.PCM(type = alsaaudio.PCM_CAPTURE, mode=alsaaudio.PCM_NORMAL, device='UltraMic384K 16bit r0')
    # class alsaaudio.PCM(type=PCM_PLAYBACK, mode=PCM_NORMAL, device='default', cardindex=-1)`

---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-6-947bfb637aff> in <module>
     16 modelName="randomforestPaddyFalse"
     17 modelType="randomforest"
---> 18 recordAnalyzeAudio(10, outputWavFile, 2.0, modelName, modelType)

<ipython-input-5-8ddddfa5b724> in recordAnalyzeAudio(duration, outputWavFile, midTermBufferSizeSec, modelName, modelType)
     87     # UltraMic384K 16bit r0, USB Audio
     88 
---> 89     inp = alsaaudio.PCM(type = alsaaudio.PCM_CAPTURE, mode=alsaaudio.PCM_NORMAL, device='UltraMic384K 16bit r0')
     90     # class alsaaudio.PCM(type=PCM_PLAYBACK, mode=PCM_NORMAL, device='default', cardindex=-1)
     91     inp.setchannels(2)

TypeError: 'device' is an invalid keyword argument for this function

Thanks!

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/13
Repository URL: https://github.com/alsa-project/alsa-lib
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
