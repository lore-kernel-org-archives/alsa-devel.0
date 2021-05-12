Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6FC433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 15:41:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E832B613DF
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 15:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E832B613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ED0F1779;
	Fri, 14 May 2021 17:40:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ED0F1779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621006891;
	bh=zB2G4t5ozyJ72g68BGRplKf2lQRTS6CtRvJ7FVX3NWE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cLsuGjnNPTSAe/grjVirNuz471U4rUe52uliKZJdz+tV7kwKp+Q6COLE8bDVYi8fd
	 nFJN7YBg6QXbtvBO6QSjF9kD0/34HIg0nhf+40VBN1nzVsNWrCBE+lty+jfDMOnS3T
	 S4POyjf5vyZENRWbgB7/1DN3FocgmuYzjIoXcrf0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2C54F80272;
	Fri, 14 May 2021 17:39:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58058F80240; Wed, 12 May 2021 17:18:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD53EF8013A
 for <alsa-devel@alsa-project.org>; Wed, 12 May 2021 17:18:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD53EF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DBjrvZcb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 455F961C3E;
 Wed, 12 May 2021 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620832672;
 bh=zB2G4t5ozyJ72g68BGRplKf2lQRTS6CtRvJ7FVX3NWE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DBjrvZcbfODq6o/u3ovhcKp34o3mQ/2g2kqOKbw7rqi0UbJcuDmNkgLMMy0M05dFs
 mwfV7fdqIvkaHvs5FkFIxP3pQ5mW2wuelKsM0Zg1XI928MZ1g6hDtwlC/lZ6mTYtDn
 L0yXyxJPdKzjgMXD6Vs/vdQOXuvQV+DBBKSwRDhM/LlZ9x9/DV6Qnq7MjBym4Ue3He
 LklNFflnfSaW1SCikrvqRJriPDliUiNhIaGm2pb/3nXItDzT/4/obeOPpO0NPN/v0m
 Pwish5sD0axq4vDEIuCSUJZyKrnPcy3P6Nd30IKN+fHXybC5E+QSyK+xdLgaNeWw/l
 +EUyGcBOd8VUw==
Date: Wed, 12 May 2021 17:17:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 00/40] Use ASCII subset instead of UTF-8 alternate
 symbols
Message-ID: <20210512171741.2870bcbc@coco.lan>
In-Reply-To: <YJvi1L2ss5Tfi+My@mit.edu>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <YJvi1L2ss5Tfi+My@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 May 2021 17:39:48 +0200
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 keyrings@vger.kernel.org, linux-sgx@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
 linux-acpi@vger.kernel.org, Mali DP Maintainers <malidp@foss.arm.com>,
 linux-input@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-ext4@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
 coresight@lists.linaro.org, rcu@vger.kernel.org,
 mjpeg-users@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-integrity@vger.kernel.org
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

Em Wed, 12 May 2021 10:14:44 -0400
"Theodore Ts'o" <tytso@mit.edu> escreveu:

> On Wed, May 12, 2021 at 02:50:04PM +0200, Mauro Carvalho Chehab wrote:
> > v2:
> > - removed EM/EN DASH conversion from this patchset; =20
>=20
> Are you still thinking about doing the
>=20
> EN DASH --> "--"
> EM DASH --> "---"
>=20
> conversion? =20

Yes, but I intend to submit it on a separate patch series, probably after
having this one merged. Let's first cleanup the large part of the=20
conversion-generated UTF-8 char noise ;-)

> That's not going to change what the documentation will
> look like in the HTML and PDF output forms, and I think it would make
> life easier for people are reading and editing the Documentation/*
> files in text form.

Agreed. I'm also considering to add a couple of cases of this char:

	- U+2026 ('=E2=80=A6'): HORIZONTAL ELLIPSIS

As Sphinx also replaces "..." into HORIZONTAL ELLIPSIS.

-

Anyway, I'm opting to submitting those in separate because it seems
that at least some maintainers added EM/EN DASH intentionally.

So, it may generate case-per-case discussions.

Also, IMO, at least a couple of EN/EM DASH cases would be better served=20
with a single hyphen.

Thanks,
Mauro
