Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0651AC76196
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Apr 2023 17:58:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5038200;
	Mon,  3 Apr 2023 19:57:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5038200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680544681;
	bh=DLuFtoPaZQl73JHxHRls1GzKFjaRw2hqYG9t/UIk9fE=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SjRD1KOrxh1VVpdGW0fZcKCvuz3HKTjNQAAvk9jlL8PNo0Dp2xZmdhqQCl4oh6joM
	 JD5bSFovCD8PU2RLZYxVXOMGQZ04dwLIBGE9ir83287EJin1Qik+7UG0l7fbyPED5e
	 buASmXeavDR3wvtv4jOko/PB0nLsuMfJW3kVX1d8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66F18F8024C;
	Mon,  3 Apr 2023 19:56:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9076BF8024C; Mon,  3 Apr 2023 19:56:45 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9402FF801C0
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2023 19:56:39 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4D998405;
	Mon,  3 Apr 2023 19:56:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4D998405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1680544598; bh=tpMEulEkoc3FOi2DImVnMHx1bdiGR4JR134PVjzfR3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GLlzGmikUhJfIGcqCgop4LoKS/mN26TCz9hEv+YJn/zCE1BTPENT1j3hP2NrhMEzm
	 2XXOrIxE2dzOMEAndZseO/35rhwxgVkaZVxajCXDMbkSJeWAbCQeTLtpH6X5CJ6jr1
	 kKGti1r+cMrNL+QAAHHVnM2nA5/xUD6kMRZkvGjk=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon,  3 Apr 2023 19:56:34 +0200 (CEST)
Message-ID: <7919429d-655f-9202-a5ba-69b48b102bc2@perex.cz>
Date: Mon, 3 Apr 2023 19:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ALSA: hda/hdmi: Preserve the previous PCM device upon
 re-enablement
Content-Language: en-US
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
References: <20230331142217.19791-1-tiwai@suse.de>
 <57ffa8e0-83fa-a982-9f48-abbe5f098732@perex.cz> <87v8ihhr9x.wl-tiwai@suse.de>
 <alpine.DEB.2.22.394.2304031737010.3532114@eliteleevi.tm.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: 
 <alpine.DEB.2.22.394.2304031737010.3532114@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: NUDOP66TPRRTZMZRV4IG6B2FPZFKDM2Y
X-Message-ID-Hash: NUDOP66TPRRTZMZRV4IG6B2FPZFKDM2Y
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Alsa-devel <alsa-devel@alsa-project.org>,
 Wim Taymans <wim.taymans@gmail.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NUDOP66TPRRTZMZRV4IG6B2FPZFKDM2Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 03. 04. 23 18:09, Kai Vehmanen wrote:
> Hi,
> 
> On Fri, 31 Mar 2023, Takashi Iwai wrote:
> 
>> On Fri, 31 Mar 2023 17:18:44 +0200, Jaroslav Kysela wrote:
>> That said, the slot preservation becomes effective only when multiple
>> devices are connected and they are on/off at the same time.  In such a
>> case, the device order may be changed at each screen on/off with the
>> current code, while this patch allows keeping the order.  Maybe I
>> should emphasize about the multiple devices in the patch description.
> 
> ... and specifically you need multiple audio enabled displays to have
> this problem.
> 
> Anyways, even if a bit hacky, I think the patch is ok and helps with the
> user-experience in these cases. And if application correctly checks the
> ELD after each jack connection event, those applicatios will continue to
> work (so this patch does not encourage bad app behaviour).
> 
> I think this still leaves (rare but possible) cases that need to be
> handled by application. E.g. if you have multiple (audio enabled) displays
> connected to a DP-MST dock and the monitors get turned on/off at the same
> time, it is possible for them to appear with different DP-MST ids (depends
> on the dock). I.e. the PCM may change. For these cases, the application
> would have to look up the correct display/receiver (the user wants to
> stream to) via ELD, every time there's jack connection event.

The question is, if ELD contains a serial number of the monitor. If there is 
no unique identification for similar monitors (one model), then we have no way 
to identify the audio devices properly.

If I look to drm_edid_to_eld() function in drivers/gpu/drm/drm_edid.c I don't 
see any unique information to be copied for the identical monitors.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

