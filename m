Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836CAC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 12:40:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EC322242
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 12:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nnocYTwo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjFojvRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EC322242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30E68174B;
	Fri, 27 Nov 2020 13:39:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30E68174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606480819;
	bh=uitY12qTzJ6CCv8Sff1HVoEyGCJ5WaJc3uh+EFJw428=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nnocYTwoxDjSBIh89s5xK19rASlmlQzplqF8dTdiysW+i1gCMNjRwKQip5OaNw780
	 hPd8bMH1ow9xX8EwP5uQi4oxI1uDAq4xm60tLWk4n1n/ZIu+tgJDGLnhPcnO7CJbSk
	 +oqxM2BIv8faylVlbN4twBAT35zCuDnApIVVL2hI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9383F8015F;
	Fri, 27 Nov 2020 13:39:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1135EF8019D; Fri, 27 Nov 2020 13:39:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98362F8015A
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 13:39:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98362F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kjFojvRH"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2A0322240;
 Fri, 27 Nov 2020 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606480762;
 bh=uitY12qTzJ6CCv8Sff1HVoEyGCJ5WaJc3uh+EFJw428=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kjFojvRH5W2864LJMjgV8LXoFhjHdTqCBxc64tYibo7aT9tPtIENd2Ja4CWpa4a4W
 IPG0FUzwTPM9bFCAUIVq7rWxHoBH8l3UVC2DTZlBPfvdy/KptFKTB/tbqlBE6RuV4h
 xaa6D5AHgV65Ab1gaN4BSiafN5cRy5AsZCzVEGbE=
Date: Fri, 27 Nov 2020 12:38:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH] Asoc: qcom: Fix for problem in resume with CRAS
Message-ID: <20201127123856.GA4845@sirena.org.uk>
References: <1606450323-21641-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1606450323-21641-1-git-send-email-srivasam@codeaurora.org>
X-Cookie: All work and no pay makes a housewife.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, bjorn.andersson@linaro.org,
 agross@kernel.org, srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-kernel@vger.kernel.org
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


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 27, 2020 at 09:42:03AM +0530, Srinivasa Rao Mandadapu wrote:
> To support playback continuation after resume problem in chrome
> audio server:
> Prepare device in  platform trigger callback.
> Make I2s and DMA control registers as non volatile.

What is the actual issue this is fixing?

As I have previously said please submit patches using subject lines
reflecting the style for the subsystem, this makes it easier for people
to identify relevant patches.  Look at what existing commits in the area
you're changing are doing and make sure your subject lines visually
resemble what they're doing.  There's no need to resubmit to fix this
alone.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/A82AACgkQJNaLcl1U
h9A/7Qf/c6x/s5ZWRfoB7c+m1pakjVu2TQcvsEdS0xLz2/SldOq2hhGP0dW6gXca
4brb3HK8lDaIwnlbk3N27mGDUObmzte/41ZJ/Gx0HNIqN8oU7dEgO+AEU+XJ+bnO
cFBy1NhWu2ZnC33hkVxeyJSzDg0hT2pTE+rOoCRog0cgWXlsGfQW/OJONyTdVfeX
g+LnVrLafbO4ERJRlYICy1Ibj8ongorQVPPGU3OoB1fq4cMXvO18NMi7pg/dFH/q
YqzP2l5jrH+jiugbzniHHcvnkqVFta8BfKcxZqeXfDKT6Cv3vtT6c/k++/Guzq0V
J67riGm4jZB7+pEneGlM4ZSQr/mmng==
=YJfA
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
