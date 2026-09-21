Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB22C982EE
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:50:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E9246018E;
	Mon, 21 Sep 2026 20:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E9246018E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790016605;
	bh=kFVVBjFA7arVqtKKHn5m7UbGVNsJaBpvFm7oCHUltqI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lk+Tri/A5iNwccdvX7FGZzeECgbtmb80bl8NNNBfi/2QYrJKnfb/LLY9emHr9g0MU
	 A9mV272FTK0WW9FmJzmnnw6slYBkL8NJWmascULjuTsfPmvlf3pXRrVJ4DXWRKXqBL
	 0S/FHiJhsokiNZFM4UBWHI8MZ7y/NtaOSFuMRuyQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D485BF800B0; Mon, 21 Sep 2026 20:49:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 08E97F805C3;
	Mon, 21 Sep 2026 20:49:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A734F804F3; Mon, 21 Sep 2026 20:49:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790016563;
	b=OL7jp445+QIDK5ZWa7p1NlUeJ7xK/xZtMG3vpcFwsMLkjf9fBcTZCBt8w7nHsVBQXwr6
	 AIxPhzkK3FALBRiV2niguPUssgzVWlJQn5Q5JuyGh7InSavRzN7+/J9nCzw5doOHujFGy
	 8GpgrGWTFAuMjdg4saP5KVI1bsNamDwTFbnnb+8q0NuPQdUoZlEvyOntC6+lPiVTgYVdq
	 Ir6j3PCyNvvCABhrcHY/ECDVvuwmubDHUAbvciAQa7bFLFyHkKFtKxkZxKI8QzRvyx22I
	 2F+sgowDLUcdN+72/+Dr8id8IOJpub7RVvq16CcXCBUBPAfJTcZ80W0fT3hFiNdLVxw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790016563;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=kFVVBjFA7arVqtKKHn5m7UbGVNsJaBpvFm7oCHUltqI=;
	b=TfB8DPipCRUmJVVbjhodmNoRg68JeAgd0TGFk4jg5ckgQLvz/N6WPIurfEhrfRW5Vl/z
	 40h9YEgIG+pZAYA9hZ4dBnS3w3lNWP98kLp2VjC/GJ81AocxBlDb14KRCRGh+uadhSXqb
	 vVry8NCbr3rU7TR11L6BtnMbm4hMrTdiB1A5A0z5rZE88x05Zxn9eSlqut8Zb8QxgNRa2
	 3gczBUST0GzWl/pmP6wCi3wwz4k0p4wzX8fO9eyGuj3X9kfUxr5C6Q47hVjfV2nME/cO7
	 CB9X8hKb+uf7AhkgcXQWylAZXq+eDmZ4EAWuEm0bhaoznkVF1l+QhBjbpJtknqt6xNw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D90E2F801F7
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 20:49:22 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 53522BAB;
	Mon, 21 Sep 2026 20:49:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 53522BAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1790016561; bh=g10Wc1e+gEZxkRLbefcqIzYMX68BDG97aCVa+wEriN0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Gqqc3EjzXmqD0dEBch8pf6YCXa4AVjG1l38nYzQC3qaJywgcCa6uwAtxScsEoWGTl
	 usw2HbSmXi0OCHFZkmsZP6ekcyE2WShTERV+pz3C2uMMwQZHrw3FKrVyihq4zaoVeQ
	 fYmWU12Ksy+BRBP1D5ktbSZGswuOF3gNzZddVeoY=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 21 Sep 2026 20:49:19 +0200 (CEST)
Message-ID: <b2b98034-918a-40c9-8b3d-1b55b38ebe39@perex.cz>
Date: Mon, 21 Sep 2026 20:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alsa-lib: Revert "A try to fix one rouding problem in
 refine"
To: George Matsumura <gorg@gorgnet.net>, alsa-devel@alsa-project.org
References: <20260919072437.ecc0cf4d5c702127dc77ac0e@gorgnet.net>
 <f3961c4b-3aba-46b3-844b-0fcd3ad9ce73@perex.cz>
 <20260920062458.bef6ad9e4972c868216aad0f@gorgnet.net>
 <fe1c4c8d-1a2f-4d4b-a3e3-654b0a011f0a@perex.cz>
 <20260920204939.62536218e5f1804d2b6f819f@gorgnet.net>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <20260920204939.62536218e5f1804d2b6f819f@gorgnet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 3EANY47WRGUMRCTZRGC3PZD3GOPH7K2D
X-Message-ID-Hash: 3EANY47WRGUMRCTZRGC3PZD3GOPH7K2D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3EANY47WRGUMRCTZRGC3PZD3GOPH7K2D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 9/21/26 05:49, George Matsumura wrote:

> I also obtain the follwing output from aplay:
> 
> $ aplay -v -D dmixT -f float_le -r 44100 --buffer-size=8192 --period-size=1024 /dev/zero
> Playing raw data '/dev/zero' : Float 32 bit Little Endian, Rate 44100 Hz, Mono
> aplay: set_params:1462: Unable to install hw params:
> ACCESS: RW_INTERLEAVED
> FORMAT: FLOAT_LE
> SUBFORMAT: STD
> SAMPLE_BITS: 32
> FRAME_BITS: 32
> CHANNELS: 1
> RATE: NONE
> PERIOD_TIME: 21000
> PERIOD_SIZE: NONE
> PERIOD_BYTES: (3704 3708)
> PERIODS: (8 9)
> BUFFER_TIME: (188979 188980)
> BUFFER_SIZE: 8334
> BUFFER_BYTES: 33336
> TICK_TIME: 0

Could you also show the output with patched alsa-lib ?

> I am indeed using alsa-lib 1.2.16. I wasn't able to find anything
> relevant in the last lines of dmesg, however, I believe I am using the
> snd_soc_sst_cht_bsw_rt5645 driver. I apologize if this is not the
> information that was requested.
> 
> Thank you again for your help with this.

It seems that the Intel SST driver may be the culprit (different constaints in 
the kernel code). Could you try to force dmix to use fixed period and buffer 
sizes ?

pcm.dmixT {
     type plug
     slave {
         pcm {
             type dmix
             ipc_key 1024
             ipc_perm 0600
             slave {
                 pcm "hw:1"
                 period_size 1024
                 buffer_size 4096
                 format "S16_LE"
                 rate 48000
             }
         }
     }
}

			Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat
