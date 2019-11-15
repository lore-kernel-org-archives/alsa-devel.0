Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1052CC432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:53:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9362072D
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r2i+Vz8N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N0oD4KfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9362072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E61D15F9;
	Fri, 15 Nov 2019 10:52:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E61D15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573811614;
	bh=slZE1fhxAIZPDceVxxkNUKaeBh5Ugj44pmXF+qRmF+s=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r2i+Vz8NSK+///yAE3qPpnNdoma9OxNaQcgV/WCx/V3bpBM3Z3Dshk9+0Nxh+ypoH
	 htJ8yOLoVdXmInIb86Yc1c6EULa4ewAjUJlmUc5y3XQlcYjjZ8TxfTjj6uL2VnH0/P
	 cxaGOGlNf8IO4ViyegsGbE6uZx9Db37Xevas1oq4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2594DF80102;
	Fri, 15 Nov 2019 10:52:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E300CF80103; Fri, 15 Nov 2019 10:52:41 +0100 (CET)
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE03DF8007E
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 10:52:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE03DF8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="N0oD4KfT"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dce75630001>; Fri, 15 Nov 2019 01:52:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Fri, 15 Nov 2019 01:52:35 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Fri, 15 Nov 2019 01:52:35 -0800
Received: from [10.24.218.121] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 09:52:33 +0000
To: Takashi Iwai <tiwai@suse.de>
References: <20191114033704.18171-1-nmahale@nvidia.com>
 <20191114033704.18171-4-nmahale@nvidia.com> <s5ho8xen2s3.wl-tiwai@suse.de>
 <9a6f7ac2-998f-23ff-c606-a780c4804eba@nvidia.com>
 <s5hd0dumwg5.wl-tiwai@suse.de>
From: Nikhil Mahale <nmahale@nvidia.com>
Message-ID: <5eb1ef50-e129-c188-0996-cd74de6a5025@nvidia.com>
Date: Fri, 15 Nov 2019 15:22:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <s5hd0dumwg5.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573811555; bh=CMUjl4dRulrnQm/NPUkorWscW3iFEV8n3HZf+NbmOkg=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=N0oD4KfTj3y1oT3a9RdxmvG0vSqN9Va8FP1wKEy0dJFlyTEHeK9FV/ZORsoSmc0kA
 sgEG1O/6TUSBe54P682u36j4lBN6miCjJbgFPeJgtLMGrSXXZ3z5DNOlvAYZv7MwCg
 6r6WUsLAAVe64Dd3R8H5MI/WThqY82r6qRP4XB97PTs5WRCjZxitOfXMA2l+8co7G8
 R1tVXwyBa60Rd5ZcJyVHZFaQ2sIY8swOWP9OdqqOYPZXObAy8cXgZT4RtQ4PZJTMrV
 gMK7L9IyUDbgnXDj019Qmer/FQeGhV/BaPCAiJxy/AJ5dzqGSUri7h9aUKC9VE+zi4
 yi7NNB12sK2QA==
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, aplattner@nvidia.com
Subject: Re: [alsa-devel] [PATCH v1 3/5] ALSA: hda - Add DP-MST conn list
	support
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

On 11/14/19 6:44 PM, Takashi Iwai wrote:
> On Thu, 14 Nov 2019 12:47:36 +0100,
> Nikhil Mahale wrote:
>>
>> On 11/14/19 4:27 PM, Takashi Iwai wrote:
>>> On Thu, 14 Nov 2019 04:37:02 +0100,
>>> Nikhil Mahale wrote:
>>>>
>>>> Document change notification HDA040-A for the Intel High Definition
>>>> Audio 1.0a specification introduces a Device Select verb for Digital
>>>> Display Pin Widgets that are multi-stream capable. This verb selects
>>>> a Device Entry that is used by subsequent Pin Widget verbs,
>>>> including the Get Connection List Entry verb.
>>>>
>>>> This patch queries the current Device Select value, associates it
>>>> with the connection list, and updates the connection list management
>>>> code to consider dev_id along with nid.
>>>
>>> I don't get why this is needed.  This is the list that is added only
>>> from snd_hda_override_conn_list(), and you don't change that call
>>> pattern, so dev_id is always zero.
>>
>> In follow-on patch "ALSA: hda - Add DP-MST support for non-acomp codecs",
>> hdmi_read_pin_conn() calls into snd_hda_set_dev_select() before
>> running into code path -
>>   
>>   snd_hda_get_connections()
>>    |-> snd_hda_get_conn_list()
>>         |-> read_and_add_raw_conns()
>>              |-> snd_hda_override_conn_list()
>>                   |-> add_conn_list()
>>
>> If I understand spec correctly, conn_list need to read/write/track
>> along with device entry set into AC_VERB_SET_DEVICE_SEL verb, right?
> 
> AFAIK, the device connection list itself is same no matter which
> device entry is.  The pin widget may choose the route per device
> entry, but the available routes should be same.

Section 7.3.3.42 of https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/high-definition-audio-multi-stream.pdf says that 'Get Connection List Entry' control should be per-device!

Thanks,
Nikhil Mahale

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
