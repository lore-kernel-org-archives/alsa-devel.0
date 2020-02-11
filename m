Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB5C352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E9224686
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DoDYyAL3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="NN8HG1D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9224686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7822186E;
	Tue, 11 Feb 2020 14:56:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7822186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581429469;
	bh=dz/byLQo9TjXxAvv7tDuUNAiww1CwBWHMOCH3IL8P4o=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DoDYyAL3CBxwJYgSb0E5+M7oh42kuQHFtA9rFJmvPxsuJ9a21ylAMvxnAHxHsu1uq
	 +62JLmHRYFx/eWFcfpxGtpeIRkzhWHkf+GbeR/ufSFgwG8zoYLGKSZyo3g9aQ4YVEZ
	 4N3NdXLqFDYRcHLXcVamHeG2zAsr1uK8p46Vkz80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B704F8013D;
	Tue, 11 Feb 2020 14:56:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C418F8013E; Tue, 11 Feb 2020 14:56:58 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9820AF800E7
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 14:56:54 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7D989A003F;
 Tue, 11 Feb 2020 14:56:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7D989A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1581429414; bh=0Efa0Tgr98zcPceZ4tbN4DZiSyq5I8m4PkCL59yHp3o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=NN8HG1D2L/3gEJ/meRsyWd/7KBVTrXmjMaIcYTXyVfkFDnO1MS8+732vArByas6dR
 Bl4sYldTseqMeA2YjD2Rh6QswFfDPRFCeNicytb4Kk3DCLIzAco8ygmmrPNgac1SFj
 zkkTGQrTt5PtbL120pT1SlmEEAx7V2OHqecum6+g=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 11 Feb 2020 14:56:49 +0100 (CET)
To: Benjamin Poirier <benjamin.poirier@gmail.com>
References: <20200211055651.4405-1-benjamin.poirier@gmail.com>
 <20200211055651.4405-2-benjamin.poirier@gmail.com>
 <b23abac0-401c-9472-320c-4e9d7eab26de@perex.cz> <20200211081604.GA8286@f3>
 <901c395a-7fb5-5672-5955-d6d211824177@perex.cz> <20200211114236.GA2691@f3>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <1274df6a-010c-0e84-d916-f59c36ae3993@perex.cz>
Date: Tue, 11 Feb 2020 14:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211114236.GA2691@f3>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo
 Thinkpad X1 Carbon 7th quirk value
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 11. 02. 20 v 12:42 Benjamin Poirier napsal(a):
> On 2020/02/11 10:35 +0100, Jaroslav Kysela wrote:
>> Dne 11. 02. 20 v 9:16 Benjamin Poirier napsal(a):
> [...]
>>>>
>>>> Why PA handles the rear volume control with the current driver code in the
>>>> legacy ALSA driver? It should be handled like standard stereo device. I'll
>>>> check.
>>>
>>> The device comes up with "Analog Stereo Output" profile by default. I
>>> changed it to "Analog Surround 4.0 Output" to test controlling each
>>> channel individually:
>>
>> Yes, but does the volume control work (does PA change the appropriate ALSA
>> mixer volume)? Sometimes, it's difficult to see the difference between soft
>> volume attenuation and the hardware volume control.
> 
> I see what you mean.
> When set to the "Analog Surround 4.0 Output", pulseaudio didn't change
> the "Bass Speaker" mixer (always at 0dB gain). It used a combination of
> Master, Front and sometimes PCM mixers to control all four speakers.

Yes, that was the reason to keep only one volume control in the driver until 
we have a solution for this.

> For example:
> pacmd list-sinks
> 	name: <alsa_output.pci-0000_00_1f.3.analog-surround-40>
> 	volume: front-left: 10349 /  16% / -48.09 dB,   front-right:
> 	39377 /  60% / -13.27 dB,   rear-left: 23979 /  37% / -26.20 dB,
> 	rear-right: 47974 /  73% / -8.13 dB
>                  balance 0.61
> alsactl -f /tmp/output store 0
> 		iface MIXER
> 		name 'Front Playback Volume'
> 		value.0 33
> 		value.1 79
> 			range '0 - 87'
> 
> 		name 'Bass Speaker Playback Volume'
> 		value.0 87
> 		value.1 87
> 			range '0 - 87'
> 
> 		name 'Master Playback Volume'
> 		value 77
> 			range '0 - 87'
> 
> 		name 'PCM Playback Volume'
> 		value.0 255
> 		value.1 255
> 			range '0 - 255'
> 
>>>>
>>>> You should also test PA with UCM.
>>>
>>> Please let me know what do I need to test exactly? I'm not familiar with
>>> UCM.
>>
>> Just install the latest pulseaudio (latest from repo), alsa-lib and
>> alsa-ucm-conf (also from repo). If pulseaudio detects UCM, it has the
>> preference.
> 
> Using the packages in debian unstable, `pacmd list` shows "use_ucm=yes".
> alsa-ucm-conf was already installed. Hopefully that's enough.
> 
> ii  alsa-ucm-conf    1.2.1.2-2    all          ALSA Use Case Manager configuration files
> ii  libasound2:amd64 1.2.1.2-2    amd64        shared library for ALSA applications
> ii  pulseaudio       13.0-5       amd64        PulseAudio sound server

You should use the latest code. I will release ALSA packages version 1.2.2 
soon, but PA must be latest (not yet released 14.0). Previous versions do not 
handle the volume control and HDMI jack detection. There are many UCM changes 
in 14.0.

						Jaroslav

> 
> pacmd list
>          name: <module-alsa-card>
> 	argument: <device_id="0" name="pci-0000_00_1f.3"
> 	card_name="alsa_card.pci-0000_00_1f.3" namereg_fail=false
> 	tsched=yes fixed_latency_range=no ignore_dB=no
> 	deferred_volume=yes use_ucm=yes avoid_resampling=no
> 	card_properties="module-udev-detect.discovered=1">
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
