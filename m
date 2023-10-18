Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2A6CDB47E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Oct 2023 12:57:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E52A19F6;
	Wed, 18 Oct 2023 14:56:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E52A19F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697633866;
	bh=RfajBlwcuXvS+TumbX+H26qssz1sCsAhi7MdYhWbndc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iwXeKnwZN7SDDc474NwWpDudqKnXZGB8xAuMhiwcvy8H3Ur0e1LY175IyF3X5Z58d
	 94RxNwqKgFtk3YIlCaflxsadty4lNNFR6c7W8nNBsooVk00sAiPzEOSqtPi9YVuVB0
	 FnU+41XdD5AEQPPHM8d8c8hH02tB5uyKp9MC8nXE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FD26F8027B; Wed, 18 Oct 2023 14:56:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE5F1F8027B;
	Wed, 18 Oct 2023 14:56:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0C68F8025F; Wed, 18 Oct 2023 14:56:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DA353F800C9
	for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2023 14:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA353F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MJVkvpwr
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6C26A6106C;
	Wed, 18 Oct 2023 12:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA518C433C8;
	Wed, 18 Oct 2023 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697633778;
	bh=RfajBlwcuXvS+TumbX+H26qssz1sCsAhi7MdYhWbndc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJVkvpwrSgXAy6qscSeVWxmppjv3m8n4+kX+4AHQ14KMDidYa9FDRWG1HZLJYOetF
	 bjmQdZUNaS7DMv9iAYakN7DzObetRdzpsgVz5TlhdcmTvAoHhpRsO4VgW7zJRrTjvH
	 JyX88p2CZz9M1iJQAcQ22FXKBwOOtTXdd4j1hBSY49tVOlX9COd0jkM+7WByoOpBCB
	 WKnprgmC/NsbLe4ii21o2elYvR+OHBKVGJNMKKBHA8QMD15FVqPqP9RbuyNRizwID+
	 1ESgcoh9BLGO68YjQlkoxeJRXAErVYY/mC5Wj1qGcqKlGqgI7+kFdvu8Yvs5p0bB7G
	 qYnqMZ5nYBpkA==
Date: Wed, 18 Oct 2023 13:56:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wsa884x: allow sharing reset GPIO
Message-ID: <b7aeda24-d638-45b7-8e30-80d287f498f8@sirena.org.uk>
References: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
 <3aa9e3a7-9417-44b4-87d8-fcf1a8b46daf@sirena.org.uk>
 <84f9f1c4-0627-4986-8160-b4ab99469b81@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SeEMerEnyAsMxP6P"
Content-Disposition: inline
In-Reply-To: <84f9f1c4-0627-4986-8160-b4ab99469b81@linaro.org>
X-Cookie: Santa Claus is watching!
Message-ID-Hash: IVVVBSSSYGC2UGDL4GZ45JFEDHDAGUYE
X-Message-ID-Hash: IVVVBSSSYGC2UGDL4GZ45JFEDHDAGUYE
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IVVVBSSSYGC2UGDL4GZ45JFEDHDAGUYE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--SeEMerEnyAsMxP6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2023 at 02:38:00PM +0200, Krzysztof Kozlowski wrote:
> On 18/10/2023 14:35, Mark Brown wrote:

> > How do the speakers coordinate?

> They don't and that's the generic problem of many Linux drivers. Not
> only this one, but others as well.

> Device unbind (remove()) or runtime suspend of one speaker will affect
> other speaker. I don't think any other drivers solved this, because this
> is rather core's GPIO issue, thus I am not solving it here either. :(

I'd expect that the GPIO users should coordiante directly rather than
rely on the GPIO API to do the coordination for them - there aren't
enough semantics in the GPIO itself to do much more except possibly
provide discovery services (which would be nice).  Look at how the
regulator API manages multiple regulators sharing an enable GPIO for
example, it adds an additional layer of reference counting when it
identifies a shared GPIO.

--SeEMerEnyAsMxP6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUv1eoACgkQJNaLcl1U
h9Arjwf+MY/q21wh5tBoMbw8vn1r4Ag4O1t2M+4gxxtLbqzpaWKPc99mHcw04BMC
1ddMktsfr9bnWH0PBXYhrKahMdfDlXrotllyDtWS0i9hQUOhrgFKj0r4192NDc4q
do9drmxc8ikNhIP4AWqQTj0uLXEwRuHqj4gXnak6M0ScAi9cLYo0BvIBi/g8f+jY
U609DqfVDLVbntcAVB+b6j087AwW1drZ4cj2XV7TppJtUE1IWku3rlb95zm2jC0B
SwQI49ZkObNk2YiErX33Q9qmIitZbtgLvBR3DHsZHlBaswBT/IApJRnu1VOJsHX4
/56/6Ela2XeuYcFE3rPB0ExOstsO+g==
=lF0c
-----END PGP SIGNATURE-----

--SeEMerEnyAsMxP6P--
