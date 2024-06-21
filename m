Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A416C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:27:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69FFB238A;
	Mon,  1 Jul 2024 14:27:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69FFB238A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719836858;
	bh=5CsIqk65T8h28pv7LSZHK/r+thMfNFgpmh7VKRl0UWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=USMa81nDAljV4kv4ndhoRJ4f7vUVmbaDif2S9nNGA1+qAyDrpkjH6+xvlHx2/fXLn
	 LQdJg5LMHfXszUpeRk/6Qj3nnMkQ3K2sPs8Uu2kv3yp2fwXAJLTXAGSqgcl5WVC7oz
	 6kIKBlK+lGmvidMSanNEEE0KTtPrWlsnTBUjY9CM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE71EF80652; Mon,  1 Jul 2024 14:21:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F33D0F897AB;
	Mon,  1 Jul 2024 14:21:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24360F8023A; Fri, 21 Jun 2024 14:08:26 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1620BF800ED
	for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2024 14:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1620BF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=timesys-com.20230601.gappssmtp.com
 header.i=@timesys-com.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=Bqf7ypg5
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b50c3aeb83so7889456d6.1
        for <alsa-devel@alsa-project.org>;
 Fri, 21 Jun 2024 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718971694;
 x=1719576494; darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CsIqk65T8h28pv7LSZHK/r+thMfNFgpmh7VKRl0UWQ=;
        b=Bqf7ypg52imJQa0M5Ya+p6Yu9SwFt/K2ZsCuEe3TPeXqKJivRlKG0G9pKEIHqY7hXQ
         1JdiBHPFWArdCwi3zxW3G0GQFXgLLvNz0VZGqf/Jt45QFj2tUV6ZCGkXXU7EvFIPf8Kb
         HqNbkD+twpZmF0gO+jDfU7yE/NwzHapUpos6bbJea+wGH25OH/5ikH9dYwOhbXSp4R1k
         Zunq0vayvKAFDtQwyqX7IRv5D6MFVMdRVhIIr/55SeInIPH41S95nErmJpO7Ycp3IXVw
         8GRb5rpA0YjbzKftiSAVj3aSnnQqdHF71DLvtbPghhvs5GMn0QCacthqy9IBpkpouXkr
         kj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971694; x=1719576494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CsIqk65T8h28pv7LSZHK/r+thMfNFgpmh7VKRl0UWQ=;
        b=nqSPUN9JqZYNWDCS7EGdHvYot8VEpNq6O8A0QSXrQgLZ5no8BFqwLV2PNoP9UrM1yk
         4Bf+jpVjRiCRiIvns1YMjk3CHOJhy1wKVByXDbVNE4J6CwFOnO4NES6Htc10rRqDX3Zj
         ASbyiEgHc8mWdDyAvJHw90MIaaM4uIbgHJHriFpLEbGE1LHppWt+yde7zlLwEUYSFzmt
         JAFHDNCx3/9OBY9tpYduumB7MS+5fY780+779fOS1tLgA6gAmR7LZHjNwugqz0CpCwVq
         eP26LtN+hSdwg9yGWUFXxsuHcFRGiHe+M2wujltz74f5d90VQAa9Hpu02DoDnBUc1Qli
         6NFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIol9ah72Q2tPBF9wg6cGSmvA8JiwyBIxpYvOdqXTnSSfjq9zsDXhSYqGIz4mn4oCzXJ47R6cSvnWR/K8PY1Z3UFI63/IXu/yvDgo=
X-Gm-Message-State: AOJu0YxHmgjve+6ZXe6Nkk7u6AqsXs3NvHPKeikyce0P5xoRbCTm5fAo
	oM+JVxOuPucsxHT82BZ4RY36kua1oLXOEdsxCbTGAfd21dNGLNRfkud20Y5GvptMcEzO1Jo8daL
	zJ7nibTaWV8yPwhIW2OJEEMVY8T7E+cX5T66CSw==
X-Google-Smtp-Source: 
 AGHT+IH9SeiO8vfdoOxDABbDkc1VlJaHvluIQfS8YUVwP2eXorBPvqf3BAKJdJfTNAn0CNJ3/z1faNaXrP6fson02ac=
X-Received: by 2002:ad4:4245:0:b0:6b0:6629:bdf9 with SMTP id
 6a1803df08f44-6b501e2c710mr72849356d6.21.1718971694039; Fri, 21 Jun 2024
 05:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
 <20240620175657.358273-11-piotr.wojtaszczyk@timesys.com>
 <jgqhlnysuwajlfxjwetas53jzdk6nnmewead2xzyt3xngwpcvl@xbooed6cwlq4>
In-Reply-To: <jgqhlnysuwajlfxjwetas53jzdk6nnmewead2xzyt3xngwpcvl@xbooed6cwlq4>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Fri, 21 Jun 2024 14:08:03 +0200
Message-ID: 
 <CAG+cZ04suU53wR5f0PhudgNmkxTRtwEXTS1cWH1o9_rTNM94Cg@mail.gmail.com>
Subject: Re: [Patch v4 10/10] i2x: pnx: Use threaded irq to fix warning from
 del_timer_sync()
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
 Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
 Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>, Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: piotr.wojtaszczyk@timesys.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: GNXEQUQOKSJK2M6TPRRZGUVJIUWA5P3X
X-Message-ID-Hash: GNXEQUQOKSJK2M6TPRRZGUVJIUWA5P3X
X-Mailman-Approved-At: Mon, 01 Jul 2024 12:20:34 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GNXEQUQOKSJK2M6TPRRZGUVJIUWA5P3X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Andi,

On Fri, Jun 21, 2024 at 12:57=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org>=
 wrote:
> On Thu, Jun 20, 2024 at 07:56:41PM GMT, Piotr Wojtaszczyk wrote:
> > When del_timer_sync() is called in an interrupt context it throws a war=
ning
> > because of potential deadlock. Threaded irq handler fixes the potential
> > problem.
> >
> > Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
>
> did you run into a lockdep splat?
>
> Anything against using del_timer(), instead? Have you tried?

I didn't get a lockdep splat but console was flooded with warnings from
https://github.com/torvalds/linux/blob/v6.10-rc4/kernel/time/timer.c#L1655
In the linux kernel v5.15 I didn't see these warnings.

I'm not a maintainer of the driver and I didn't do any research on
what kind of impact
would have using del_timer() instad. Maybe Vladimir Zapolskiy will know tha=
t.

--=20
Piotr Wojtaszczyk
Timesys
