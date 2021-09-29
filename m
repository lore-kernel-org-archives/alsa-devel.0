Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E92C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 14:55:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E37061440
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 14:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E37061440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DC0B16E4;
	Wed, 29 Sep 2021 16:54:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DC0B16E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632927300;
	bh=eDWb19Rcr9nk97bJZ/ALRAhR24sFGARRqyeRuQiHBws=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UdSXM2TXzNas92GLLUricSE4jvWOXoEq0e5A/7CE5NhoMLoE8/lUpVGi//Wq1/PaF
	 UXTtNxzg36HfHT2MHsONoodvz7sR7rJPrsLm1TnhqA9CjKb4xtkhnmvmDD9s4Up6d8
	 mmqu8I1JmQasjfV2QYFnXwReVqX2aSFnQTedkLDQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E186DF804CC;
	Wed, 29 Sep 2021 16:54:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B37D6F804E4; Wed, 29 Sep 2021 16:54:00 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B08B5F804CC
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 16:53:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B08B5F804CC
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="221752080"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="221752080"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:53:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; d="scan'208";a="588075520"
Received: from ibarchen-mobl.amr.corp.intel.com (HELO [10.209.150.234])
 ([10.209.150.234])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:53:51 -0700
Subject: Re: [PATCH v2 1/2] ALSA: hda: Reduce udelay() at SKL+ position
 reporting
To: Takashi Iwai <tiwai@suse.de>
References: <20210929072934.6809-1-tiwai@suse.de>
 <20210929072934.6809-2-tiwai@suse.de>
 <de3688c6-2246-a7ec-cfd9-6bc4cde0467b@linux.intel.com>
 <s5h4ka3monj.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e23c5525-790e-bd04-42cc-334af16d8af0@linux.intel.com>
Date: Wed, 29 Sep 2021 09:53:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5h4ka3monj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, alsa-devel@alsa-project.org
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



On 9/29/21 9:39 AM, Takashi Iwai wrote:
> On Wed, 29 Sep 2021 16:15:44 +0200,
> Pierre-Louis Bossart wrote:
>>
>>
>>> @@ -874,11 +896,7 @@ static unsigned int azx_get_pos_skl(struct azx *chip, struct azx_dev *azx_dev)
>>>  	if (azx_dev->core.substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>>  		return azx_skl_get_dpib_pos(chip, azx_dev);
>>>  
>>> -	/* For capture, we need to read posbuf, but it requires a delay
>>> -	 * for the possible boundary overlap; the read of DPIB fetches the
>>> -	 * actual posbuf
>>> -	 */
>>> -	udelay(20);
>>> +	/* read of DPIB fetches the actual posbuf */
>>>  	azx_skl_get_dpib_pos(chip, azx_dev);
>>
>> I don't think extra read has any effect, it could be removed....
>>
>>>  	return azx_get_pos_posbuf(chip, azx_dev);
>>>  }
>>
>> The suggestion was to further simplify with
>>
>> static unsigned int azx_get_pos_skl(struct azx *chip, struct azx_dev
>> *azx_dev)
>> {
>> 	return azx_get_pos_posbuf(chip, azx_dev);
>> }
>>
>> i.e. same behavior on playback and capture. that's the recommendation
>> from Intel hw folks.
> 
> It's achieved in the second patch.

Ah ok. the additional comment made me think it was there to stay.
