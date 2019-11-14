Return-Path: <SRS0=S9OM=ZG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1519CC43141
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:52:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949FB2068D
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LDNer6lE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OLWAEo+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949FB2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8D0D1666;
	Thu, 14 Nov 2019 12:51:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8D0D1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573732338;
	bh=jJ2WvMzwQ+ORwfJkVUT6CygBfd/yludGcsMpdPuMYFA=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LDNer6lEdxNAjv3hHivDpwfFIP/qGQnTBQscvB3pp1et9o1BfDj2EPhIkg9VMlLQp
	 jQslD0fPBK2RAYLyxPD8tOMKQvoTmn/sxZ47wALPYsBhPU71MP8LHK8BPdjPC753Hf
	 JIyRBEF3Q74QnpNHpKWCU6879P/ySf90DCz4Cwj0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84395F800ED;
	Thu, 14 Nov 2019 12:50:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D1AEF800EF; Thu, 14 Nov 2019 12:50:42 +0100 (CET)
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CB4FF800EC
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2019 12:50:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CB4FF800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="OLWAEo+s"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcd3f880000>; Thu, 14 Nov 2019 03:50:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 14 Nov 2019 03:50:33 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 14 Nov 2019 03:50:33 -0800
Received: from [10.24.218.121] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 11:50:32 +0000
To: Takashi Iwai <tiwai@suse.de>
References: <20191114033704.18171-1-nmahale@nvidia.com>
 <20191114033704.18171-6-nmahale@nvidia.com> <s5hmucyn2jt.wl-tiwai@suse.de>
From: Nikhil Mahale <nmahale@nvidia.com>
Message-ID: <9a27790c-2d30-8622-8e38-1ff547de4c3a@nvidia.com>
Date: Thu, 14 Nov 2019 17:20:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <s5hmucyn2jt.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573732233; bh=5eJhr4MoGwlONMJQXmj3MFYpHppwk6tZld636xWiDbU=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=OLWAEo+sjTOOdRq20N00lM+TdXwX7wcyH445lkojFdILy2SKWURs9PPvI9Knua7GS
 Ed6jmdw0j0rXQW4fs+H7YCWa5I/3w2tJadqloFjJMMr5yv/Q2i9mDv0R51T+X0qjHw
 7vIz1WhVuS86WGTVOAi4PczeGiLb6Sqho1JP39mHDjnBsYps9SIbyYjeQeXmKn8pD4
 tAcoYk8LZrHBrlH9bcwle+TJlBmYh55YIUGHVYZkqM22JM3+rWkBrUHO/dh8Lbt6VC
 yE9mZet85Adr8JtimsmBYWZ/w50hNAhJZHwZIhUbGg1+3+42OZ2Pku0OfwS4nDYs1P
 MkVkGyM2/wu3w==
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, aplattner@nvidia.com
Subject: Re: [alsa-devel] [PATCH v1 5/5] ALSA: hda - Add DP-MST support for
	NVIDIA codecs
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

On 11/14/19 4:32 PM, Takashi Iwai wrote:
> On Thu, 14 Nov 2019 04:37:04 +0100,
> Nikhil Mahale wrote:
>>
>> @@ -3494,11 +3500,86 @@ static const struct drm_audio_component_audio_ops nvhdmi_audio_ops = {
>>  	.master_unbind = generic_acomp_master_unbind,
>>  };
>>  
>> +static int nvhdmi_find_pcm_slot(struct hdmi_spec *spec,
>> +				struct hdmi_spec_per_pin *per_pin)
>> +{
>> +	int i;
>> +
>> +	/*
>> +	 * generic_hdmi_build_pcms() allocates (num_nids + dev_num - 1)
>> +	 * number of pcms.
>> +	 *
>> +	 * The per_pin of pin_nid_idx=n and dev_id=m prefers to get pcm-n if m==0.
>> +	 * This guarantees that dynamic pcm assignments are compatible with the
>> +	 * legacy static per_pin-pmc assignment that existed in the days before
>> +	 * DP-MST.
>> +	 *
>> +	 * per_pin of m!=0 prefers to get pcm=(num_nids + (m - 1)).
>> +	 */
>> +	if (per_pin->dev_id == 0 &&
>> +	    !test_bit(per_pin->pin_nid_idx, &spec->pcm_bitmap))
>> +		return per_pin->pin_nid_idx;
>> +
>> +	if (per_pin->dev_id != 0 &&
>> +	    !(test_bit(spec->num_nids + (per_pin->dev_id - 1),
>> +		&spec->pcm_bitmap))) {
>> +		return spec->num_nids + (per_pin->dev_id - 1);
>> +	}
>> +
>> +	/* have a second try; check the area over num_nids */
>> +	for (i = spec->num_nids; i < spec->pcm_used; i++) {
>> +		if (!test_bit(i, &spec->pcm_bitmap))
>> +			return i;
>> +	}
>> +
>> +	/* the last try; check the empty slots in pins */
>> +	for (i = 0; i < spec->num_nids; i++) {
>> +		if (!test_bit(i, &spec->pcm_bitmap))
>> +			return i;
>> +	}
>> +	return -EBUSY;
>> +}
> 
> I think this can be applied for Intel case, too.  No need for creating
> yet another indirect branch.

Do you mean I should replace existing logic in hdmi_find_pcm_slot()
by this new logic?

Thanks,
Nikhil Mahale

> thanks,
> 
> Takashi
> 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
