Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FC606A31E
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Oz/tSE0W;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jEdcZSeb
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 852B460221;
	Mon, 23 Nov 2026 13:05:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 852B460221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435528;
	bh=uvjQd3ds9Vt0B3alY516NmxLgEQKBdRvpw6p54uyre8=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Oz/tSE0WtceUAsAuvFyy7X0ogBiDWaKDjDWp6FIMl24IDUTInjmSBod7JCmK4aGRC
	 jHT6vjVogfhkBMNskRUMLjYoREShkhw2I+H2nyK4bs8+z06Rmx2OL4gMJWt86uXlFE
	 yRrhF7CI8NPje+0LXuCbuH5TmI5o5ht0HhsJuKJk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDA05F8075A; Mon, 23 Nov 2026 13:02:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C07B2F8074E;
	Mon, 23 Nov 2026 13:02:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 451BAF80537; Sat, 21 Nov 2026 23:07:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1795298842;
	b=CQrAewc6WiJfYXr58AA3pnhcVfQEra6qi7Q8EZschbsDhT5o9zFWzQKCzTZnHwHu8FfN
	 Qv2Xvnjd+WuUmZCgGJLfMmYZ4HZ1Im/DSJpwfl8lPXmqoNGRrL3SgfUnr8qwwSlqDYzVr
	 Rh1bEmGsYl0JG7LbqsJprtZVQXq194/U/VUzyzMaQQtvP3byu14rxsV4aSPeIX1/6QcFE
	 ZqW/+zDk0cJpf51DVquUuG4n/UiUS1pxD+hW1qphBtJLtoQXRHdRNg4ZzDwHQujmH3KEA
	 6a34mbFDkcBdPOL4F6QB1KKaAORcrp35g2aWiti/OIHnY22DLa2BnrkWlympaNS0eIg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795298842;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=2fShHxtlXCizvC4GzlH7pkR3lDPHjjitwoA/N85kjd4=;
	b=aNgtsq3AokN1VlDLssZLSjtvbKl6UrdJfoEAIMkDrzJYuzKumNoieRCQICoagmuNNabl
	 nbKEWTG5PPFfQYjYD+BIHbTogrSwPrnlpbTXnjYPRkPtvbdMbHS5ZTN6pKVShhTUqrMKa
	 d3YS+TH3rFGrzgQNDXX9sFU5O+k6cFujTzxxstJJsXsgp5mf5UcQ24pO9SEhVAWvwF5Mb
	 9ZVLycJf+hO3Y5y5rBILEUVIMqWEyD+qETvXwlYOarMcWeMl2T4Yoq5OrJBafz+Vvlw34
	 o9cEx1pYrPEk4ayKb0AFRKGeCBPQgFeu4OTgISFRqb080TBYLWvDLjGcFmQnYlshi8g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jEdcZSeb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E3CD2F800C1
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2026 23:07:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3CD2F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jEdcZSeb
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6b87a1a2babso6177321a12.0
        for <alsa-devel@alsa-project.org>;
 Sat, 21 Nov 2026 14:07:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795298840; cv=none;
        d=google.com; s=arc-20260327;
        b=lJVLAe+Hujerspo1nVFcQ0tf0ZORxzF3T0oN78ONuSlCDdvgc2BoioSXf+7DTV0tZX
         Fj3r7GHjGiYD/9sotmk4TGsOI4RgdRfAt+iAADrTTFL4V4j7QqPcVCJ8lUBTRNF+gMRs
         UmbNC49/GXst6q22NlsrCDbPo1Re9j7VIZP4uo+tjH4ohbX6QCcHGuxUXLvHESjENkRu
         eizuEU74j0cT1tTnRG15gPrmR4jGFJ0PkQhQ7cJ2+oFnZbTtlXMYw0ECn3nT/koPxkL4
         aDr28Mhn39BgAOfFJevPcJCvYET6wRniji2T3y6slq4IRj32KmiubNRIMj9pP/+ixeGy
         HUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=2fShHxtlXCizvC4GzlH7pkR3lDPHjjitwoA/N85kjd4=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=HQriymQj3pb3e6MZJjxaOlHiaeE/zTEkqX2wGXm9qT1Jdps05coRmrGmaUSGZs6/Lx
         ciw/F7gUnjGPZEVEuyF4jRllO0s4gFfY/GC/N7zXbzrm1DacgFCvv1OOP2XuTMgTL/n9
         Qu9JpujPZ9NBOTUHFf99ktAU6uOPHTpdUbi8W6N5Atd5MlbOZwCM2uxWtHPTBnnIGutY
         DwgWH5ABc182dsPB+wzB1Bt/8G9OKCuZNnn+Rb76DsrOwZC5UkwcVPAQ3+nkiNRY307C
         1NWghYLVsSYguDJO/uzXEvWjX1CZHID7ic9WJbfnMQs+uC0+lOJ2jJyE8OoJmognKJrH
         U4Uw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795298840; x=1795903640;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fShHxtlXCizvC4GzlH7pkR3lDPHjjitwoA/N85kjd4=;
        b=jEdcZSeb/aTNatFd4Y1qO7hsCHsvPzheztZPy88LmZX/GlvLmrdARRpMcfoT0XaGnA
         hjSF5M4IRiFcITgMkQ5+jvQXIuYQ5gM+vcNtDJAwkLtHmMDYOQEj+D7DXsoz+4z0MES4
         o2GZI/35tWvAua1NDcEZnvufk1WebpBQCjm/57CjEPHL27vlyNQUHqrlTnDb1+i+CH3q
         30fnBFbFJ/Bzh/hYF8klLFecsmsXtLDpldvoEICq2m4G/bxeipQsZoujfCB8147q5Eik
         QzxJq7PJp4Htv8TLm0PaFWzHXsaAVhh5uNBzzxB4To6D8vxaYr8qTW2tjd5Ot+qY3Yc4
         a5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795298840; x=1795903640;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fShHxtlXCizvC4GzlH7pkR3lDPHjjitwoA/N85kjd4=;
        b=bfb0Qssfj7SF5JccL1SDV5OhGboJrRJ/+1Ap9IsyTvNmM2KO/cj113JbRN2WMSVChJ
         bi+rNqGWPrzkKfVwr5VnQ/VrsSDIuYTlX0+mRaDmv1O9KZVkjTv3SlNh3m7d7jV5cQyg
         eJHDYhNIPYpZ2YiIcU/O0gygK2ugJ2llEC/IscaWimvkWxrgqQV9gMHoy7e/RUkj6W8N
         Xnltgi5Ro3aMKE4rmnOQhr37Fyqlgfy//OZnEXXwzlWe6URfS6olcj++xLN8X5ih0j/4
         7rNTN9tGkJcrqSLa6S8VhuJ6BjFyyGmQQUaeprJNSdmqhCQw8hoaSNs9Wx25Mp/V47+o
         DTlA==
