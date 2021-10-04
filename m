Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B8C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 09:25:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CEE61247
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 09:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99CEE61247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2A081689;
	Mon,  4 Oct 2021 11:24:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2A081689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633339505;
	bh=P5EtLPsP1wvaOD3Z0QKY/EVZy/neMoUOaGlb9SKTzjw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SE30idDTUiZLqWl4nuZD4gt5t11jGKFkbGACGkRzzJT7kpvFw/IHQtufRQs6/+3Ca
	 509AE4WKF/9hweHVjJiI2GgRNFWuLrarGzcpOiv1VNetaN9yZwlCrijREdqfVYKacY
	 sSLsXXgCsk1kYhVgQnAbnDtH7q1QAHT8OpuBKofQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 742DEF80229;
	Mon,  4 Oct 2021 11:24:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3742DF80240; Mon,  4 Oct 2021 11:24:13 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BAB9F800BA
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 11:24:03 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2740AA0040;
 Mon,  4 Oct 2021 11:24:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 2740AA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1633339443; bh=sY3O2L3vrXO32AmEuMq9aVhlmFkZNXNn7eX2GzGOwbk=;
 h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
 b=V9eZjP+sprSocM+q+fmFiGLU58/VDBt6Zbmj7NSo5iu7KrFJbZH1WaKV3GbGGoAD/
 7sJvwP6siBXfdIEvCYNszELgs7TWMF/KoHzowR29/o8o7Ux+1TkEPTfwd1SipqtKWS
 EAK/mOOoP9Ezbp3CCUFr9dIqsKUYHQsUBnOhsWpw=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  4 Oct 2021 11:24:01 +0200 (CEST)
Message-ID: <958623cd-7d0d-5329-567b-74edbbf0c16d@perex.cz>
Date: Mon, 4 Oct 2021 11:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Alsaloop: sync mode PLAYSHIFT + Loopback on playback side
Content-Language: en-US
To: Pavel Hofman <pavel.hofman@ivitera.com>
References: <a87670e2-302b-8408-cdc2-f0f010646fdc@ivitera.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <a87670e2-302b-8408-cdc2-f0f010646fdc@ivitera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>
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

On 01. 10. 21 10:35, Pavel Hofman wrote:
> Hi,
> 
> I added support for "Playback Pitch 1000000" ctl elem to UAC2 gadget
> (not submitted to USB yet) and now I am working on alsaloop support for
> this ctl elem. The changes are simple (tested to work perfectly, patch
> to follow), but during the work I hit the following issue with playback
> Loopback "PCM Rate Shift 100000".
> 
> If the snd-aloop device is on playback side (i.e. capture from soundcard
> -> Loopback), the required sync mode is PLAYSHIFT. That means Loopback
> ctl elem "PCM Rate Shift 100000" should be controlled (by a reciprocal).
> That is simple by a patch like this:
> 
> diff --git a/alsaloop/pcmjob.c b/alsaloop/pcmjob.c
> index 845ab82..619bf35 100644
> --- a/alsaloop/pcmjob.c
> +++ b/alsaloop/pcmjob.c
> @@ -1061,7 +1061,13 @@ static int set_rate_shift(struct loopback_handle
> *lhandle, double pitch)
>           int err;
> 
>           if (lhandle->ctl_rate_shift) {
> -               snd_ctl_elem_value_set_integer(lhandle->ctl_rate_shift,
> 0, pitch * 100000);
> +               long value;
> +               if (lhandle->loopback->play == lhandle)
> +                       // playback => reciprocal
> +                       value = 1/(pitch) * 100000;
> +               else
> +                       value = pitch * 100000;
> +               snd_ctl_elem_value_set_integer(lhandle->ctl_rate_shift,
> 0, value);
>                   err = snd_ctl_elem_write(lhandle->ctl,
> lhandle->ctl_rate_shift);
>           } else if (lhandle->capt_pitch) {
>                   snd_ctl_elem_value_set_integer(lhandle->capt_pitch, 0,
> (1 / pitch) * 1000000);
> @@ -1205,15 +1211,18 @@ static int openctl(struct loopback_handle
> *lhandle, int device, int subdevice)
>           int err;
> 
>           lhandle->ctl_rate_shift = NULL;
> +       // both play and capture
> +       openctl_elem(lhandle, device, subdevice, "PCM Notify",
> +                       &lhandle->ctl_notify);
> +       openctl_elem(lhandle, device, subdevice, "PCM Rate Shift 100000",
> +                       &lhandle->ctl_rate_shift);
>           if (lhandle->loopback->play == lhandle) {
> +               // play only
>                   if (lhandle->loopback->controls)
>                           goto __events;
>                   return 0;
>           }
> -       openctl_elem(lhandle, device, subdevice, "PCM Notify",
> -                       &lhandle->ctl_notify);
> -       openctl_elem(lhandle, device, subdevice, "PCM Rate Shift 100000",
> -                       &lhandle->ctl_rate_shift);
> +       // capture only
>           openctl_elem(lhandle, device, subdevice, "Capture Pitch 1000000",
>                           &lhandle->capt_pitch);
>           set_rate_shift(lhandle, 1);
> 
> 
> However, IIUC how the Loopback device works, the "PCM Rate Shift 100000"
> ctl elem applicable to device=0 on playback side is that of the capture
> side, i.e. for device=1. The patch above would pick the playback-side
> device=0 ctl elem in pcmjob.c:openctl_elem. Hard-coding the device=0 ->
> device=1 is possible, but Loopback supports more devices.
> 
> Please what solution for picking the correct "PCM Rate Shift 100000" ctl
> elem for the PLAYSHIFT sync mode would you recommend?

Hi,

I would not touch the controls associated to the capture PCM by default. It 
would be possible to add another alsaloop option and code to configure the 
rate shift control identifier separately for this use case. The user should 
avoid the double pitch control (playback + capture) for the loopback devices.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
