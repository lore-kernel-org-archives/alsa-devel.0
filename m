Return-Path: <SRS0=wVxo=FS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E232C4361B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 10:50:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECB722C97
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 10:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECB722C97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 551CF1757;
	Mon, 14 Dec 2020 11:49:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 551CF1757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607943013;
	bh=nEcrrJIDSA9+zr+5sIJCNp7ecswDHRcPSb2PXyR7LMs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d7jwZh7BDHkXkeRVzhPrF+L0yClRAfKkL4cjQVNBWoe8U1+moTaYtw8xGvmKGo7kA
	 JKlULvFiF1MpyMJrrttSvHl1xBULG31fORUPDWRYmSMYkPOanVTqqmr8yKPFFgdf4K
	 0R82bQh+POcI6SfCaPh6wf0C/uhSBFHTsemwT9G4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3762F80171;
	Mon, 14 Dec 2020 11:49:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F377F801F7; Mon, 14 Dec 2020 11:49:22 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7998F80121
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2020 11:49:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7998F80121
Received: from 61-220-137-34.hinet-ip.hinet.net ([61.220.137.34]
 helo=[10.101.195.16]) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1kolPq-0005pz-Ao; Mon, 14 Dec 2020 10:49:18 +0000
Subject: Re: [RFC][PATCH 0/2] design a way to change audio Jack state by
 software
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>
References: <20201209124344.219158-1-hui.wang@canonical.com>
 <575811fc-cb64-c7d4-bf6b-5044949a326c@perex.cz>
 <alpine.DEB.2.22.394.2012111522490.864696@eliteleevi.tm.intel.com>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <10346ea7-f9a3-45a0-49ca-fbb3d2d4d5f1@canonical.com>
Date: Mon, 14 Dec 2020 18:48:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2012111522490.864696@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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


On 12/11/20 9:36 PM, Kai Vehmanen wrote:
> Hi,
>
> On Wed, 9 Dec 2020, Jaroslav Kysela wrote:
>
>> Dne 09. 12. 20 v 13:43 Hui Wang napsal(a):
>>> After we change sth in the userspace audio stack like alsa-ucm or
>>> pulseaudio, we want to perform remote audio auto test to verify if the
>>> change introduce the regression or not, some of the tests are about
>>> the defaut_sink/default_source or active_port switching, this needs
> thanks Hui for the RFC.
>
> I do think this is a very tempting capability to add. I understand
> Jaroslav's concerns as well, but there is clearly a category of issues
> where user-space functionality is broken due to a mismatch of element
> names between UCM file and the driver. I.e. the actual jack detection
> (codec hw and its driver) is working, but due to wrong UCM file chosen,
> wrong driven is chosen, or errors in either UCM or driver, event does not
> get parsed right and user ends with no audio.
>
> A pure user-space test harness would not catch these, and building full
> automation of external codec events, is a complex task and coverage of
> devices is likely limited.
>
> The 'edid_override' debugfs interface in i915 is a bit similar. It allows
> inject EDID content irrespectively of the actual monitor connected.
>
>> Also, the first patch can be omitted if you just create another
>> snd_jack_report() function for the user API and put the common code to the
>> static function in jack.c.
> ++votes on this
OK, got it,  am preparing the v2 RFC, will send it out soon. Thanks for 
your comment.
>
> Br, Kai