X-Gm-Message-State: APuU4Z/AcRiARcCkERGYJPU9MZoqWxZNV39MppRfE0QSuC1OEWYanRh9
	EV+d2Orh3DYp9eTIEo94MXy8pj1jthVRdv2YOJfx4lv5nuFk+DUDVLDYpKXTi7EfmYuaPiZT+eE
	Ase/YULmYzOa7EpgHaKSjip3EUe4xzdeOwz9r
X-Gm-Gg: AZFdTZf7V5TdT9rhyxBkKe4dEANJBUSSXjiLRDg1CzjET9B5B/qNUkXRW5+u+bhUX09
	jgk6Rif+oXHTDcgSVMndZvSrGRtQoiIOvkrYjGV9kaOltvrRzBE7mEuUFO8VcwpsocfW5Z2rhSb
	4EMcO3JX0f6pw6OnNVuNbUDf8BKqUYeilYX9UesMEbQlWGAw7Q7PZAT21G0Z1gOeyMRatQ2UUvV
	NgSVHFidhLPHR8kOfja1LDmK/wgRvv3nPleYrk46S7ef4r2Z56XdMaV2aT8nt305zvPr7/+S9kE
	oIgABa6Kc2Xebuuj2tHHfUwSOhSjF1LmBdOk5fmeJm+UrPy5MP4KWib3LIhNxyuJjx2Q2guiklR
	mPDiMGFZQPm38Mqvoc/nUyfD0pbHEiGx+HV9boEI=
