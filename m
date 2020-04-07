Return-Path: <SRS0=QmEo=5X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4AFC2BA80
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:41:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1649720719
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l8M4zRUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1649720719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qelectrotech.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64B73852;
	Tue,  7 Apr 2020 18:41:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64B73852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586277711;
	bh=ON6R3nZ4To6Ikc8Q7+KUwawFfTz5Fg6TVTyrTOzeOn4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=l8M4zRUKZk/dnw22mq/1G+Iw8rRRJ535Xhv2sp+3dKle7jDGdp92M7zXuWlLbhbzx
	 78n2Rr3CwHNej+eP1cc4o5MQnhjtCUKddxUoPYImcpBA6ikqGK1n4+P1DumG7qSK5j
	 UKMjicpHpBOuDTnbRdGgVslJZhfU/D4irlDDiP6g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8A03F801D8;
	Tue,  7 Apr 2020 18:41:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DF75F801DA; Tue,  7 Apr 2020 18:41:00 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 742D3F800F0
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2020 18:40:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 742D3F800F0
Received: from debian.localnet ([90.76.199.134]) by mwinf5d20 with ME
 id Psgv2200K2uUZNa03sgvcX; Tue, 07 Apr 2020 18:40:56 +0200
X-ME-Helo: debian.localnet
X-ME-Date: Tue, 07 Apr 2020 18:40:56 +0200
X-ME-IP: 90.76.199.134
From: laurent Trinques <scorpio@qelectrotech.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: TRX40 Realtek ALC1220-VB USB Audio
Date: Tue, 07 Apr 2020 18:40:55 +0200
Message-ID: <2217755.QTRE0Dg35j@debian>
Organization: qelectrotech.org
In-Reply-To: <s5h7dyrmhei.wl-tiwai@suse.de>
References: <14399276.b7z6KR4yDS@debian> <1904096.ym1ZuGme22@debian>
 <s5h7dyrmhei.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Cc: alsa-devel@alsa-project.org
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
Reply-To: scorpio@qelectrotech.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Le mardi 7 avril 2020, 17:42:29 CEST Takashi Iwai a =C3=A9crit :
> On Sun, 29 Mar 2020 16:20:49 +0200,
>=20
> laurent Trinques wrote:
> > Le dimanche 29 mars 2020, 10:50:53 CEST Takashi Iwai a =C3=A9crit :
> > > On Sat, 07 Mar 2020 14:00:26 +0100,
> > >=20
> > > laurent Trinques wrote:
> > > > Hello,
> > > >=20
> > > > sudo dmesg -lerr -lcrit
> > > >=20
> > > > [    0.386478] ACPI BIOS Error (bug): Failure creating named object
> > > > [\_SB.I2CA.WT1A], AE_ALREADY_EXISTS (20191018/dswload2-323)
> > >=20
> > > (snip)
> > >=20
> > > > [    2.545332] Error: Driver 'pcspkr' is already registered,
> > > > aborting...
> > >=20
> > > All those are irrelevant with the sound problem.
> > >=20
> > > > [    2.572542] snd_hda_intel 0000:23:00.4: no codecs found!
> > >=20
> > > I guess this is a known "problem", the strange hardware implementation
> > > where exposing the dummy HD-audio bus with non-existing codec.  So
> > > this can be ignored as well (maybe we can blacklist the PCI ID for
> > > ignoring more properly).
> > >=20
> > > The real issue is:
> > > > [    8.169209] usb 7-5: cannot get ctl value: req =3D 0x83, wValue =
=3D
> > > > 0xc00,
> > > > wIndex =3D 0x1300, type =3D 4
> > > > [    8.169214] usb 7-5: 19:0: cannot get min/max values for control=
 12
> > > > (id
> > > > 19)
> > >=20
> > > So it's likely a USB audio firmware that doesn't behave correctly as
> > > advertised, and we'd need a workaround.
> > >=20
> > > Could you give lsusb -v output for this device?
> >=20
> > Yes
> > Bus 007 Device 002: ID 0db0:543d Micro Star International USB Audio
> >=20
> > See attached output.
>=20
> Thanks.  This looks like the same issue as reported by others.
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D206543
>=20
> Could you try two patches found in the bugzilla above?
>=20
>=20
> thanks,
>=20
> Takashi

Seems fixed.
Thanks Takashi for this quick patches and make warnings silent. ;-)

Cheers,
Laurent




