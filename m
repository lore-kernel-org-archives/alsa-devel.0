Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDF2C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:56:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE84861153
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE84861153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diwic.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17D9B168C;
	Tue, 13 Apr 2021 17:55:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17D9B168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618329380;
	bh=ylZeFo6iHKlDHxbtjWyku1Pd16gS0sPtpE62yQMeiUk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jbyFoPZkqz1VDZz0b9e9YwptM7GgGCgnR6RGNwjdnpSSNaPOGUpSPNJ/dXejHM6ak
	 3gQ2mY36JEWow1jA0gVIj+c3/3WjM8ncUDv4GjX8iAv8e2agldyWmZwQW1HWeSxaw7
	 om5TQ0Lq8ZpR7SrW8OlvgQaWN8UXaAhhzBiQIqsQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87386F8021D;
	Tue, 13 Apr 2021 17:55:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A41BF80254; Tue, 13 Apr 2021 17:55:27 +0200 (CEST)
Received: from ns4.inleed.net (mailout4.inleed.net
 [IPv6:2a0b:dc80:cafe:104::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77D12F8021D
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 17:55:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77D12F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=diwic.se header.i=@diwic.se
 header.b="VwifJ/ft"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=diwic.se;
 s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hKmYn2CZASEyzKkrO5tiY2UZuUSERg+01sRfPY8Al78=; b=VwifJ/ft6zs3znvzgek6Yv9hpD
 wcF+vcwd0VbRCC+UOYUEQzlg9neXNFeUhgozFQ+Z78ngU98ANzRQdkFRaZK5SiBw8+PhnwXzLWI8N
 LxGFlB3cDZkYU9/BbjOA+lv0Or13Ky38XFXqCXUdgNhj548vHj6LovdzWGmPLXxpDNnD75Wgddst/
 COZjdUmpCSATUXNiR3tGdQlp8goIFEKEeSsG3SI46ZGWCFynrdEQJ712z9JQrnGNMyOZeVL3ADqqL
 +Jcfu7Ity/k2AXzWO2X3HlwOCuDoXpySXEd6KUhQZPteJ0YM4iVnZ1n8RbIZ0AP5HpRpK7KNUe/oN
 5DSIDL3g==;
Received: from c83-254-143-147.bredband.comhem.se ([83.254.143.147]
 helo=[192.168.5.7]) by ns4.inleed.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <coding@diwic.se>)
 id 1lWLNn-000kys-CS; Tue, 13 Apr 2021 17:55:19 +0200
Subject: Re: [PATCH v4] sound: rawmidi: Add framing mode
To: Takashi Iwai <tiwai@suse.de>
References: <20210410120229.1172054-1-coding@diwic.se>
 <s5him4r3k1d.wl-tiwai@suse.de>
 <e912ae71-5b52-8b1f-b3fa-b9bb6420be29@diwic.se>
 <s5hy2dmw6ga.wl-tiwai@suse.de>
From: David Henningsson <coding@diwic.se>
Message-ID: <56690a06-d075-53cb-e994-2d1c8031ce5e@diwic.se>
Date: Tue, 13 Apr 2021 17:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5hy2dmw6ga.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Id: coding@diwic.se
Cc: alsa-devel@alsa-project.org
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


On 2021-04-13 17:27, Takashi Iwai wrote:
> On Mon, 12 Apr 2021 21:32:37 +0200,
> David Henningsson wrote:
>>> One thing I'm considering is how to inform the current framing and the
>>> timestamp mode to user-space.  Currently we have only the ioctl to set
>>> the values but not to inquiry.
>> Yes, this is the same as we do with PCM. There is no ioctl to get
>> current hw/sw params either.
>>
>>> Should we put those new information into the info or the status ioctl?
>> I would prefer neither, because it is not necessary and creates an
>> inconsistency with PCM.
> Well, honestly speaking, ALSA PCM API design is no best one you should
> refer to...  IMO, it should have had the symmetric get function, too.
> I guess it worked without such ioctl because the current PCM status is
> exposed via proc file.  Without a way for inquiry of the current
> status, we may have had trouble for debugging.

Whether or not the ALSA pcm/rawmidi apis should have get functions to 
get its current parameters, seems like a separate discussion, and 
separate patch. It can be done later if there is such a need.

>
> In that sense, it might make sense to extend the proc entry of the
> rawmidi status output, too.
Okay, I can add rows about framing and clock type in the proc file for v5.
>>> If so, it might be also helpful to inform the frame byte size
>>> explicitly there, instead of assuming only a constant.
>> If userspace has verified the kernel protocol version and successfully
>> calledSNDRV_RAWMIDI_IOCTL_PARAMS with the framing
>> byte/bitfield/whatever set, then userspace can be sure that the frames
>> are according to the snd_rawmidi_framing_tstamp struct. Knowing the
>> frame byte size but not knowing the exact format is of no use to
>> userspace anyway, right?
> Sure, if any, the kernel should inform all stuff, the frame type, the
> clock type, and the frame size.  But practically seen, this might be
> not often inquired, if we define the frame struct explicitly as a part
> of user-space API, too.  Then sizeof() already gives the proper size.
> Of course, that depends on how to provide the user-space API.  We may
> provide again an opaque API, too.

The frame struct will be part of the userspace and alsa-lib APIs. I 
intend to follow up with patches to alsa-lib after this patch gets merged.

// David


