Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17613C77B75
	for <alsa-devel@archiver.kernel.org>; Fri, 19 May 2023 06:23:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16C7B1F4;
	Fri, 19 May 2023 08:23:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16C7B1F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684477432;
	bh=wjbUd8BoTg5a78NIafsTenLuhWLuVKd5j207tCSwiBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TNqEBGvNHOS++HQC0GHlztD7RcqzxmFBl3PuQ4jbUlOaYg8I24Czzc3td/+l+Ug+L
	 kZcTaOyMwkHgFDJXFpEsOJuXF3NOQbKz5S5B+KVf27onxp3SgVaDPEeJuevI2fgLC5
	 WrTX6u7/r+FyI7jTWOExuyAIzm3xAZbcTTWrizxE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4DB8F80634; Fri, 19 May 2023 08:18:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35825F80619;
	Fri, 19 May 2023 08:18:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4259AF80272; Thu, 18 May 2023 16:24:11 +0200 (CEST)
Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 70DBDF8016D
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 16:24:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70DBDF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=schinagl.nl header.i=@schinagl.nl header.a=rsa-sha256
 header.s=7of9 header.b=tPxnT2Ji
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 37F0818CCD7E;
	Thu, 18 May 2023 16:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1684419843; bh=wjbUd8BoTg5a78NIafsTenLuhWLuVKd5j207tCSwiBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tPxnT2JiCSgrGJhTJF0qRA9J8kLrFnXijmNuoLRh97/z37UdGAQ/CeOnxYMm0n1sS
	 rqewOPrANwxSSUc7rpvExAucqfnTjvweU5Pz+OAevAhyQc9NW6SwuApkjC6NP0+Xmk
	 9yCr5mIc5ElU0AjvhdWpuiBF8H+APXSjT/t41Osk=
Message-ID: <d6e3b9ea-f98f-6404-e1ee-6973d68b64c1@schinagl.nl>
Date: Thu, 18 May 2023 16:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: snd_hda_codec_cirrus kernel oops
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
References: <64d95eb0-dbdb-cff8-a8b1-988dc22b24cd@schinagl.nl>
 <87zg69appu.wl-tiwai@suse.de>
 <6afd694e-8810-8197-3dd0-831daf2130f3@schinagl.nl>
 <87bkikdt66.wl-tiwai@suse.de>
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <87bkikdt66.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: oliver@schinagl.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: WCNXYDZGQ3AO4MIW6WFNJ7D26N6YXCZC
X-Message-ID-Hash: WCNXYDZGQ3AO4MIW6WFNJ7D26N6YXCZC
X-Mailman-Approved-At: Fri, 19 May 2023 06:17:35 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WCNXYDZGQ3AO4MIW6WFNJ7D26N6YXCZC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hey Takashi,

I've applied the patch you've listed below. Is there some 'fool-proof' 
way to produce _any_ output however? I've stopped pulse/pipe audio, and 
only use aplay + alsamixer. Back to basics as they say. For aplay, I use 
-D sysdefault:CARD=PCH (which was listed as a cirrus card with -L).

Alsamixer was used to ensure all volumes are open.

Without anything running, I was able to use hdajackretask to apply 
settings. But then, what to put. I get that I have to figure out, what 
is routed where (i'll try to find the schematic for the macbook pro 
12,1), but hence my question, is there some way to produce something? In 
hdajackretask I've enabled all pins, overriden them all, and set them 
all to the same configuration. 'Internal, internal, speaker, 
other-analog, green, not-present, 1, front'. I figured, by setting up 
verything to the internal speaker, I must get sound out of something, 
but alas.

I also have a Macbook pro from 1 or 2 generations earlier, 11,2 afaik, 
where the sound still does work. I've used the same config hdajackretask 
showed was in use there, but (obviously?) that didn't work.

So I'm a bit grasping at straws. Trying _every_ combination is a bit much?

Olliver

