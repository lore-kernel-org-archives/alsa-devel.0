Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43C5C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69CC6113E
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E69CC6113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA846836;
	Wed,  6 Oct 2021 19:49:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA846836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633542638;
	bh=N+1qZhspLM0mR4djYD9XOOpRwwzJU/vPWDbC5Bt0VP4=;
	h=Date:To:Subject:From:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Trmz9zf9w6Smn4eYn4FLFASw75AeMx2pL2cuTvYAakT88GPPOenT2JOnxYVMk4XJb
	 DDS7Hhg7Cb9yk6lsM4dvPTJ925MpxXqaDpuXQeZC0LkGx2Nkm1u60cN64sBy0VSxDl
	 r5rmiDiSUmmGL9bMS2978AA36Qzgva+9F+BkW/04=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AB0CF8010B;
	Wed,  6 Oct 2021 19:49:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 137FDF80240; Wed,  6 Oct 2021 19:49:33 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74E86F8020D
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 19:49:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74E86F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=mforney-org.20210112.gappssmtp.com
 header.i=@mforney-org.20210112.gappssmtp.com header.b="O64bnKH6"
Received: by mail-pl1-x632.google.com with SMTP id x8so2142217plv.8
 for <alsa-devel@alsa-project.org>; Wed, 06 Oct 2021 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mforney-org.20210112.gappssmtp.com; s=20210112;
 h=date:to:cc:subject:from:references:in-reply-to:message-id
 :user-agent:mime-version:content-transfer-encoding;
 bh=XOrLreEsAuVDxgUxU0x2eSWaOLostnJXpsKIuIcC4bY=;
 b=O64bnKH6KoKyvWVSyqsE/LKur6GdHTj0Y+7e5nyW8QRvasi2/E6oSdzxy+t0qnj4Xp
 COFS13bw8Nc/5nXiOjUWGNciFr7Q24v659AECXVa89pDdoG9I8sczFxW9ExlVQFTBEkh
 8BTS2GwYBT99RYUJSupN7so85Jx0cN11OqU1+Onri0yO/GrB8HFzSzDOa2szyKasKyl4
 HPKDu2XGcsUOMdBC9zGj1AhuHThAOyduETNOD93ZscYsX9MuzfhQ9VQNVxRCgEH/5IwE
 DIvJV2AXKyRhrRj3W6kw/1LE2dzsvDONt+mkKGh9NLuHB/cQeRodbeEv9LkTFzT1NRMq
 c/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:to:cc:subject:from:references:in-reply-to
 :message-id:user-agent:mime-version:content-transfer-encoding;
 bh=XOrLreEsAuVDxgUxU0x2eSWaOLostnJXpsKIuIcC4bY=;
 b=ptDOMYgE3yvzz/tIVFbqjzJxg9Mab+DtkBTgr6ckomQZFNc5SaLtCwjuLV3hRIkdRs
 9BI5LWncfl8VbWG7l5qQb7Ma5As7LsoVr0F0Zt7nDUqUmoD2Oqo/28oPTBe2SSuopOvZ
 675/uFmb9d6b0KMp6nyrnsqJpTc5b9789vweZ/am1e7mmpLDxTfbK395bXanVraKRm0C
 IbwxEZFs9EEUwEFBJ2SoaLZ9e5QDBrM27hM9vH09mNPUMubCwwmQ7Pa3VESxUTr4HZK9
 4Ze7uIlEWiWjMK4Fqx54ai+EmXNKjjk3tEtXL/sTCjckRXcPaYxkvXDvcr+eHtk2et8y
 UKqQ==
X-Gm-Message-State: AOAM530rpZrJ7fjmp5n/81wmvE52ZUqS55VXbzRCBXyLgsWwd0lABi/6
 eFUkxuoRpoCAazU0cLHw4FI0Kg==
X-Google-Smtp-Source: ABdhPJz5bzd0Ll3u46SkBJss+W4S4Nr59Wl1BFpeQCxvVpqg12wwq7XaF2OPnMoJnGmqYHr4xnQO4Q==
X-Received: by 2002:a17:90a:ac0d:: with SMTP id o13mr86949pjq.74.1633542558298; 
 Wed, 06 Oct 2021 10:49:18 -0700 (PDT)
Received: from localhost ([98.45.152.168])
 by smtp.gmail.com with ESMTPSA id z10sm20718583pfn.70.2021.10.06.10.49.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Oct 2021 10:49:18 -0700 (PDT)
Date: Wed, 06 Oct 2021 10:49:17 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit layout for
 snd_pcm_mmap_status/control
From: Michael Forney <mforney@mforney.org>
References: <20191211212025.1981822-1-arnd@arndb.de>
 <20191211212025.1981822-9-arnd@arndb.de>
In-Reply-To: <20191211212025.1981822-9-arnd@arndb.de>
Message-Id: <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org>
User-Agent: mblaze/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, Baolin Wang <baolin.wang@linaro.org>,
 y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
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

Arnd Bergmann <arnd@arndb.de> wrote:
> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER =3D=3D __BIG_ENDIAN : defined(_=
_BIG_ENDIAN)
> +typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_=
t)];
> +typedef char __pad_after_uframe[0];
> +#endif
> +
> +#if defined(__BYTE_ORDER) ? __BYTE_ORDER =3D=3D __LITTLE_ENDIAN : define=
d(__LITTLE_ENDIAN)
> +typedef char __pad_before_uframe[0];
> +typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t=
)];
> +#endif
> +
> +struct __snd_pcm_mmap_status64 {
> +	__s32 state;			/* RO: state - SNDRV_PCM_STATE_XXXX */
> +	__u32 pad1;			/* Needed for 64 bit alignment */
> +	__pad_before_uframe __pad1;
> +	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
> +	__pad_after_uframe __pad2;
> +	struct __snd_timespec64 tstamp;	/* Timestamp */
> +	__s32 suspended_state;		/* RO: suspended stream state */
> +	__u32 pad3;			/* Needed for 64 bit alignment */
> +	struct __snd_timespec64 audio_tstamp; /* sample counter or wall clock *=
/
> +};
> +
> +struct __snd_pcm_mmap_control64 {
> +	__pad_before_uframe __pad1;
> +	snd_pcm_uframes_t appl_ptr;	 /* RW: appl ptr (0...boundary-1) */
> +	__pad_before_uframe __pad2;

I was looking through this header and happened to notice that this
padding is wrong. I believe it should be __pad_after_uframe here.

I'm not sure of the implications of this typo, but I suspect it
breaks something on 32-bit systems with 64-bit time (regardless of
the endianness, since it changes the offset of avail_min).

> +
> +	__pad_before_uframe __pad3;
> +	snd_pcm_uframes_t  avail_min;	 /* RW: min available frames for wakeup *=
/
> +	__pad_after_uframe __pad4;
> +};
