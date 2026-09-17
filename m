Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB77C982D2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:10:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3756601F7;
	Thu, 17 Sep 2026 12:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3756601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789639821;
	bh=+vM4iam60z6KEMZ9Fm7CWrPAoXIWYPpYAI+Auic9Xdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UV8xAHuWfZ2ex+gU+Y6EcexFjN5Rpr3d30sXofn/zASMRSXibLx66V+BBBr6lNNUa
	 35TgY8hJpGEpsHCMuFHKVuXfDusbnKtY6v9IxbDEFmkVKfC+DdxwmTs/o/QSVtApSJ
	 aYz3FeJlEJLyVBFPz23uZjwYkyw1Jsm3Tv9H7MWc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25032F805ED; Thu, 17 Sep 2026 12:09:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B3A2F805F9;
	Thu, 17 Sep 2026 12:09:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE3C2F80537; Thu, 17 Sep 2026 12:09:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789639777;
	b=Ek0nrXk6SQTuveHPE6a9flqJas300yoSyZ1VWoj5YIld8IjKiAmH2u8M0nmkdZEwJLSM
	 8ncwoh340BDbkW83wEpqkoDVxlxTTFazPjqNw0HHcZ1YvMObTHpdYAJnOKLJjwVpbE7fJ
	 40DfWiWd+b1Ix6clMiJP+0gcTeoUVq/FURfa4eWQbnzjY65TI/7Coq+7CLfNqAbKmE5Wi
	 PvwhbBDYeRGv7c3Nv+KIEsbdIZ/XQXjL4oNRSBc3IM97+DQkuMg9xrb6Oi/+2N1sTFeSz
	 C841uKl9IZZtMFvoGm6jfgBj2GgyegPY9OmDal921tH99KmCOPxfMcWBCCP/QCK41sg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789639777;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=+vM4iam60z6KEMZ9Fm7CWrPAoXIWYPpYAI+Auic9Xdk=;
	b=Z55aILp6z/B5vsWRKRKYbyqxSa/AUiX5MWuoBlBviwtcgs3NivnzwKwpLgPUQgOVB5Gc
	 87WaxGF9j83WFVsExpDd6HvNxYMphObzf5kB6GmKLofVA+ifKVwEC6qy9XKxXdynBxVhu
	 VjcPbXAKEG7AGovlmBHcvuSL5Bcnm/rAr5BKYWXHwsXQfFzhEH10SXDOTXfiOjaqsiEtx
	 aucdFb8Y6QHwOp+XCzT41YlTJNzWsTiXHQo3Xo98nNDQbYd2yYsnETjIClMLZbQ4JTcwZ
	 s4O9Fdc0QL7ckwsHwNGNMgPYGp91w8k8Mx0u1HCVRA7C+3uIA6g3WbF9sLPn1NWA3zQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HvhOvwMl;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0C77CF8007E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 12:09:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C77CF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HvhOvwMl
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2586341B07;
	Thu, 17 Sep 2026 10:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407DD1F000FF;
	Thu, 17 Sep 2026 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639772;
	bh=odyX8Gm1Y2ZTjmiQ0iSsIgjm/HtHjgSv+tCSjKDPb5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HvhOvwMlYlnZ+cN0MAQXkcjZrD+linEkZtim1BW+RbYdDK02HVd99vKbs/TbCTZgg
	 aOUGF0UQYBeLkG6BKTzfTdO7VJ+QI/8U5hfqnZ4AImilGLnfIFKIE3PyXhP/WZoz+p
	 u+C1uFhlnsynh2gcUET2p7QvGWQUSwy81Kc7urw99Jfq3lkKNHkXqPv9HMtI0I3xh0
	 w0aeQUahI7tRqEJia+CCVBzc1jXz8IpagdpKCUHLz/laNMQv8nwhkVSEm5+Xe1UgDu
	 ECklgS+47cWHi98UUh0W9oD791fXHyh0FwruElwA/9A20mj238SYKg4srYReaDNNtN
	 OWdCW5Bwv35vQ==
Date: Thu, 17 Sep 2026 11:09:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Seiji Adachi <seiji_adachi@yahoo.co.jp>
Cc: Vijendar.Mukunda@amd.com, venkataprasad.potturu@amd.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2
 (21JN) to quirks
Message-ID: <599be753-cccd-4c71-b3a7-d35ebcd349d0@sirena.org.uk>
References: <almeAbvirJwQ5doF.ref@adriana>
 <almeAbvirJwQ5doF@adriana>
 <alnKI3bPaZUc6uwB@adriana>
 <aoukqUoiIzcctf-k@adriana>
 <aqu4HOCmdCUs_unm@adriana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xKi8rWeAm6eeTz1x"
Content-Disposition: inline
In-Reply-To: <aqu4HOCmdCUs_unm@adriana>
X-Cookie: Whip it, whip it good!
Message-ID-Hash: UPP2EIMTEH3VTIMUOJ5PKLLBBP4ENWQ6
X-Message-ID-Hash: UPP2EIMTEH3VTIMUOJ5PKLLBBP4ENWQ6
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UPP2EIMTEH3VTIMUOJ5PKLLBBP4ENWQ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--xKi8rWeAm6eeTz1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 06:51:24PM +0900, Seiji Adachi wrote:
> Hi,
>=20
> I am resending this request along with the code change (diff) required fo=
r=20
> Lenovo ThinkPad E16 Gen 2 (21JN).
>=20
> Could you please review and consider applying the following patch to=20
> sound/soc/amd/yc/acp6x-mach.c?

Please submit patches following the process documented in
submitting-patches.rst, the formatting of the email is quite important
for tools to be able to process the patch.

You might want to look at b4 to send the patches, especially it's web
submission endpoint which avoids having to configure mail:

   https://b4.docs.kernel.org/en/latest/contributor/overview.html


--xKi8rWeAm6eeTz1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqrvFQACgkQJNaLcl1U
h9AT3AgAgfqXJPuXiOz2Gzgi7mI9LjPvYOH+q8BtOYx+pzeFb2HdFLteMiNNKhXl
+DHzV4Cpatw6vB4iyoVx02Fz/Te4uLkNR00H9wyomVYXWO5GJmnXoH8CVgKTxKG7
/EJbtaX55bD30SHDUVBeYh755iGhFQP29HIyMt8DNhCP8/VrFQyQKAEvvyigNOTg
LwJSbnj6nUDu2WCTsoVDIw6fgB7OzF8XBLWZ9/ZKT0DU/ZjtA3MnjYX4l1lFvOnh
7PLBj2/7Iqxv801cjyvhVDyHBQM+J2ep7CkcwfVw0tI3iXR//AwifKe0BBomNUh6
UTaREDyrgkbO9T3DloS1pcXDF4z+Ow==
=jZM1
-----END PGP SIGNATURE-----

--xKi8rWeAm6eeTz1x--
