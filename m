Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5753C982D8
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:18:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D63B60218;
	Sun, 20 Sep 2026 17:18:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D63B60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789917529;
	bh=tTsvjAsVu+IUrgUM8bELwQCl3ECnrSL0G1/BAlHhbl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eRYutHcffBp2pZXgsGNxCL9tfr3oVkSaMvewA4A/OSHIUfRyvQAYRVprpQjZue9zg
	 4R0w0UP6ufB8ITlUGqCxsxLETZ1Y5PglRbijnr+she5+L3CppV9OBtUjlG8C94WfVD
	 o4Xz+i3Wr3qojGAcrIsqZDIMCOuceBJ0WSXMpSpI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE983F805FA; Sun, 20 Sep 2026 17:18:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5736BF805F7;
	Sun, 20 Sep 2026 17:18:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E313EF804B4; Sun, 20 Sep 2026 17:18:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789917488;
	b=TyFB7DUdP/O3pp8GTC1+6E36OGqSwMTd23e9wHf/NBhlxpJTB/crxAicKBTfzO2KsNz5
	 urmbAFtsQ5ikf0ie+l8p3iarOHpTkt/eHLzycovFEdvSTgStL7Z8uQuBXh03oAAWvDZ2l
	 RXk76WLj0DPzON8FepfGH8n0TrrZNxNCYdG7C9FHjI9nmmUL+iTMVfP8uUmwDTN33z+JK
	 4YJpUsTObZaVLBVetbMk2WWMygki9w5JNJErl14inxdMlHeNg1kWpxSOz0Sqt4bzFcZWU
	 1o1YwF/qIqECvH2d1MU0kEUvHzVq1WWX3xKWd42rBd9U5Swzf8x2IBZYYT6FEgIdAyQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789917488;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=tTsvjAsVu+IUrgUM8bELwQCl3ECnrSL0G1/BAlHhbl0=;
	b=RPzL0TlTFyKiLVKUUlziAG3vXpluxTDI/lhuGKljYsnMgnHL1SpH4kZugv2vSMkfnzQP
	 1UEJ4m2STMZKlqdNj8DC2fLlgvRNIkgkMB06adwXJHYGyaIiu030brt8Cxg4O+d2DcfEh
	 gibsRlfR3hytyLa/TUY1vgoG8tlQqjvqUvWNm0tiFs3y2E16jkGiZhXq+UEUGct8OEO74
	 DFNyeOZzWzTnjML6j7JgyV1nbGOZbF00nThwNnhv2KWfSY4hcqv05scWjwjyS3KAeQGji
	 jcm84XqEGgcWGbzJR5JP/XkjQkSeVpgLI/3WnCfyclXthalA43Y1I01GtY3jmPRHlVg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 221A8F8011B
	for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2026 17:18:06 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 0965842E00;
	Sun, 20 Sep 2026 17:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 0965842E00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1789917486; bh=lITEJIh5PI5qfWtsXZ/rtNJMYjmev/aZtvbzyPtM8B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QI8Exn5RHkRJRJlb2yoH4bsDFab6D7DfihFF/tB2YBV+MEokMPmS9HB8ClXHJs6HB
	 cVlu3qmuaNTTT2LuoTj1piSc5/lgrpZXfpqnqo81FrYxPlKCW6sLKJgrE0AA+//A3i
	 z3AAvBU5Zgjt/e8/6CplTDbYWw3iPBSw6rB5yP34=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Sun, 20 Sep 2026 17:18:02 +0200 (CEST)
Message-ID: <fe1c4c8d-1a2f-4d4b-a3e3-654b0a011f0a@perex.cz>
Date: Sun, 20 Sep 2026 17:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alsa-lib: Revert "A try to fix one rouding problem in
 refine"
To: George Matsumura <gorg@gorgnet.net>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
References: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
 <f3961c4b-3aba-46b3-844b-0fcd3ad9ce73@perex.cz>
 <20260920062458.bef6ad9e4972c868216aad0f@gorgnet.net>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <20260920062458.bef6ad9e4972c868216aad0f@gorgnet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: AR5BNFXVCHCKKJBYCKFVNOKAUWV7PD3M
X-Message-ID-Hash: AR5BNFXVCHCKKJBYCKFVNOKAUWV7PD3M
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AR5BNFXVCHCKKJBYCKFVNOKAUWV7PD3M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 9/20/26 15:24, George Matsumura wrote:
> On Sat, 19 Sep 2026 17:02:51 +0200
> Jaroslav Kysela <perex@perex.cz> wrote:
>> Can you replicate this issue with aplay (use similar stream parameters as
>> firefox)? Please, show the exact command to reproduce this.
> 
> Certainly, I apologize for not doing so in my original message. I was
> able to replicate the issue with the following aplay command, with
> parameters similar to what I believe deadbeef was using:
> 
> aplay -f float_le -r 44100 --buffer-size=8192 --period-size=1024 \
>    <testfile>.raw
> 
> The following asound.conf was used:
> 
> defaults.pcm.!card 1
> defaults.ctl.!card 1
> 
> pcm.!default {
>      type plug
>      slave {
>          pcm "dmix"
>          rate 48000
>      }
> }

Test with default dmix definition (replace 3 with card 1):

$ aplay -v -D plug:dmix:3 -f float_le -r 44100 --buffer-size=8192 --period-size=1024 /dev/zero

I've tried two USB and one Intel HDA:

   buffer_size  : 8467
   period_size  : 940
   period_time  : 21333

   buffer_size  : 8467
   period_size  : 940
   period_time  : 21333

Identical with your config:

pcm.dmixT {
     type plug
     slave {
         pcm "dmix:1"
         rate 48000
     }
}

$ aplay -v -D dmixT -f float_le -r 44100 --buffer-size=8192 --period-size=1024 /dev/zero

   buffer_size  : 8467
   period_size  : 940
   period_time  : 21333

Do you have standard dmix defaults ?

$ alsactl dump-cfg | grep -E "^defaults.pcm.dmix"
defaults.pcm.dmix.max_periods 0
defaults.pcm.dmix.channels 2
defaults.pcm.dmix.rate 48000
defaults.pcm.dmix.format unchanged
defaults.pcm.dmix.card 'defaults.pcm.card'
defaults.pcm.dmix.device 'defaults.pcm.device'

Show verbose log from aplay when working to see the period setup on the dmix side (and the used kernel driver). Also, do you use alsa-lib 1.2.16 ?

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat
