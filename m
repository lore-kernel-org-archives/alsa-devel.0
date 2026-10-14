Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4B6CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:44:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37F0460244;
	Wed, 14 Oct 2026 12:44:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37F0460244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791974696;
	bh=DP0Ieqoi5wZMgEayjuz5m/NrIvwbIMZw8khQ4qYlU9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CUreEDo19CmFSDWeZIrZz7eKh4t17c+AK+R836bhAqfe6yzm7NDeKzvEZoeJH003n
	 EVCpuc+a/cWfgHGRegnQGHG47S5DLd+cj55Y1LR7YdroNkg5NP+AWnLQYs3LXTN+Zq
	 WAWrbG4t1iwesWr13EjIKPkuChRlcNA1IE7gNM3M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0BDD5F805ED; Wed, 14 Oct 2026 12:44:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E3A3CF80600;
	Wed, 14 Oct 2026 12:44:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD671F80448; Wed, 14 Oct 2026 12:44:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791974652;
	b=dhGREl5s2ISqt4Yse1TaVHOszn1cAUyb1T90yvNRIAneVxslblO9ASHhf3uJTCbxPd75
	 cwJFZcs1yoTlNDv7lNC72QIou0VCHSN439XdKaIXoEDPGop36Fs4ODMAWMrPLjFAHeDm/
	 ygLLF8tPIwm/qMyGeShQz9UM3JDLNQMvhLc6l+hsy3DeamhfR6efvv6aq6OXVywsRDuAQ
	 QH7uvHN3wwgvqGCED+/FEuv1sevANmxaje9e41rq2VaxMeIoTN0mf7YZanYxS1mLjBVNx
	 tB5pu6lKsePwfFuFjEXu24jRGJQurbOE+HPNmjiBm/WL/Nry4z/5ercj3aIc5uiw49w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791974652;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=DP0Ieqoi5wZMgEayjuz5m/NrIvwbIMZw8khQ4qYlU9w=;
	b=DTLn34s2y7ryxKm4qFKOxlj/zuX/Eznmi/y/9IIXpMB7uLLqpk/qEa/qdjq+V/OmZIFa
	 dODCZquHy0p9bvZXIEV+9vdU59UBqvUVkxsT/oasUIC874K9pVWADHSaC45gc2K+Oy7sF
	 xrbpbBd4XPGfAJxcCjY1XdEXxfIiLD+FTo+aIPFRUUfIbb7pd8DoK0+TI829Y2GlU/aIN
	 QFSQsu5kMbD622225kz5NzTfQPnseM+1wpCaIr+UUaTmCAfYNHbexkkB5lMmd5Mk0ymRk
	 +pqDzBwhxQxbWVJc4Kyd6m/6ul8CZCn60w//TcedpoBzeZGrSLx7/F+rpijAfLJu6DA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=h3K2TjRr;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 77521F800E4;
	Wed, 14 Oct 2026 12:44:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77521F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=h3K2TjRr
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 39E7D60218;
	Wed, 14 Oct 2026 10:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F9E1F000FF;
	Wed, 14 Oct 2026 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791974647;
	bh=DP0Ieqoi5wZMgEayjuz5m/NrIvwbIMZw8khQ4qYlU9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h3K2TjRrVF0FqpdSOx4xHm+dQceczMutbwFmtYFvBF70SmG6yFPUcjC5MOcz7vA1L
	 M1Ww4YqXlBMGZTRaT5FDvzEpOkW852SACFCzL7agdYaoEX3ZoaMiuD/WPOUi/rdzyj
	 R7BrR0ZXl01IfS3lmjq42X2g186iYTr4QUox+0hxaheAoaBxtQOFZJzm7hvnNX0Tnz
	 PPO6/8RuQhPDWkmU8Wg4tpIQO7rwlNUQQSXboOxfdH1sf8O70KQiKpValjilP1ik5K
	 3MKAgqe0dHsOGqvyO0BZR9qF4xglgZp3jE0tuxWTHHWYPZvS6x38rqMe7QtOw+ohVh
	 CxylkTPgnRClg==
Date: Wed, 14 Oct 2026 11:44:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, yung-chuan.liao@linux.intel.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v2 00/10] ASoC: SOF/amd: ACP7.B support and ASP carveout
 firmware loading
Message-ID: <a22f2a9b-3bb9-40d0-80d6-4ce36758c4f5@sirena.org.uk>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="676xn5QD/iBmhotU"
Content-Disposition: inline
In-Reply-To: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
X-Cookie: Live free or die.
Message-ID-Hash: 5VMC2Z7JLUNWUWXDN7JPX76WXIKWQTLA
X-Message-ID-Hash: 5VMC2Z7JLUNWUWXDN7JPX76WXIKWQTLA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5VMC2Z7JLUNWUWXDN7JPX76WXIKWQTLA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--676xn5QD/iBmhotU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2026 at 03:29:08PM +0530, Vijendar Mukunda wrote:
> This series adds ACP7.B platform support to the AMD SOF driver stack
> and implements the ASP-authenticated firmware load path required by
> both ACP7.B and ACP7.F.

v1 is already in my CI queue, can you send an incremental change with
the new stuff in here.

--676xn5QD/iBmhotU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrPXPEACgkQJNaLcl1U
h9CxcAf9Heotb7IHcpwkhw5QrY+/YqPi9LmhfEcyPbJJeNN/ZM1o0r7fRqf+XkEM
7TUkqVq8uYUTxkOluWLgWm8/8b+MGItBm1I4PHQKuY+Sx9xW7+yT/JCRf5VfvYKK
0pAX9SF/Px0V6s44trnCHN5dU4Vd6pj+72BYCX4SmzG9I4we88Fj7APbTfSkgXsE
uzu+GPAMa0VdJiUpQxhPpKhfWoBLR7++PZ8OW5STZlsVmK1hvMrklIws/qBF/smL
8BYx8nXVoWIwtprUM+FpbXqCYu/H4/Viuq/BjLKP1fd5D301YERLXxvsO0mN09W5
ZBikFDcA0ouZzsYwvgNABhauBRkjaA==
=DX07
-----END PGP SIGNATURE-----

--676xn5QD/iBmhotU--
