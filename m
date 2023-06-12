Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A1DC7EE2F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jun 2023 14:12:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD4B7820;
	Mon, 12 Jun 2023 16:11:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD4B7820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686579161;
	bh=MLqCDvDONNRpDjStuXzVvpI3wbROPdJptzhW8N7PV/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FmW7tIxxtoyAOsJgt3kSFEaw6CSuLjReDanrhJYxBT2UIV+4kAEHF4OAEQbbj+MXY
	 Bpp8iTybHCo7NvILRO8dqufTAbdB8GgHPcetKlIs518rF0P7gAET41lQi4Ljw32ovp
	 hU9mXjJcaxHiAVTfJvg9mvv27Sl3SlaUtH3D0jEg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A3EBF80132; Mon, 12 Jun 2023 16:11:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C6F0F800ED;
	Mon, 12 Jun 2023 16:11:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F401F80149; Mon, 12 Jun 2023 16:11:21 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 718F5F800ED
	for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2023 16:11:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 718F5F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=ZUc6sxNR
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-75d4094f9baso351015385a.1
        for <alsa-devel@alsa-project.org>;
 Mon, 12 Jun 2023 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579076; x=1689171076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJQ+L6XrHRjNmHJu0KSlBODFfH7Ghg6JGFmz6a5x+ks=;
        b=ZUc6sxNRBAQ8xbX6AppejPyNMJJ9vsAbCmSZXAXJ+9uk+Ut11Ci70gGfKeCF6IdCYT
         0Npc6f438t0uTZnI96FsJGIPUr95LlFSa7BTMGsXKqAPr/uS1Gd0FExFSCuCQESBowVo
         UHu6ECTAF+m1SBtTZXBI/1yAUv9v6izlKf+yjVPKh/IzhBhQzv27yLbTGfoSSUcGyXPy
         BwfM8c3AbVWzckrG/d9VGxLDN5Tqj8OgcS8NktKVgeIJq9GaLzTzZNSeUPep/JBkJmo9
         cxUfmKHtDmA4HfbwfbZdAkmDSCfoZPeuXwkRNY9YARnk/VloxLigmPyPw0y9qBjNCk7G
         Xhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579076; x=1689171076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJQ+L6XrHRjNmHJu0KSlBODFfH7Ghg6JGFmz6a5x+ks=;
        b=BMepTMNaYfmh7s6VD9v6q7VrIL2hGxaAXT+nd/0c5UzSZBnNtC/g8o/vKoyInS68CC
         G0LUsAIpBEuziqu08+cs+CAWAfaaoe1XDqTiA2S/dj3NdvuJD74Q5jYCmOLPGx6U1x80
         6uoxB6swuc9QdQneVbQGESgrw918swlBjF5IuYdTtDkHfYb7vJoZel6oIDs62KeygbEP
         yF0USwoC1agCa4jv0yCnu+MdcjdBv5tWgyWwe9LDt6jey4vzI9GdCCWHg6dAdPIEFfTS
         BefXJJbwrYEhrPAD7V2cSMj2v1QiWAiSEGwy45MRvNMNOGeTJ7ewZeVLAPep6fLuAk9a
         7yWQ==
X-Gm-Message-State: AC+VfDwGbKCdEFvHGz92QHMvpWQg3NaQMUuNrW38XcHY1PWh5v0ryAGa
	5sTfy1nJF1tckxgeiDehUj8634Tzcp+W2pw2ZSI=
X-Google-Smtp-Source: 
 ACHHUZ6XGswSinQMLW4VOPw+M6UjTIW5TYmForv0/8aMKQbhebyUxQ8+nfu1DnD/XddolUzFXKXLi6r/lySzLnim53A=
X-Received: by 2002:a05:6214:2268:b0:623:9218:58e5 with SMTP id
 gs8-20020a056214226800b00623921858e5mr11664934qvb.39.1686579076245; Mon, 12
 Jun 2023 07:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com>
 <20230612122926.107333-7-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-7-herve.codina@bootlin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Jun 2023 17:10:40 +0300
Message-ID: 
 <CAHp75Vf2dmAS9VD-pgyZwVopVCFy8yFjhPWEj8sym=pfE7uxSA@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] minmax: Introduce {min,max}_array()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: KSAE3LP5CIMGBF62NLFCUVWAQLOQMM6K
X-Message-ID-Hash: KSAE3LP5CIMGBF62NLFCUVWAQLOQMM6K
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KSAE3LP5CIMGBF62NLFCUVWAQLOQMM6K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Introduce min_array() (resp max_array()) in order to get the
> minimal (resp maximum) of values present in an array.

Some comments below, after addressing them,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  include/linux/minmax.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 396df1121bff..37a211f22404 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -133,6 +133,32 @@
>   */
>  #define max_t(type, x, y)      __careful_cmp((type)(x), (type)(y), >)
>
> +#define __minmax_array(op, array, len) ({                      \

Maybe it's my MUA, maybe the code contains spaces, can you switch to
TABs if it's the case?

> +       typeof(array) __array =3D (array);                        \

We have __must_be_array()

You will need to fix the inclusions in minmax.h at the same time, it needs
linux/build_bug.h (which includes compiler.h needed for __UNIQUE_ID()
and for the above mentioned one).

> +       typeof(len) __len =3D (len);                              \
> +       typeof(*__array + 0) __element =3D __array[--__len];      \

After above, this can be written as __array[0].

> +       while (__len--)                                         \
> +               __element =3D op(__element, __array[__len]);      \
> +       __element; })
> +
> +/**
> + * min_array - return minimum of values present in an array
> + * @array: array
> + * @len: array length
> + *
> + * Note that @len must not be zero (empty array).
> + */
> +#define min_array(array, len) __minmax_array(min, array, len)
> +
> +/**
> + * max_array - return maximum of values present in an array
> + * @array: array
> + * @len: array length
> + *
> + * Note that @len must not be zero (empty array).
> + */
> +#define max_array(array, len) __minmax_array(max, array, len)
> +
>  /**
>   * clamp_t - return a value clamped to a given range using a given type
>   * @type: the type of variable to use

--=20
With Best Regards,
Andy Shevchenko
