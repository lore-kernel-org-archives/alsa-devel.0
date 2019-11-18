Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8096FC432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:35:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7756C2084D
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YgO7VnF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7756C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43DB6167B;
	Mon, 18 Nov 2019 15:34:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43DB6167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574087737;
	bh=hpXVrsR73lvRK4EwFCUXmZjafaSfsz1YqFhV5r6hiuE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YgO7VnF1PG4MUjw5UWZcDeMtU32CzVGW/GzKHFZ2RHXQfbPJvm3ucuh+CwA1zCgtC
	 TmjBJvEuBJF1PrZVFKTctvgo4T/0xsIeuhkdWrHwe380ffwa2mDSG7x9z1j/YyH+ED
	 aoKSWIqci5A5j5fs6U9cSrkM73Agb2YHq5EJZA8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1589F80100;
	Mon, 18 Nov 2019 15:34:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18E70F8013B; Mon, 18 Nov 2019 15:34:45 +0100 (CET)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D98DF800F6
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 15:34:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D98DF800F6
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id CD33B1C17F8; Mon, 18 Nov 2019 15:34:40 +0100 (CET)
Date: Mon, 18 Nov 2019 15:34:40 +0100
From: Pavel Machek <pavel@denx.de>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191118143440.GB22736@duo.ucw.cz>
References: <20191113111259.24123-1-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <20191113111259.24123-1-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pavel Machek <pavel@denx.de>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio: Fix incorrect NULL check
 in create_yamaha_midi_quirk()
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
Content-Type: multipart/mixed; boundary="===============4450188665092475095=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4450188665092475095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-11-13 12:12:59, Takashi Iwai wrote:
> The commit 60849562a5db ("ALSA: usb-audio: Fix possible NULL
> dereference at create_yamaha_midi_quirk()") added NULL checks in
> create_yamaha_midi_quirk(), but there was an overlook.  The code
> allows one of either injd or outjd is NULL, but the second if check
> made returning -ENODEV if any of them is NULL.  Fix it in a proper
> form.
>=20
> Fixes: 60849562a5db ("ALSA: usb-audio: Fix possible NULL dereference at c=
reate_yamaha_midi_quirk()")
> Reported-by: Pavel Machek <pavel@denx.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks for doing this.

Acked-by: Pavel Machek <pavel@denx.de>
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXdKsAAAKCRAw5/Bqldv6
8uJHAJ0V4w8ERJieyS0YtELNz6wNz7/WQACffTMMwfwbjocL5KTpauKs4pQYtRA=
=GZs0
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

--===============4450188665092475095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4450188665092475095==--
