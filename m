Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DDDE9A779
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:39:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4EF9601AC;
	Tue, 24 Mar 2026 13:39:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4EF9601AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774355975;
	bh=TJXbUnihn44RqfoPjvpLTgSUkf3KJxAxdcyFGWjHwlc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bMvtgvVNFQQ89e6FxU0fgC/jzW0C/2QTKVKzI9Vt7oty0AH2mSBbJ+R46lajDky9o
	 m44AerTm3Z4DuS39NjY0EQ9ajeRtOlFfDdjFrK3xkd7/ep+LUdpAyykzVaMQ2UYgW/
	 NomGR9Bc38CjTORB3pNKJ4EIuXnZiBru3nf4VJGs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C4F2F8060E; Tue, 24 Mar 2026 13:38:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C8B41F8060E;
	Tue, 24 Mar 2026 13:38:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BF15F805BA; Tue, 24 Mar 2026 12:25:47 +0100 (CET)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D05FF800E2
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 12:25:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D05FF800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PTNu5bR1
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a278e0f7f6so1421045e87.0
        for <alsa-devel@alsa-project.org>;
 Tue, 24 Mar 2026 04:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774351544; cv=none;
        d=google.com; s=arc-20240605;
        b=YJ3FVigw3OKyvueJIPX/7qolhO3HWSbEUbdfopLVPSzL7ocBfgpPGzuEuLPfylDWSV
         GCjic8+Ks0eceGfCUk/2n4MmOUJNp7pEJTnKX/QKf2SBpuUfGWz6rORBufuNLpp/lEpR
         PTJB2WqY7K++zN9GTQLkfO46v6HVUuIpmtx9mmZT6c0O1+zDzcCsJs9fkrgDLITQDDt/
         xMn3l8uKFYPHUEz48ts9g3q66wlGbj3duPF4LIDN7XyN72CyCdw1T04qsxe4MDvDEU1+
         tPedkt1sA3XnvlP5v3NJ+9zM/XBqYQaw84y6Q+K1+LPIKvA6y1l2JaoK450a0ulV7ge3
         3h3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zb1R9qBfAei0NZsae2BpBvqWW8bTtqel6vaBP9DiNL4=;
        fh=/CxDkEdV8qGCq5BIpKV+mC8vvZrr3fpuHNhm2vIIGCM=;
        b=M/adczFFs3ZOtTOXluuROFlvo6H6MHKQ/XzcdiFqEcloygH2i0jvAr+MKS8u918fmc
         tLIIMDgwv2HaFh4aKKVvg5bHDLhCqNKWSUBb156f6lBPDczJ2orjHYPvgpupwc9ECjCK
         I/6CKvdYXAm0u/J4tKk7Hukj50UG1yFSXMoh3JWXSrrXyNhTMtEP9NLahl0gE2VWyl8V
         P5tZ0Ytd7t4ZIZV4OBYjU3ClowGbcESMn8dz7l59aOHMOQDBS3UCbXOTP4dXFU8xCwUV
         iGjeDFUGS/7hRSj76lOA3IBR7oK3k0ia4TX/tH4okL1MzWYfXhTfnXYZx6fOouj7uuWZ
         K4dw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774351544; x=1774956344;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb1R9qBfAei0NZsae2BpBvqWW8bTtqel6vaBP9DiNL4=;
        b=PTNu5bR12epgnqkTUUQK+QZW+c63KFpwQqBqikka9CaJmajw9gunEDBUJo/O2xHf3H
         LNvq3AL5yLna1FbfGgPIX8sulbIb+w/jJVey1AB4xETPvdGfpJZbaSOyByUAy/zbdu5b
         HHYfHweqrZNj84fKRW1iRb+l6lf/ubNLdFCm695Kup/jZoxVHR8PEUnDHB2pnHKEN5ot
         Tjx9Vr9ebbKbt6lHRDuGs5PQ1ak55SasCd6Z5v2KN5tKk07O1q23zJVpSqxGhA0g1p+0
         vIdX8hF7hcNWY6LnfioFcGLlRozQQk2pGh8EXtfF3e8wpMUn00MMpO90fwNpvkdw2+tc
         oYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774351544; x=1774956344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zb1R9qBfAei0NZsae2BpBvqWW8bTtqel6vaBP9DiNL4=;
        b=QOlfeKLW3w2E6oB5qreVQmVH7Oe9hahLL6XRzAXUGM23pW6uOZTmWXj3enhwmFrKGd
         RObEvEuP/n55Lv6s7AeacZzlW5a1zscWyq2bR0wbp7GyxZrsRxaPZiPZ4EX9jJ60rMmB
         zFSW5NXgnBkyWzwe+2XZFPbdhXNQsz7TApzMonrKfcI/vlDs/tXEtLtzLloN9g4pinMV
         N6sOQAZN3j0+oK19uw513KwtYLRnCU4MBT0aY3eg712s4G4cJQY8xKeUObT43AcEtLbY
         aWTVpO+fH0f2DA761tcQTCODhrInRrjd+xnJ9g1jnR5TtRdDvxC/LEUaf0KvPrkvegGW
         6law==
