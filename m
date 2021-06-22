Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F8C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 19:45:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65866100B
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 19:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65866100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=neo-zeon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8712086E;
	Tue, 22 Jun 2021 21:44:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8712086E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624391111;
	bh=oXECp5Qu5OdNissB5krgC2OXtGx3o5D56w3p/P9hnF4=;
	h=From:Subject:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XlzHn5cLjt2BPe/XXX44sCPHE7B3uZshhrgfuDphz+3IPav4DRzvJhK+0Omv+8lyx
	 lHSFJNwR34MbsFBzqZkaFn2pCq8Mlxo5Jm8k5JaiTx8Dpv2dsSyb5oag+eCZfzisKw
	 gaS1y9tpxz2Al69PzBn8skUP0swd02IL6uAVwPGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2087BF8026A;
	Tue, 22 Jun 2021 21:44:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AEB4F80268; Tue, 22 Jun 2021 21:44:19 +0200 (CEST)
Received: from neo-zeon.de (neo-zeon.de [70.229.12.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93DFDF8025F
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 21:44:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93DFDF8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=neo-zeon.de header.i=@neo-zeon.de
 header.b="PXelqBWk"
Received: from neo-zeon.de (localhost [127.0.0.1])
 by neo-zeon.de (OpenSMTPD) with ESMTP id 71c685a6
 for <alsa-devel@alsa-project.org>;
 Tue, 22 Jun 2021 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=neo-zeon.de; h=from
 :subject:to:message-id:date:mime-version:content-type
 :content-transfer-encoding; s=1; bh=DPen+tPP2kiIOv3SLdep2Gwcq70=; b=
 PXelqBWkNGLenleDGB7SFV2c3Z03MzNRa6cWc+7y2R34FKZNIFmMVGQl0C0y8tzV
 nGrctPG8MpKdPu8peZqSrIflaXdHJS7cTPaz8ZSPqDFFrcqd+aWqn/Bd6aNR5JEX
 Vgier0HlBlM6zdNgi9BzIJ5SrY+VnmqpwUY5+f8KxOA=
Received: by neo-zeon.de (OpenSMTPD) with ESMTPSA id 714d97f4
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
 for <alsa-devel@alsa-project.org>;
 Tue, 22 Jun 2021 12:17:31 -0700 (PDT)
From: Cameron Berkenpas <cam@neo-zeon.de>
Subject: Lenovo Legion/Yoga Slim 7 speaker output
To: alsa-devel@alsa-project.org
Message-ID: <e51c7eb8-cb89-be61-a891-242122caa4d3@neo-zeon.de>
Date: Tue, 22 Jun 2021 12:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Hello,

I'm working on a patch to get audio output working on the speakers of 
the Lenovo Legion/Yoga Slim 7 laptops:
https://bugzilla.kernel.org/attachment.cgi?id=297559&action=diff

Please let me know if this isn't the right place for these types of 
questions.

Both of these laptops have ALC287's that both seem to need some codec 
initialization to get the speakers working. For both laptops, the specs 
report ALC3306, but Linux on both systems reports that it's an ALC287, 
and looking at the PCI ID's on Windows agrees that it's an ALC287.

This is my first time working on such a patch, and I'm having a 
headphone related problem:

1. When plugging headphones into the audio jack, I get sound on the 
headphones as expected. I see that the speakers are muted and  the 
headphones are unmuted as expected in alsamixer.

2. When I unplug the headphones, I can no longer get speaker output. 
Monitoring alsamixer,  I observe that unplugging the headphones results 
in the speakers being unmuted and the headphones are muted as expected. 
However, I am unable to get speaker output in this case.

3. If I plug in the headphones, don't play any sound, and then unplug 
the headphones, I see the same behavior in alsamixer, BUT speaker output 
still works.

4. If I apply the initialization verbs via hda-verb (the same verbs that 
I'm using in my patch), speaker output works again.

5. If speaker output is no longer working (due to #2), putting the 
laptop to sleep and resuming fixes the speakers. The code in the kernel 
seems to call the sound card's init again so this makes sense.


In short, it seems I need to re-initialize the speakers when the 
headphones are unplugged. Studying sound/pci/hda/patch_realtek.c, 
there's alc_headset_mode_unplugged(), but as there's currently no case 
for 0x10ec0287 at all. I'm not sure adding in a case that re-initializes 
makes sense if the vast majority of ALC287's don't need to when 
headphones are unplugged. It seems none of the other cards, at least as 
far as I can tell, do a re-init when headphones are unplugged either. 
They just seem to setup some pins and coefficients for the most part if 
anything at all.

How can I re-init the speakers when headphones are unplugged 
specifically for these specific models? The initial-initialization is 
only done for these laptops, I'm just unclear what, if any, mechanism 
there is for initialization on headphone unplugs?

Thanks!

-Cameron






