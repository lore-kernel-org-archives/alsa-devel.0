Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF456C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:02:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40020206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fO10hZ0s";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="0fx0mz6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40020206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 880CA15E2;
	Mon,  8 Jun 2020 11:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 880CA15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591606969;
	bh=XKWFSSGnwR1CgOSlBUWYut41peNya2hNQMtcTtXdAP4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fO10hZ0sudoORj6fsXjp2GPlcOM+r7xb3Q7JPKAVI0J6eul5GId4e+Kax48eKNPSc
	 55JmsNcV/iMbWPfHo24oC0V789UoG6/jliGQq1E2re8RDCRemisqML1Cki1idQ1VOh
	 Ah2+ZcU9KyJtYaS0R6dUQ34kj/71IyK5WKSLvdSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C446F801F7;
	Mon,  8 Jun 2020 11:01:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47C64F8021C; Mon,  8 Jun 2020 11:01:57 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19BD5F801EB
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 11:01:49 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id F15D0A0040;
 Mon,  8 Jun 2020 11:01:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz F15D0A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591606907; bh=LKmyL3YnjjJwwq30wVcqNvgXwb27s3WEaF18TIeFM/k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=0fx0mz6IyqJ2JZ7Aw1blPeoCe6JjgU2tSO/TmZCHEkTLjpzwYBXncD0IQY3fzKgZw
 3KMVvuBJREyCQl8VmzU2xBvWKO1UjeZjE0Jl36TmHqzB8IGe7OTFod7P43tscxSKlr
 OViY9dKZbuiltQr3rRDxXzP2+5GFKPqf6nHNBxao=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  8 Jun 2020 11:01:43 +0200 (CEST)
Subject: Re: [PATCH] ALSA: usb-audio: Use the new macro for HP Dock rename
 quirks
To: Takashi Iwai <tiwai@suse.de>
References: <20200608071513.570-1-tiwai@suse.de>
 <3d4e9e2f-eec9-8018-7964-c09ab81c1240@perex.cz>
 <s5hd06a54mi.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <0b36a395-0bf3-c853-1640-6356a01e2200@perex.cz>
Date: Mon, 8 Jun 2020 11:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <s5hd06a54mi.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
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

Dne 08. 06. 20 v 10:44 Takashi Iwai napsal(a):
> On Mon, 08 Jun 2020 10:37:12 +0200,
> Jaroslav Kysela wrote:
>>
>> Dne 08. 06. 20 v 9:15 Takashi Iwai napsal(a):
>>> Replace the open-code with the new QUIRK_DEVICE_PROFILE() macro for
>>> simplicity.
>>>
>>> Fixes: 0c5086f56999 ("ALSA: usb-audio: Add vendor, product and profile name for HP Thunderbolt Dock")
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>
>> Takashi, could we export the profile (hint) for new USB cards via the
>> components string - snd_component_add()? The long name seems not
>> appropriate for this. It's a GUI string (which is mangled now).
> 
> It's possible, and maybe we should move to it, but we'd need to
> provide in card->longname for now because the component support in
> user-space side isn't in major releases yet.  The longname is ugly,
> but that's the only way that works stably right now.
> 
> Also, we need a common helper function for adding the component string
> in the kernel side, too, not specific to USB-audio.

There is already snd_component_add() function, so we need to settle only the 
identification prefix for those "model" strings.

It would be nice to duplicate this info for the moment (the components string 
should be shorter than used for long name).

Perhaps, we can just add "hw:<hint>" component string for the more finer 
hardware identification, like:

$ amixer -c 0 info
Components	: 'USB0bda:58fe hw:VideoMic'
	
				Jaroslav

> 
> 
> thanks,
> 
> Takashi
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