X-Received: by 2002:aa7:cd75:0:b0:6b7:c855:f2ff with SMTP id
 4fb4d7f45d1cf-6ba1f76f950mr5152445a12.2.1795298839800; Sat, 21 Nov 2026
 14:07:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: 
 <CAMiH3bUnzv0L3omU_TTFrAZ3gRf2FYoESk+to8uZG77vpFw7-A@mail.gmail.com>
In-Reply-To: 
 <CAMiH3bUnzv0L3omU_TTFrAZ3gRf2FYoESk+to8uZG77vpFw7-A@mail.gmail.com>
From: Bhagavatiprasad Vaghela <hello.bhagavati@gmail.com>
Date: Sun, 22 Nov 2026 02:07:07 +0400
X-Gm-Features: Aa3M54q9zPPw7JeeTFCJWHozHZzJOXH-3-2mv7C-r7KyPXsCvFh-UhEl5sg0qP0
Message-ID: 
 <CAMiH3bVfkRYeQpC_75z_iix6LeGcXAM2-cSB011=SzL7uchTVw@mail.gmail.com>
Subject: Re: [BUG] sof-essx8336 / es8326: internal speaker very quiet on
 Infinix INBOOK X1 NEO (Jasper Lake)
To: alsa-devel@alsa-project.org
Content-Type: multipart/mixed; boundary="0000000000009d02460660d095ba"
X-MailFrom: hello.bhagavati@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DY4SMW4KTQWYDF6BI3CZWFZ5WAZHZCWF
X-Message-ID-Hash: DY4SMW4KTQWYDF6BI3CZWFZ5WAZHZCWF
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:15 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DY4SMW4KTQWYDF6BI3CZWFZ5WAZHZCWF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

--0000000000009d02460660d095ba
Content-Type: text/plain; charset="UTF-8"

here is output. please let me know if anything further is needed.

thanks and regards

you can directly call me on whatsapp +230 59427474.

On Sun, 22 Nov 2026 at 02:02, Bhagavatiprasad Vaghela <
hello.bhagavati@gmail.com> wrote:

> Hello,
>
> I am reporting a very quiet internal speaker on an Infinix INBOOK X1 NEO
> laptop (Intel Celeron N5100, Jasper Lake) running Debian 13 with kernel
> 6.12.115. I would be grateful for any pointers on what to test.
>
> Hardware
> - Laptop: Infinix INBOOK X1 NEO (model XL22), BIOS from AMI Aptio
> - Audio: sof-essx8336 machine driver with snd_soc_es8326 codec, SOF
> firmware package firmware-sof-signed 2025.01-1
> - ACPI device: ESSX8326:00 on I2C
> - Kernel quirk mask reported by the driver: 0x1 (SSP1), no other quirks
>
> Symptom
> - The internal speaker plays but is very quiet.
> - The headphone jack and Bluetooth audio work normally.
> - The behaviour is the same on a Debian 13 live USB.
> - [Windows on the same laptop: speaker is loud / normal. Please fill in.]
>
> What I checked
> - With the jack empty: Headphone Jack = off, Speaker switch = on,
> Headphone switch = off, and the speakers-enable GPIO changes correctly
> between plugged and unplugged states.
> - All mixer controls are at maximum (SPKL, SPKR, HPL, DAC at 0 dB) and the
> PipeWire volume is 100%.
> - Disabling ACPI D3Cold in the BIOS fixed my touchpad but did not change
> the speaker volume.
> - [Other tests: power drain, HPVol SPKVol options, quirk values, older
> kernels. Please fill in.]
>
> I have collected the full details (DMI, dmesg audio lines, all mixer
> controls, the ES8326 register dump, the ACPI/DSDT block for the audio
> device, alsa-info) here: [link to your uploaded audio-report.tar.gz or
> gist].
>
> Please tell me if you need anything else, for example a register dump
> taken under a different state or a test kernel. I am happy to run tests.
>
> Thank you,
> Bhagavatiprasad Vaghela
> hello.bhagavati@gmail.com
>

--0000000000009d02460660d095ba
Content-Type: application/gzip; name="audio-report.tar.gz"
Content-Disposition: attachment; filename="audio-report.tar.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_mwqyi57o0>
X-Attachment-Id: f_mwqyi57o0

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
--0000000000009d02460660d095ba--
