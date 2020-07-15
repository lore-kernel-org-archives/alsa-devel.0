Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C7AC433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:39:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134422064C
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b4IXsJ5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134422064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 900CC1614;
	Wed, 15 Jul 2020 11:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 900CC1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594805942;
	bh=+jsDE+D3zFJAuQO1jnZ4yuauO69WV7vojGcL35Lt95M=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4IXsJ5ZerOlUGxWGSttiU39oxys+StPdXY+ebKuQxI2Ng8dImoAetTRfuz+ovNup
	 cYRtM/Ky/ShZMPzyISusVN8ZZuqdoFEex/Ff9NRJrqQ27iCMeHXOpigoivxp0T7fT9
	 09xei4udR6kvfOxXB1FL7LRJHmsV71Q0oAN4Gato=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17DE4F80113;
	Wed, 15 Jul 2020 11:38:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55568F8021D; Wed, 15 Jul 2020 11:38:10 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B25CF80113
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 11:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B25CF80113
IronPort-SDR: srHu8XxFtO7FyYkv1J3VjiNyTILw7yvKrv+cdth+iz+QAkYmP0L2knMOGUjgjdo4rOHJHyT7Bt
 CBJrXAVpuiiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="149107912"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="149107912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 02:37:57 -0700
IronPort-SDR: CH9CzPoxLMObigmZB2YO4WiH68nQftEBWB7/hQiE+rzsZBuW1SOrUBHWADbay3XQ4NtG7/BEYS
 K4CpJbLyhiZQ==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; d="scan'208";a="460008005"
Received: from pmaziarx-mobl.ger.corp.intel.com (HELO [10.249.128.28])
 ([10.249.128.28])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2020 02:37:56 -0700
Subject: Re: [PATCH v3 07/10] topology: decode: Fix decoding PCM formats and
 rates
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
 <1594725911-14308-8-git-send-email-piotrx.maziarz@linux.intel.com>
 <bca4e102-f734-df31-17aa-686bc1463819@linux.intel.com>
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Message-ID: <37b724ff-e485-8b7a-f16d-8cf8f8ac7c9b@linux.intel.com>
Date: Wed, 15 Jul 2020 11:37:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bca4e102-f734-df31-17aa-686bc1463819@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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

On 2020-07-14 17:40, Pierre-Louis Bossart wrote:
> 
> 
> On 7/14/20 6:25 AM, Piotr Maziarz wrote:
>> Not checking _LAST format and rate, which are valid indexes in arrays,
>> makes data loss while converting binary to standard ALSA configuration
>> file.
> 
> I must be really thick on this one.
> 
> alsatplg converts from alsa-conf format to binary topology file.
> The binary topology file is used by drivers.
> 
> In which cases would you convert from binary to alsa-conf files? And 
> what tool would you use?
> 
./alsatplg --decode topology.bin --output decoded_topology.conf,
This feature was added around the end of 2019. And why to use it? For 
binary topologies to which conf files are lost for example. It's easier 
to analyze and edit it in conf than directly in binary.

> 
>> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
>> ---
>>   src/topology/pcm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/topology/pcm.c b/src/topology/pcm.c
>> index b15b950..db40114 100644
>> --- a/src/topology/pcm.c
>> +++ b/src/topology/pcm.c
>> @@ -549,7 +549,7 @@ int tplg_save_stream_caps(snd_tplg_t *tplg 
>> ATTRIBUTE_UNUSED,
>>       if (err >= 0 && sc->formats) {
>>           err = tplg_save_printf(dst, pfx, "\tformats '");
>>           first = 1;
>> -        for (i = 0; err >= 0 && i < SND_PCM_FORMAT_LAST; i++) {
>> +        for (i = 0; err >= 0 && i <= SND_PCM_FORMAT_LAST; i++) {
>>               if (sc->formats & (1ULL << i)) {
>>                   s = snd_pcm_format_name(i);
>>                   err = tplg_save_printf(dst, NULL, "%s%s",
>> @@ -563,7 +563,7 @@ int tplg_save_stream_caps(snd_tplg_t *tplg 
>> ATTRIBUTE_UNUSED,
>>       if (err >= 0 && sc->rates) {
>>           err = tplg_save_printf(dst, pfx, "\trates '");
>>           first = 1;
>> -        for (i = 0; err >= 0 && i < SND_PCM_RATE_LAST; i++) {
>> +        for (i = 0; err >= 0 && i <= SND_PCM_RATE_LAST; i++) {
>>               if (sc->rates & (1ULL << i)) {
>>                   s = get_rate_name(i);
>>                   err = tplg_save_printf(dst, NULL, "%s%s",
>>

