Return-Path: <SRS0=rxKz=KH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5DBC433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 14:45:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E34613BF
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 14:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E34613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A0301878;
	Wed, 12 May 2021 16:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A0301878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620830721;
	bh=6o759ShUxJ4M0iPoewavcBs0joP5lvg0/UyuatoupKw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fyy9urNIcEJwOjMeBn7r9SQyVIuG+W17DWnI26OysTOjp2FrtUy3pL3M4FXHtiSFu
	 3WAP5EPW0r5SF952Hi4aifVvxHaW1p3QneNsBXFx2UWnTEU/aAWoGdLUDFCf08zyaK
	 PrYuBSNuBB/YE2NyUVzAkM7O5GTWCJ8ZDZjyqheo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A060F80272;
	Wed, 12 May 2021 16:43:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 239ACF80163; Tue, 11 May 2021 11:37:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94E14F800E9
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 11:37:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94E14F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VmShZQzr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A14E161925;
 Tue, 11 May 2021 09:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620725848;
 bh=6o759ShUxJ4M0iPoewavcBs0joP5lvg0/UyuatoupKw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VmShZQzrJkNUYpzDiT8lkPsxOAMSd9Mve7i5gQll5qndGWVpx/umg+CXxAKGpoNMA
 r3FMkUmVknRLOM40Or9NWwNOL92NSwkHrq/d0ndNeQRTu32uCCDHx2IbSd5VG2b4ul
 nosZAixjCj57nhk32NpeqSVxAJnPk2eny4EB88KTc/gQGnVuXNqo0yWlzvNXSmu4ZF
 mRycl9aLbRnBPpCgKOBrtmqpOvb6P16yZBfRn67Vau0A0Tq2FleVuS/QpC4INaUcg7
 P/ifJQg2MpIKloJneBuh4wLQ19EHMgDmJrDBTumwAHsRVeIkB/VjkEIaNgqi+q08au
 3pae3xKzjvu8Q==
Date: Tue, 11 May 2021 11:37:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 00/53] Get rid of UTF-8 chars that can be mapped as ASCII
Message-ID: <20210511113717.5c8b68f7@coco.lan>
In-Reply-To: <YJmH2irxoRsyNudb@mit.edu>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
 <YJmH2irxoRsyNudb@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 12 May 2021 16:43:39 +0200
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, keyrings@vger.kernel.org,
 linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org,
 linux-ext4@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-sgx@vger.kernel.org, coresight@lists.linaro.org, rcu@vger.kernel.org,
 mjpeg-users@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-integrity@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
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

Em Mon, 10 May 2021 15:22:02 -0400
"Theodore Ts'o" <tytso@mit.edu> escreveu:

> On Mon, May 10, 2021 at 02:49:44PM +0100, David Woodhouse wrote:
> > On Mon, 2021-05-10 at 13:55 +0200, Mauro Carvalho Chehab wrote: =20
> > > This patch series is doing conversion only when using ASCII makes
> > > more sense than using UTF-8.=20
> > >=20
> > > See, a number of converted documents ended with weird characters
> > > like ZERO WIDTH NO-BREAK SPACE (U+FEFF) character. This specific
> > > character doesn't do any good.
> > >=20
> > > Others use NO-BREAK SPACE (U+A0) instead of 0x20. Harmless, until
> > > someone tries to use grep[1]. =20
> >=20
> > Replacing those makes sense. But replacing emdashes =E2=80=94 which are=
 a
> > distinct character that has no direct replacement in ASCII and which
> > people do *deliberately* use instead of hyphen-minus =E2=80=94 does not=
. =20
>=20
> I regularly use --- for em-dashes and -- for en-dashes.  Markdown will
> automatically translate 3 ASCII hypens to em-dashes, and 2 ASCII
> hyphens to en-dashes.  It's much, much easier for me to type 2 or 3
> hypens into my text editor of choice than trying to enter the UTF-8
> characters.=20

Yeah, typing those UTF-8 chars are a lot harder than typing -- and ---
on several text editors ;-)

Here, I only type UTF-8 chars for accents (my US-layout keyboards are=20
all set to US international, so typing those are easy).

> If we can make sphinx do this translation, maybe that's
> the best way of dealing with these two characters?

Sphinx already does that by default[1], using smartquotes:

	https://docutils.sourceforge.io/docs/user/smartquotes.html

Those are the conversions that are done there:

      - Straight quotes (" and ') turned into "curly" quote characters;
      - dashes (-- and ---) turned into en- and em-dash entities;
      - three consecutive dots (... or . . .) turned into an ellipsis char.

So, we can simply use single/double commas, hyphens and dots for
curly commas and ellipses.

[1] There's a way to disable it at conf.py, but at the Kernel this is
    kept on its default: to automatically do such conversions.=20

Thanks,
Mauro
