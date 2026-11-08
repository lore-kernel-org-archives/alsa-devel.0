Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC467606A322
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=bLstGpBK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MI8BrP50
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E1E4602D9;
	Mon,  9 Nov 2026 16:05:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E1E4602D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236712;
	bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bLstGpBKThaSohDZXY4jSrrLZlz9sorKxwRxYSC4PL9flrqpCkod35BVAFuqBHCnM
	 OlioQsXi8X93AbM90pshf7tbJiq/kofUCd28+i2oE7ehLMrZkYhI+dmG4pV34XlqFb
	 CEIJG2hhn0ep+2GjNOnqQC9lnoql6UI7dvl8Nhj0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6407F80CB3; Mon,  9 Nov 2026 16:01:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 02271F80CC1;
	Mon,  9 Nov 2026 16:01:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31E21F80538; Sun,  8 Nov 2026 18:16:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794158178;
	b=YsBP9PaKgrJDUEEd6NfbHZsK+f4fxuZ/QXbjeCNgYXoTY9CWCqFJiSu3KodeEQj+TE2V
	 zGUJGf11PNeYE/pKa7J3p7T8fbs+OSSacHiR7CFwlyVgFErzTMwj/FJJloS7lRdP1QEEA
	 rJpS7Z20mYcHH/kdbwwcqkTnTSd3xyRvxsarziGPcVeOD8OXIxjrBz/3YabwwC1dfCiF6
	 UiPkmEXKUDAj24YBgTUDp/aRefL9rGYaYa7V49DM6DE2ka82lwG0SvWY8jqaQuGafgxqb
	 pX9Ut0IvoVrAeWy9rbpRd8UUoH+dtBK7Fd85G9HyVyMAUiQawxZ7HbYVapNdpk41d9w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794158178;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
	b=iJslw0PpKpG+G8NowdMooefgKAO/k/PxuzRnPixfVePoHQaO5SlW+cDc27Sl4WoBfGZp
	 5ysM+MyAy3jf9lyIml/TuIPCav2DvOCrdkGFjKmQIEAq5Hur4+bOJ3noWnwIGsbhTYUkU
	 szkSOwslXFDNU62IV2oVyhVI7liaJPA7FCUiEfkMjfm1CLfpsdoIKaAHf/QKiuASOLpvJ
	 HtGoapy8ztOitWcm9mXTZ1XeQi16aX3NERe/6f8Sx92NdW4kdX0ZWCAwjaPZ0k0KZ81ZW
	 swDG/emnZfx2w/JDkSbCxRd3ClM0kTBHIOIAD+QkbszV8qOkggQNxYQ+DPnWEOXp6Sw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=MI8BrP50;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B85FF80124
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2026 18:16:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B85FF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=MI8BrP50
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso249791eec.0
        for <alsa-devel@alsa-project.org>;
 Sun, 08 Nov 2026 09:16:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794158175; cv=none;
        d=google.com; s=arc-20260327;
        b=chX8jP1omf0z+SXNLlIW/O6j11WHkUOW2PYzyA85egSfq3GP7tl0qXsib6kGOyC9Zm
         RJpWIWXBYNgysBwJcbBrdybUvUUFzuVrvzDRB6j7RackFzODYL06GJ+M2zwxc1w59y4V
         NUeDFrt4ENWZKfB4XdP1UkRtEvHB2+viA7tLStI57hVQCje/uOz9w7WQUAg9hqbzWMEJ
         P6bCNBK9ACXyYErDUo/GW5/G6+r0Ht1bipQCRwTe/57/d3n6IpNfFBs/0lb8S2mNzuCX
         t+5UnPho6RWQHN8aARYdbyGA/PchO/WlBYv6+KuOk2Jsj/1uCQIjUXxwRedP1tBS+MtQ
         ZBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
        fh=al19yROtWeBJ15rv5q/nV5DlDiPCdo1X8oFk2RBtjxs=;
        b=rkrQfHs38Y9S+5MqRE5QTAikipD8fmCWpJZWQPbBz1u1qgVL+CyyanLna1Yy7W1Weu
         vTjARBs70IlBzgSDze2LRklqb8JUm7FPNw5kx2DVGr5EMMp6GXR7FUif+lt/3Ya2qEwj
         r6uZPZVow3lvc0nigAOUa6FCeWd6jQPjrmWznD4Gla0OTbBqfqtcHtmqV/2HFs5JsgfB
         I3Q6xGs6IwB6pU+XghG0R+n9Or3cq6AizcbLWzVesnujYmx4sJH4Qg0OOHQSDejSCEIC
         2tcye5Dj4lgz0iD7GWohzxh2ZCGjUxhTe0YfDBKDwLL2UvcO/eM/bToFLAuvh+7cEvqm
         NmxA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794158175; x=1794762975;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
        b=MI8BrP50jw1hDok8X2pfguZlB+XkB9PNU9e+AbSPnaFkGQIugaMQhOHK8ZjjqNH9we
         db+FQjoaIUg4z4RtaJzlax/SvMX3oqhp4o3wAyFytziKLw0nQAQvY2BckCxwDZLAtYqi
         Dk1W3W+TcjIwnFWYyZsC/HCRdWQ+W8+2K377CNaV7eUNaUUnVRdeG3szUUpfj9X8oJGf
         qv9lvJvACNNoyteRlPwb0JGCRK8mHy+B2ZjP/qiG4U1nM3Q4muhuc5ENXulRgaH/dyUQ
         8szjMrsfXmGAUf5y3jnHAfccXXWNSsh3/5FrnRzKgZ3Sdwjidsr5qU+L0RleHgU/6ioe
         2CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794158175; x=1794762975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elrB0jUAIbgKQ/C7FBbnNf3iANhILhG0hfcp3XkR0FQ=;
        b=iJMWs/T2dht4emWi0Q5I03EUMfw2EkfgTMnvyTj5R0xtUwjrHRcWnHHkyewK8Oof8/
         h/3JAsXE3TOot6gqNu3tF11JSuufvEemMZXqrmDfqm3HGFd6NhbGDxEl2RF5vDGDCVo2
         wG6DHOw8t7iyf1tov5dZOgH6LwKGDlrT++pFOEq60pxadbeY0Y2l7IwR6j3eu+Ehk5q1
         3KbiHiS2h2Jd2rZtRlyq0xFJqKhkh2ZU6HkwNWnDvq5rNMvcUDkzdT/xUUnTz4mAeo53
         lW7G+ZVC2kVEv3WpdKZ4nuVV/QKbVsWqvBDbQ/1wfoG33jvziaranQXmyEwkkUF9FjP9
         lAzw==
