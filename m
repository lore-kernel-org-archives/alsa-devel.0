Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBB5D39410
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:47:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF846601F9;
	Thu,  2 Apr 2026 13:47:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF846601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775130439;
	bh=dG9IWA6knZciYoHTdw2VK4AuRjV45okkNQZ8YVBAJt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MNMoi3doPtmIsyFrNtq/qM0SkRY3rfFDIiP8I5P3Kc+VXBkZU/GZkVqi0FGhBRW7t
	 P+iJaAW5Q6mch8dNBLTL8vsPE+vZ/uhn39UxwMZKD6HTLhalelLoh2KuhsOlrAuIB8
	 t8nLL4J6PYzZpPV8Z1pVtun+C1UIho9CxUkmgWCw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09E1CF805F3; Thu,  2 Apr 2026 13:46:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E47AF805EF;
	Thu,  2 Apr 2026 13:46:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3E36F80496; Thu,  2 Apr 2026 13:46:37 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2F914F8014C
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 13:46:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F914F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nJyQHQ5P
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9E7C661880;
	Thu,  2 Apr 2026 11:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A34C2BCB1;
	Thu,  2 Apr 2026 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775130393;
	bh=dG9IWA6knZciYoHTdw2VK4AuRjV45okkNQZ8YVBAJt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJyQHQ5Pic7YKoMk4pSyBghiOgj40Otvf07ibHygYVdoNgPlO7g09lKXL4kl46Ha+
	 iJH3CW6FgE2knwXtv6LIViNR6vNBmnigmx01oyqBit7rZAGxiZg05zCvcMfwlMWLY0
	 I2xnotfLb9xc98EbJcsmo69qulAHO5Kwj87gRuGnaLMPOCDpwf1JKzluAo+sbB7k2/
	 2FHD8AiGefGk22/VAPPUmrTgMGn9JnEFjaDfNhnD37os+EB8bmCrVFVofc1/jmOL5s
	 hJe/n3TFMYsb4XWsmkdGyIHWGatpIEjk8nq7JCYP9B+X9YUaI9vSUa1RyB1h/ToPSC
	 BBoiSgRZkYF4Q==
Date: Thu, 2 Apr 2026 12:46:28 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Message-ID: <55886bf3-5837-4f37-b60d-333fdc5f5f70@sirena.org.uk>
References: <20260402054716.1795350-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8OwTknS8oYmI+nzX"
Content-Disposition: inline
In-Reply-To: <20260402054716.1795350-1-jack.yu@realtek.com>
X-Cookie: <doogie> dpkg has bugs?  no way!
Message-ID-Hash: LXKAP5GSP7RKGIT3G5FVF7VDPJRLS5WM
X-Message-ID-Hash: LXKAP5GSP7RKGIT3G5FVF7VDPJRLS5WM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LXKAP5GSP7RKGIT3G5FVF7VDPJRLS5WM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--8OwTknS8oYmI+nzX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 01:47:15PM +0800, jack.yu@realtek.com wrote:

> +	SOC_SINGLE_EXT("Brown Out Update", SND_SOC_NOPM, 0, 1, 0,
> +		rt1320_brown_out_get, rt1320_brown_out_put),

Like I say this should be a Switch - it's an on/off control, even if
it's for an algorithm.

--8OwTknS8oYmI+nzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnOVxQACgkQJNaLcl1U
h9A0xQf6A0KiTI7l6e3E/Q6uUn8KROsRxkqLmeydtd0sFpB086sipwJe5imX+HXE
ZRVvDogqBYhOWVG1n6LEB0wcGQt+6uY8tIk2Nk/23Z8UoWKGmJXngaAD4sxur3nO
SNBIm5TXu7LNHvJIUGZfNiOVAK6Joqvd/JaHHmqFh2VT5mnkhs7hq5I5gyubfjaw
92+Aq3/NmgAIxBr9FttyJA///5Km4qy2VZHRcAfp+zeVg6K6gkwD4VPpgZS5Pe9Y
GXKZ9rsRBrwueWr1DMrgHk5HpWcOATq8XAdnTv6KUz9xaxIIKTFc9iyIJ8OOoGja
3TjYnPvCH8h9AfCOb/9Nz5DK4Yn5Jg==
=zIwV
-----END PGP SIGNATURE-----

--8OwTknS8oYmI+nzX--