On 16-05-2023 20:31, Takashi Iwai wrote:
> On Tue, 16 May 2023 18:49:55 +0200,
> Olliver Schinagl wrote:
>>
>> Hey Takashi,
>>
>>>> [   90.497004] CPU: 3 PID: 343 Comm: modprobe Not tainted
>>>> 6.3.1-arch2-1 #1 4c16b0b90f71a940c7f1bb2eb00cdd9db2a83452
>>>> [   90.497008] Hardware name: Apple
>>>> Inc. MacBookPro12,1/Mac-E43C1C25D4880AD6, BIOS 481.0.0.0.0 01/12/2023
>>>> [   90.497010] RIP: 0010:get_line_out_pfx+0x2dd/0x3e0
>>>> [snd_hda_codec_generic]
>>>
>>> Can you try to decode which line does it hit?
>> This was the arch 'vendor' kernel, so not easily? I could have tried
>> though I suppose :)
>>
>> Instead, I just applied your patch and tried that instead.
>>
>>>
>>> Also, as a blind shot, does the patch below work around the bug?
>> [   16.593760] 0x000000000000-0x000000800000 : "BIOS"
>> [   16.603877] snd_hda_codec_cirrus hdaudioC1D0: autoconfig for
>> CS4208: line_outs=5 (0x11/0x12/0x13/0x14/0x1d) type:speaker
>> [   16.603885] snd_hda_codec_cirrus hdaudioC1D0:    speaker_outs=0
>> (0x0/0x0/0x0/0x0/0x0)
>> [   16.603888] snd_hda_codec_cirrus hdaudioC1D0:    hp_outs=1
>> (0x10/0x0/0x0/0x0/0x0)
>> [   16.603890] snd_hda_codec_cirrus hdaudioC1D0:    mono: mono_out=0x0
>> [   16.603892] snd_hda_codec_cirrus hdaudioC1D0:    dig-out=0x1e/0x21
>> [   16.603894] snd_hda_codec_cirrus hdaudioC1D0:    inputs:
>> [   16.603895] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x16
>> [   16.603897] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x15
>> [   16.603899] snd_hda_codec_cirrus hdaudioC1D0:      Mic=0x18
>> [   16.603900] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x19
>> [   16.603902] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x1a
>> [   16.603904] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x1b
>> [   16.603919] snd_hda_codec_cirrus hdaudioC1D0:      Internal Mic=0x1c
>> [   16.603921] snd_hda_codec_cirrus hdaudioC1D0:      Line=0x17
>> [   16.603922] snd_hda_codec_cirrus hdaudioC1D0:    dig-in=0x22
>> [   16.605152] snd_hda_codec_cirrus hdaudioC1D0: Too many channels in
>> get_line_out_pfx: 4
>> [   16.605215] snd_hda_codec_cirrus hdaudioC1D0: Too many channels in
>> get_line_out_pfx: 4
>>
>> the good thing, you fixed the oops; the bad thing, it's no working,
>> but hopefully this helps you gain more insight?
> 
> Below is a bit better patch for fixing the Oops.
> 
> But, judging from the output above, I guess it won't help completely,
> because the pin configuration looks broken; e.g. it reports too many
> "Internal Mic" pins (which must be only one usually).
> 
> That said, the actual breakage (except for kernel Oops) is the pin
> config set by BIOS.  Maybe it doesn't set up things properly *at all*
> You'll need to correct it by providing the full pin config with a
> quirk table.  And for that, you'll need to figure out the pins via
> trial-and-error, for example, with the help of hdajackretask.
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda: Fix Oops by 9.1 surround channel names
> 
> get_line_out_pfx() may trigger an Oops by overflowing the static array
> with more than 8 channels.  This was reported for MacBookPro 12,1 with
> Cirrus codec.
> 
> As a workaround, extend for the 9.1 channels and also fix the
> potential Oops by unifying the code paths accessing the same array
> with the proper size check.
> 
> Reported-by: Olliver Schinagl <oliver@schinagl.nl>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/64d95eb0-dbdb-cff8-a8b1-988dc22b24cd@schinagl.nl
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/hda_generic.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index fc114e522480..dbf7aa88e0e3 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -1155,8 +1155,8 @@ static bool path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_type)
>   	return path && path->ctls[ctl_type];
>   }
>   
> -static const char * const channel_name[4] = {
> -	"Front", "Surround", "CLFE", "Side"
> +static const char * const channel_name[] = {
> +	"Front", "Surround", "CLFE", "Side", "Back",
>   };
>   
>   /* give some appropriate ctl name prefix for the given line out channel */
> @@ -1182,7 +1182,7 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
>   
>   	/* multi-io channels */
>   	if (ch >= cfg->line_outs)
> -		return channel_name[ch];
> +		goto fixed_name;
>   
>   	switch (cfg->line_out_type) {
>   	case AUTO_PIN_SPEAKER_OUT:
> @@ -1234,6 +1234,7 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
>   	if (cfg->line_outs == 1 && !spec->multi_ios)
>   		return "Line Out";
>   
> + fixed_name:
>   	if (ch >= ARRAY_SIZE(channel_name)) {
>   		snd_BUG();
>   		return "PCM";
