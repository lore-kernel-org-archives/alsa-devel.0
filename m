Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37955C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:27:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20ABF208DB
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O/59Lk1Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI98EtFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ABF208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 909FA846;
	Thu, 17 Sep 2020 13:26:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 909FA846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600342059;
	bh=1REolYqVV8SGvPF5UD2G78a1WkBenbRyijFOsV6z6qQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O/59Lk1Qw5UHjCz75hzQP1VuOLofg/A98uSUiPKB0AUpXJqItXUKsW8VQ5SIxxqZq
	 a2A9x9xLu0ezQIaJTL61ehEvf3YREn66dcGJn+Do8Pl8mBqCp1YGMgZgCt+zp+1gdx
	 fHWl7M/TCPxEUXhMjKO9AEAvo8tkZovBnXTkGobU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2339BF80134;
	Thu, 17 Sep 2020 13:26:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF06DF800E8; Thu, 17 Sep 2020 13:26:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F0B5F80134
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 13:26:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F0B5F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZI98EtFV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B93B6208DB;
 Thu, 17 Sep 2020 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600341997;
 bh=1REolYqVV8SGvPF5UD2G78a1WkBenbRyijFOsV6z6qQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZI98EtFVBjwNvSvjHCrcRHO+oHyuWPk1bTTx/qfFSxcfKYFh8DqqEFs1HsVtdD6ax
 6t9MvWfMpl1fZV20dfxcQ6dTVzZc8Sbk8j9ZJkH9bwCdRkLn7HTSO29nOFdWz1svCM
 Zw9DAzicsFvdscfYux/zFMrdpprtJi/JQ87saOSM=
Date: Thu, 17 Sep 2020 12:25:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt715: Add module parameter to fix dmic pop sound
 issue.
Message-ID: <20200917112547.GC4755@sirena.org.uk>
References: <20200916204758.53651-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20200916204758.53651-1-pierre-louis.bossart@linux.intel.com>
X-Cookie: If you fail to plan, plan to fail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jack Yu <jack.yu@realtek.com>, alsa-devel@alsa-project.org, tiwai@suse.de,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 03:47:58PM -0500, Pierre-Louis Bossart wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> Add module parameter "power_up_delay" to fix pop noise on capture. The
> power_up_delay value is set with a default value of 400ms, smaller
> values are not recommended.

Normally we would just add a delay in the driver unconditionally, why
make this a module paramter?  If there are board variations then we
should be getting them from board data, not forcing individual users to
bodge things with a module parameter.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jR7oACgkQJNaLcl1U
h9BY0Af+MMVoybfEhTjfMa8Wc+B0QU9lgtKYVUeMfUJnYN9ABRjBo7HAESC66eCm
zaYyYFtkPWHqiQJrQYZ4nHRxk5Bq2yekZnYN+jYEzYtMiiz2PBedaLg4G00c+ZTr
yNpEv/MrnN8VmAxEzB1KJPNVZLPiNIanbwMomwW5Dx3sUe0O9JEWSGT6SXcYV2X4
XdLWn7aKIdpRnAEy40osf5cQg3aEbcLW1nQF9jaU1ZQ5Xlvw/9FXkw3U4X9rI0eD
I32g4auqx9mN44soUw4++fzy9b4FiY4R40zFIi7uQse0qp8Urh3wKvedsloC5CjV
a4AJ7wuMEbfqqrvt5usyMj0UhAk97Q==
=yhXE
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