X-Forwarded-Encrypted: i=1;
 AL+hErE/kAu4groLPRfMrYVIWxoSt9xCSl+7+fX6Pw6JIXYihy8acxTi9xOrvmAwZA7N3jOqENJfNrinIKYh@alsa-project.org
X-Gm-Message-State: APuU4Z9AfSQ9q6kfz8ArPyk4/+OF2ST00v8PUtI+wYxEj9beVh8zWtYa
	UjAilQoZBdiQps4p7dcKk8AKEID4sTcqmgS41BitdyHoaJYSs9gJ51KvbowgODw4ykuMnCuIiDJ
	C+E/wwAVoaq4yIGmGmjDYlLbiHsqrlCQ=
X-Gm-Gg: AYBFou1NgxQnFiYd6am6XFGmM6C/NKVEymrQi07puW8MZ8c70BW6e9LNf7HVqQTcCjN
	dyAQqGpviLDlnVTGY+1qliCjM+93Z1MF8xIyAsXbljqxuPwcVu/lGMGsoAQisUIoRFHVADBH6z6
	+QwjyXjgE4y2sb4V+Dq+GitAalNeU1742pfmyVqkLe3Flz+MrSp6fnXlS3SI1WKrWXC/doV7AC1
	AlEuWVZLXhMi9IElHLmWmrdYojONTjRcM0vsszCTQv9O7ftn8pv9oSkY9wkVjN1JnM9wNZdPPiT
	T12W0Ik0rQWplrtH5F3gP88MkRdHMZhlynjBU8kHzOxJqDhcJ4lY/AtVS0hZtcSdT2YcPeXcqbB
	XXUedMrO2QufhhO9+joZCibm7+gpw5MMJ9SVqg0Bd/iv67pxOjNga0SXOsp3QriTmRqoatTskEO
	yRwO+BrIJStTP9ZfE=
X-Received: by 2002:a05:693c:42c6:b0:359:8492:20ff with SMTP id
 5a478bee46e88-37254d9a084mr3476444eec.12.1794158174728; Sun, 08 Nov 2026
 09:16:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107142006.3711973-1-hj351016@gmail.com>
 <4d6c1da5-bb74-4fde-9cd5-9f361da26bda@sirena.org.uk>
In-Reply-To: <4d6c1da5-bb74-4fde-9cd5-9f361da26bda@sirena.org.uk>
From: khj <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 02:16:02 +0900
X-Gm-Features: AclHuK9i40GCpnkRR0bNNPrQH8ExOtzwwehbWdVg6Fmq930oRUagKnaGTsJ4ME0
Message-ID: 
 <CAGr5VtOKK=FA_PJWvXr16r-RH426M7trfsXCXGNgPZ20ROYgVg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: twl6040: cancel jack-detect work on component
 remove
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: hj351016@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: S5YZMJ5LISTPL43YUXHNH36QXBA5TWPA
X-Message-ID-Hash: S5YZMJ5LISTPL43YUXHNH36QXBA5TWPA
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:00:53 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S5YZMJ5LISTPL43YUXHNH36QXBA5TWPA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Rebased onto current ASoC and resent as v2, thanks.

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 2:05, M=
ark Brown <broonie@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Nov 07, 2026 at 11:20:06PM +0900, hyunjungg wrote:
> > From: Hyunjung Ko <hj351016@gmail.com>
> >
> > twl6040_remove() frees the plug IRQ but does not drain the delayed
> > jack-detect work that the IRQ arms, so the work can run after the
> > component and its devm-allocated private data have been freed.
>
> This doesn't apply against current code, please check and resend.
