Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 09:12:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8718B230FD
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 09:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8718B230FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EA2017A2;
	Mon, 25 Jan 2021 10:12:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EA2017A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611565971;
	bh=7Gl5aRz8ioeKjdBozAcxP6C9dwb1uUfS/LWfaNwMfLE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kaSPzsJ0mOZsIGorOjvZVGF4jjZl6wdMRRWLbPU6g1tk/fp1euW0pVzdH/mwR75P3
	 74Sm5M9780tBqPwlEjfpo/Eg54Jn6O20Z3yT86K/UX19MqP91KvFNdblAh0R59SQGz
	 VtC9VvvejN3Acl6PWvPlB94YyiAf6pzWYRxn3VuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 659F7F80130;
	Mon, 25 Jan 2021 10:12:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79551F80259; Mon, 25 Jan 2021 10:11:58 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14B33F80130
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 10:11:49 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 32865A003F;
 Mon, 25 Jan 2021 10:11:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 32865A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1611565908; bh=/Q6Y7Ux+wc3gTedRmnRLeuS5mmGypQ36iagEDeOvH6A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HIqdroh6UgiQiZKGAh9zPU4QEE0vTluilCT46oHMlZ+/agirVGjIrHmJvhV2WqtKC
 lbo2dr21U7jNWQdsKOVhtma+E2O7TBhvYm91Cu5AkgyLlQL7d71PGRxcjMuwt8JOdX
 HZVPYXWuAoCohFTrL6KUtXW6sVdB72gCUT1RGOZY=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 25 Jan 2021 10:11:42 +0100 (CET)
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: add PCI id for TGL-H
To: Takashi Iwai <tiwai@suse.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20210125083051.828205-1-kai.vehmanen@linux.intel.com>
 <s5h35yp5rli.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <e04b942a-0f61-2c6c-ceb1-393668cfe549@perex.cz>
Date: Mon, 25 Jan 2021 10:11:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <s5h35yp5rli.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org,
 Bard Liao <bard.liao@intel.com>, Xiuli Pan <xiuli.pan@intel.com>
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

Dne 25. 01. 21 v 9:49 Takashi Iwai napsal(a):
> On Mon, 25 Jan 2021 09:30:51 +0100,
> Kai Vehmanen wrote:
>>
>> From: Bard Liao <bard.liao@intel.com>
>>
>> Adding PCI id for TGL-H. Like for other TGL platforms, SOF is used if
>> Soundwire codecs or PCH-DMIC is detected.
>>
>> Signed-off-by: Bard Liao <bard.liao@intel.com>
>> Reviewed-by: Xiuli Pan <xiuli.pan@intel.com>
>> Reviewed-by: Libin Yang <libin.yang@intel.com>
>> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> 
> Is this needed for 5.11 or only for 5.12?
> (Or potentially needed for 5.11.x stable later? -- then we can take it
>  now, too)

All patches sent by Kai today are required to add support for the SoundWire
device Dell TGL-H SKU 0A5E in 5.11. But I think that this standalone patch may
enable the DMIC only platforms.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
