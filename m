Return-Path: <SRS0=P760=IL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16924C433E6
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 16:06:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B2964E4B
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 16:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B2964E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2043B18F1;
	Sat, 13 Mar 2021 17:05:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2043B18F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615651589;
	bh=I+tXFb4vRJoihUSkMF/I397PuhtuPB97TpmIdj2jc4o=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hq8kgBfsMH+RS+vKRfEu6XM5NjBvvT2q9Xx5lGFZvyY1FAh5BIQrvfM7f5ULu1BDd
	 /0SgG7Tm1g2N5/6kNaU8XOtnzWZ61EEBRqktnIXOo7FuT5LkMf5LeBSrWq3BiZxOAY
	 lhiF8Wq7Ih5uNVgSdXj+NsMrFCTmE8cI5hZkdLq4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94F5CF8019B;
	Sat, 13 Mar 2021 17:05:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39B47F80227; Sat, 13 Mar 2021 17:05:37 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFC33F80154
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 17:05:29 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 922CEA003F;
 Sat, 13 Mar 2021 17:05:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 922CEA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1615651528; bh=7lrSz9+LcpxjDmojAD7DURNhVaEGWfZn+mfYcENaU+Q=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=4zyQUaD/rnX8A2wI36oFaTEPxbCF+crbtXLRYcuu4lJWcfhHGJBZtFwr1BqqJTeQW
 ZSkL1V7S7MYNKhPsrmIWuSpHCbApwSSKsiMUZEuXS4H6CLUFiMRRUSFWcxBtzkAzC2
 nPd+02rcgSpfexdnaFZRQ3NUa6k9wMtSSVKPrLBE=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sat, 13 Mar 2021 17:05:24 +0100 (CET)
Subject: Re: [PATCH alsa-ucm-conf v2 7/7] codecs/rt5640: Specify
 Playback/CaptureMasterElem for HW volume-control
To: Hans de Goede <hdegoede@redhat.com>
References: <20210308220554.76111-1-hdegoede@redhat.com>
 <20210308220554.76111-8-hdegoede@redhat.com>
 <784b0a8e-7308-9b08-c751-4f8571576c13@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <cac481fc-1f99-aeb1-f1f5-7f12430e128f@perex.cz>
Date: Sat, 13 Mar 2021 17:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <784b0a8e-7308-9b08-c751-4f8571576c13@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

Dne 13. 03. 21 v 13:10 Hans de Goede napsal(a):
> Hi,
> 
> On 3/8/21 11:05 PM, Hans de Goede wrote:
>> Newer kernels add "aif:1" or "aif:2" to the components string to let
>> us know which AIF is being used.
>>
>> Use this to specify the correct Playback/CaptureMasterElem for HW
>> volume-control, based on which AIF is being used.
>>
>> On older kernels, where there is no "aif:%d" string in the components
>> string, no Playback/CaptureMasterElem is specified.
>>
>> In DigitalMics.conf the master mixer is used as regular CaptureMixerElem
>> instead of as CaptureMasterElem since the DMICs don't have any analog
>> volume control.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> The kernel side of this patch has landed now, so this patch can
> be merged now.

Merged. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