X-Forwarded-Encrypted: i=1;
 AJvYcCX75U0bJzJAXxtjbpZv4yGcAf3NpD0x2afBJ9ZQqxIma3tksNJHpP3O6al9c0ffkDI4WdtsEqj48c1t@alsa-project.org
X-Gm-Message-State: AOJu0YywvnLidvLGv8ndg/KK889+8UmV4q6Va//iVwo/na94dqABKcwS
	VEiw4NwKHy0TQfxtkEmGx9EPVi2nTLyYLk8miOR9U6/hHicdQ9EYbAkLS1dcgx5bbWa5IDGTJlu
	0lv4eK0lr0mxsfFW6xE3oTel4zzVOKzs=
X-Gm-Gg: ATEYQzzONzodjxXgSE45c7EZ2dYv2IkRZqvBs1wnmGKlH9iqIf/UyY6BrXtAGgWIZz1
	7gqdCf1obb+vb5Q7F6uKIwIJ9YNsgZrEkExLcVlAm+uySwmhW9Vq5kPoggUeyQdXlA4RmMWAUcd
	eS57VV4kYt/aHIMSF2Y+XE2hh2VBJFmvMItbXMKpCnrgs4YbiKNfBusdxFf8KoquBdVqDbdifbI
	3xUg97dwHrd75i0J+aseMrsfA/+mSrUskN1VPeuJMrcKEzBgTFTKiEKQgKpMTqfMmFod0hUbXt6
	xdBxTw==
X-Received: by 2002:a05:6512:a94:b0:5a2:799b:405d with SMTP id
 2adb3069b0e04-5a285b445aemr7247953e87.27.1774351543587; Tue, 24 Mar 2026
 04:25:43 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAC5iJJZCHm8a_jP+7nQpp4aqn_EE7JmMdPJBbu83QSBjgqZ49g@mail.gmail.com>
 <40777346-28d4-456c-af4e-cb868d8b8ac5@intel.com>
In-Reply-To: <40777346-28d4-456c-af4e-cb868d8b8ac5@intel.com>
From: Robert Viren <robviren@gmail.com>
Date: Tue, 24 Mar 2026 06:25:32 -0500
X-Gm-Features: AQROBzDF1XtGIP6Vpr08S0iyqrEV8wsw00Y6JXWat23NA-Jql_jLhpgTXpWUYCQ
Message-ID: 
 <CAC5iJJbaG4boDEO6V5wOuJYiFdZauEdS47PSg-g0Gc1CrxnC4Q@mail.gmail.com>
Subject: 
 =?UTF-8?Q?Re=3A_Regression_6=2E8=E2=86=926=2E17=3A_snd=5Fsoc=5Favs_claims_HDA_de?=
	=?UTF-8?Q?vice_instead_of_snd=5Fhda=5Fintel=2C_fails_on_missing_topology_fir?=
	=?UTF-8?Q?mware?=
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: amadeuszx.slawinski@linux.intel.com, pierre-louis.bossart@linux.intel.com,
	tiwai@suse.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: robviren@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: OH3B6MCAZUSXHBZNCD25PLERLH4767WT
X-Message-ID-Hash: OH3B6MCAZUSXHBZNCD25PLERLH4767WT
X-Mailman-Approved-At: Tue, 24 Mar 2026 12:38:35 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OH3B6MCAZUSXHBZNCD25PLERLH4767WT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Found a workaround. Blacklisting snd_soc_avs restores correct
behaviour. Command outputs and bugzilla below.

cat /sys/module/snd_intel_dspcfg/parameters/dsp_driver
0

 ls /sys/firmware/acpi/tables/ | grep NHLT
NHLT

sudo cat /sys/firmware/acpi/tables/NHLT > ~/NHLT.dat (I attached it to
the bugzilla. 45 bytes)
https://bugzilla.kernel.org/show_bug.cgi?id=3D221277


On Tue, Mar 24, 2026 at 4:37=E2=80=AFAM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2026-03-24 2:48 AM, Robert Viren wrote:
> > Hardware: HP laptop (Bang & Olufsen), Conexant CX20724, Intel PCH HDA
> > (0000:00:1f.3), 13th gen Intel, linux-firmware 20240318
> >
> > Audio works fine with 6.8 kernel. 6.17 with the same modules loading
> > and identical firmware my audio fails. Result is dummy output and an
> > audible whine which drives me nuts. See logs below.
>
> Hi Robert,
>
> Typically Conexant codecs on Intel configurations aren't paired with
> interfaces which do require DSP-capable driver to function e.g.: DMIC.
> The default for configurations with no devices requiring DSP-capability
> is snd_hda_intel driver.
>
> Looks to me like an unintended consequence of some recent
> HDA-driver-selection changes. Before we move to the code though, first
> let's check the value of 'dsp_driver' provided to the selector module.
>
>         cat /sys/module/snd_intel_dspcfg/parameters/dsp_driver
>
> Please paste the result here. Then, let's see what you have in ACPI:
>
>         ls /sys/firmware/acpi/tables/ | grep NHLT
>         /* if non-empty */
>         sudo su
>         cat /sys/firmware/acpi/tables/NHLT > ~/NHLT.dat
>
> I'd suggest to open a bugzilla and attach the NHLT table there.
>
>
> Kind regards,
> Czarek
