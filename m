Return-Path: <SRS0=cglx=GB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53554C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 12:41:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD83020867
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 12:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD83020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CC911797;
	Tue, 29 Dec 2020 13:41:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CC911797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609245714;
	bh=qdL1uB6B1UXV2TxgliugspF/mrGeSPiZnH8ZtIXseis=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DalUJffB1/mDN6s089OYGqPGIGOugXju8goF5LToctPSw6zKD6SfALdoM85OTmO0V
	 HAPahhgcNXa/5hHIvJatt5wh6llfXVbni/ySyDAu7+0JGtXOEdMrzYEy/2isjxRImr
	 xppwTLriiSty1NKsPNmremZUFac5QYvIBo5k3dOM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5227F80162;
	Tue, 29 Dec 2020 13:41:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2807BF8022B; Tue, 29 Dec 2020 13:41:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42675F80162
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2020 13:40:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42675F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q5Al3s7p"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2C95207B8;
 Tue, 29 Dec 2020 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609245655;
 bh=qdL1uB6B1UXV2TxgliugspF/mrGeSPiZnH8ZtIXseis=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q5Al3s7pH/Q2gOLjsJl5bUsGE93nP8II2zubSheoULmZ7ACPrddQSEXGRysWmfayY
 kiXLjIBOniPt3RCgQTNgCNLmHKjceAk+7iDr1RuApuiFICzA+kJmNbD0GNE3F79puW
 /PRcgr313b2H0BS0vI4UwmCOi+0u+eJVNKQD/8Lrxx4BUugCxc8s9jRXIMuB9aD67M
 CPNH7s525WPl19lVhIAH/juY1Yqrx3ipec8Ps09MyBN0xZcwKoxmKbmijCQKFcXMDZ
 2QCzq0RVKEJzQTjbBVLCIqwIsr9/nJkJ2dMPsezHx/YO4fs84olRzA+IcmoBorRc6t
 lVZ/mh7yR3Ltg==
Date: Tue, 29 Dec 2020 12:40:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Perry Yuan <Perry.Yuan@dell.com>
Subject: Re: [PATCH v2 2/2] ASoC: rt715:add Mic Mute LED control support
Message-ID: <20201229124033.GC4786@sirena.org.uk>
References: <20201228133831.17464-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20201228133831.17464-1-Perry_Yuan@Dell.com>
X-Cookie: Mother Earth is not flat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org,
 Limonciello Mario <Mario.Limonciello@dell.com>, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com
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


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 28, 2020 at 09:38:31PM +0800, Perry Yuan wrote:
> From: Perry Yuan <perry_yuan@dell.com>
>=20
> Some new Dell system is going to support audio internal micphone
> privacy setting from hardware level with micmute led state changing

I'm missing patch 1 of this series - what's the story with dependencies
and so on?

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/rI8EACgkQJNaLcl1U
h9AfVAf9EwDCDp+92vwJSYVphVfeIPziIaQ9i80zg0jLhzFjnxBt8t0xA34rJync
vGk2dgIgwe5mi+E5hTtNx3rpKQ0YjXrCxUPFnrk284ZsiFpufuUVwbixnzYQpth9
mxPp5lgkOChpYf5n6kYm9gGvW8r6Ijt9CI1SbXV/pUvpbrzN4QP2OPymSyGGvXO9
JUx+FTZOXRVnDs3NqFWQW4T1oaipvOkXTqYAJshBaDsNqn+6/2UaRLQtR1yhet3V
78kMpk0/BjBqrkofsIO/3nUzEgOCX5HwUviCAoqrtmhLmrT97luF/eHlV8k9SjA3
Rf02r7CedzVvZrS+zho8fKD2X4btoQ==
=d8Jt
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
