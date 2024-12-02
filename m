Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ABFD7831A
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:17:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91E3220E;
	Mon,  2 Dec 2024 14:17:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91E3220E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733145469;
	bh=/VF+nWs6BWtLEi7pKkF8pL4507yNu1NwuQmjk0P5/9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BT1zcDjGeg0FTZoS/a3mjQPlAn8+l68J0PR9AhCR8PNDjFT/0L772kvNiacjlrl7d
	 2N8mCzKm7ENVHGyi5A/acxIM52HEQsgLKe/3r7ovrypAWvZdyKdjgi10h3rkuUQkN0
	 elyxfP6CxR3lzjFVqdrjgL9YVGJ3Zgs55CkeuQMg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5AB07F80073; Mon,  2 Dec 2024 14:17:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 60851F805C2;
	Mon,  2 Dec 2024 14:17:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2485EF80272; Mon,  2 Dec 2024 14:17:04 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 369E1F800E9
	for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2024 14:17:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 369E1F800E9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TlUDTiqG
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DC4EDA40B5F;
	Mon,  2 Dec 2024 13:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CE9C4CED1;
	Mon,  2 Dec 2024 13:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145417;
	bh=/VF+nWs6BWtLEi7pKkF8pL4507yNu1NwuQmjk0P5/9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlUDTiqGqqVXsTcBbB9DY1Tj4GMlqBKCfLy4MRppqgoZ+hIXX+C1MxEj5vfH9GnPp
	 pZzbmEljazX/5Fp15FZzjtyQiV1ARa5cluHtszSCNK+WUICMjsXncH/i800kboib3d
	 5yO6V9WPYE2Gw6PKa8jvyRcXDRMhpGkyfykwfGepEd9RLlf9N+2uRYV1kfFkMrn1rb
	 va5YB+0NIfOs3QsVhKScTQ1SxXldUT4An8nqBvnsXywUZlmtQRVQHW/x/+juRJpXdN
	 +RZehDyE3RB5KB4msJrMpBXmF/iSnIGVeQI0SRdGYab574kPnU8kJRIi+YRG9yp/R8
	 u967dyf3w8Lgg==
Date: Mon, 2 Dec 2024 13:16:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu =?utf-8?B?KOS/nuWutumRqyk=?= <Jiaxin.Yu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ajye_huang@compal.corp-partner.google.com"
 <ajye_huang@compal.corp-partner.google.com>,
	Chunxu Li =?utf-8?B?KOadjuaYpeaXrSk=?= <Chunxu.Li@mediatek.com>,
	Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsik=?= <Allen-KH.Cheng@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
	Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"robert.foss@linaro.org" <robert.foss@linaro.org>,
	"Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Prado <nfraprado@collabora.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Message-ID: <00d5c728-3eb9-427a-bc60-5828c20fec09@sirena.org.uk>
References: <Y4Cysgk5Gic5ae9B@sirena.org.uk>
 <18c82f6f723cd97a9d6b9a7ff16c6ed62fd005d6.camel@mediatek.com>
 <Y4Y/vEWe3dw0FPQH@sirena.org.uk>
 <cf9ea98a3263ffb8fc8b542888ad0ad680facfc7.camel@mediatek.com>
 <Y4jHAJgmz/P58Q/C@sirena.org.uk>
 <7023a2c7b471d6888d9079563a6c01f22599201f.camel@mediatek.com>
 <Y43e+EsNCrCpZSIH@sirena.org.uk>
 <dc50d0b21795acbcc44c77e5fd81e7cb92c65c67.camel@mediatek.com>
 <Y5ipwqzHKTK8UdlC@sirena.org.uk>
 <a699178dcef540fff5caae6291983a444886bff6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NG9fJ4QMkZ8167X3"
Content-Disposition: inline
In-Reply-To: <a699178dcef540fff5caae6291983a444886bff6.camel@mediatek.com>
X-Cookie: (null cookie
Message-ID-Hash: 6VJVFRTYDTMPUSK6C4NAD5327FOS5QII
X-Message-ID-Hash: 6VJVFRTYDTMPUSK6C4NAD5327FOS5QII
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6VJVFRTYDTMPUSK6C4NAD5327FOS5QII/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--NG9fJ4QMkZ8167X3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 05:15:45PM +0000, Jiaxin Yu (=E4=BF=9E=E5=AE=B6=E9=
=91=AB) wrote:

> So I want to ask if I can do it by just adding
> SOC_DAPM_PIN_SWITCH("Speakers") and SOC_DAPM_PIN_SWITCH("HDMI")?
> Correspondingly, dapm widget and route path need to be added. That is
> "SND_SOC_DAPM_SPK("Speakers", NULL)/ SND_SOC_DAPM_LINE("HDMI1", NULL)"
> and "{"Speakers", NULL, "Speaker"}/ {"HDMI1", NULL, "TX"}".

Yes, that's what I'd expect to see.

--NG9fJ4QMkZ8167X3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdNs0IACgkQJNaLcl1U
h9DGvAf+J3hwEq4x3bF91sZy15VQBvz/0kSF2J0M+KaBQnVVFXj/YCUp9AjHd9Py
svtvltKB2dzk8Cpzti6uG995Vi0ugqWdEFR57tDSFDzyMMEStcr/z+LYr8gmncxg
0kEyoQrLHpnucIqWa+IJ766YUIsU2FvSM5IP2ZDXfWUeSHI5fzUfpc5M9MrgZJut
JfoR0eE91G28dKk46pdE+WRc6xsPWl/jRqlgr492lZe5Qew7l8ZRdnvummrx0iDd
A4z1fW9cZXTepa9GisH8GziS6GP3C+qJWwsAgq+iaKvZ6tBcii8s0sSGVRWbvQQG
a7poRNcQYuwS88Fimgys4lWYbODVVg==
=weMB
-----END PGP SIGNATURE-----

--NG9fJ4QMkZ8167X3--
