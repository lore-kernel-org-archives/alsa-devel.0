Return-Path: <SRS0=2FB+=BH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A2C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:56:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4656C2074F
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iVx2Hjs0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wphuh2vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4656C2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFA05170A;
	Tue, 28 Jul 2020 18:55:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFA05170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595955380;
	bh=rJVDQqY5WUvFsOu1EgRX9G1KnNLENwbxshwoQwQR3p4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iVx2Hjs04epFxnrriM9UcXgeaewD308kdhUhfC+JIOeJY1rvNTeluj5kA6fSlT4At
	 U216iRBT4hqOduEjxVgrHXpswoLijMRJ+T7Qp0BNAkrKbmUclwY8EKzlzdGBYeVHhJ
	 eJ4rWNOBCXBSmn8E/sGk0+k2nh5UsMrBCcKhFRzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47F50F8021C;
	Tue, 28 Jul 2020 18:55:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A27EAF8021C; Tue, 28 Jul 2020 18:55:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB36EF800AD
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2020 18:55:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB36EF800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wphuh2vg"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C20702053B;
 Tue, 28 Jul 2020 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595955316;
 bh=rJVDQqY5WUvFsOu1EgRX9G1KnNLENwbxshwoQwQR3p4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wphuh2vgRP2NmEjnKL/5WhUCKFXp+LcT7YqJVHmw80vzlb5hYsg1+TCnZNO1xijV3
 ff3mBUbM5YPw7DzfyjG55DZ5fKlsnV7zhOQm6hOxsiIaLs7EcdXUiB4yoQjM3s8ouI
 CBtWyKxHVMqPKp5uH2ReQkcjAPv3ltdxZ9Zb+XUk=
Date: Tue, 28 Jul 2020 17:54:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3] ASoC: dt-bindings: ak4613: switch to yaml base
 Documentation
Message-ID: <20200728165458.GC24701@sirena.org.uk>
References: <87y2nk2tfd.wl-kuninori.morimoto.gx@renesas.com>
 <CAL_JsqJ8PyuZLXj4bLwyConb+GdH83hjPPj2mHbqNy=w9m-joA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ8PyuZLXj4bLwyConb+GdH83hjPPj2mHbqNy=w9m-joA@mail.gmail.com>
X-Cookie: You will be misunderstood by everyone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2020 at 08:39:23AM -0600, Rob Herring wrote:

> I haven't seen any follow-up to my audio-graph-card.yaml comments, so
> please revert this.

OK, Morimoto-san please resubmit as a series with the audio-graph-card
when you get back to that.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8gWGEACgkQJNaLcl1U
h9DjEgf/flTiTV9yDbY8qM8OA6yHxLt7VbCKxsA1FUtPKBoCgMfbawzKmYcVLArI
aamcAdgU1VXbJivony07qipiIF2I4fND1DcK5h1tjgH4UmRGe/4geoZfSJ8xxlTJ
5FnL0ojGnsCuM2hi20XAFHBNoRAcAD0irnyOUR/HXrRA6N1r6Jlhih1tkP9FH740
FFZwwyGtlBZ09/nPdig1dzfkxqqtkgupTRxdBmaA3WNAFU9y5XL1QQ7Bhlu8f4yM
ibjmpePvAYbcUqIYp5q5VH6PgDzmhwUtd/mC2SGedAlVpq2kiocMgpnKbScApN7W
+iwbD1kRjKBsHeI4rCdUxkdAhMDnBA==
=Evbh
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
