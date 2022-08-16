Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D097BC2BB41
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Aug 2022 11:24:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AA72164E;
	Tue, 16 Aug 2022 13:24:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AA72164E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660649097;
	bh=MpG3kqpg769gPOmaRtZtYvtqJfHCGV4kwVNZYRXpgAE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ji9pHyo3YjE3VUxTuxdBlbF6MFw0zJzE6gt2WdanTySSX00xHirhvyCjzctOWbgVy
	 vgCd8vWItVbApkJnODT7F/jeN2a4Hk2dznRLWxcVJGNKiJIWL6dOrgD4MQb5WbLZlO
	 yocjjrHWU0p2A/YmQEj3otXvKE3WP3fyvD5HsVio=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B9FBF80095;
	Tue, 16 Aug 2022 13:24:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4746CF80238; Tue, 16 Aug 2022 13:24:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 137FCF80095
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 13:24:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 137FCF80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QMMvIGkp"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4C769611B1;
 Tue, 16 Aug 2022 11:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC8EC433D6;
 Tue, 16 Aug 2022 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660649040;
 bh=MpG3kqpg769gPOmaRtZtYvtqJfHCGV4kwVNZYRXpgAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QMMvIGkpOXLBXveZY5o2ZT7uIXXqgJdjAbmg5no8mdj3T1B4+Kc4cK4oj7QL8HQEF
 Is/Z01G/q4IN+RPgM1+rXOQcfkYJjF6LI/7NjyqQnSf5sikwCRRBrutdvWLs1xNlMS
 2850CVgAwXCE9BfZguhylN8lU0LtBQfXau189SQTRaUMDapD9FiKVEQzo1BG3+Oopu
 Ft3L6B8B9N6/+bsWBlseNyZdWA8OfCLAS81QjrJ8E7cnn7Op13/6d9aTjoxzHxEuGj
 2ZxKZlRgc3/sjHuPsmuBVG2nYQg0LAACz/zR/qFxo7ysgFOKEDBLwuPq2dVHDneU1G
 /2Zb0G7sHjMZw==
Date: Tue, 16 Aug 2022 12:23:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RESEND PATCH v2 1/6] ASoC: Intel: Skylake: Introduce HDA codec
 init and exit routines
Message-ID: <Yvt+S4pCmqloFaAA@sirena.org.uk>
References: <20220816111727.3218543-1-cezary.rojewski@intel.com>
 <20220816111727.3218543-2-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L8ZCm8/MLgr4CPkd"
Content-Disposition: inline
In-Reply-To: <20220816111727.3218543-2-cezary.rojewski@intel.com>
X-Cookie: A bachelor is an unaltared male.
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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


--L8ZCm8/MLgr4CPkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 16, 2022 at 01:17:22PM +0200, Cezary Rojewski wrote:
> Preliminary step in making snd_hda_codec_device_init() the only
> constructor for struct hda_codec instances. To do that, existing usage
> of hdac_ext equivalents has to be dropped.

Acked-by: Mark Brown <broonie@kernel.org>

--L8ZCm8/MLgr4CPkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL7fksACgkQJNaLcl1U
h9AU3AgAgisrJXookrNJsSfJ/EaynkGzQYO2nxBtXtd+qYfculKCCHc/zGdAcuoW
3OdBMKkbBqu2XSasbdEPY6ngxCffkJTYItVzwaLHaueeH388+Qdp24lfvRUjUk6j
UETyxngCokaf3J1OvOf8o1NMGfw7tDXkK4oGAFZjz0SvOclSuJCY06kw2FzGEc0W
vbqFBmmmVly1QAiYDgjZSdiCSJA1FWJBYdweSxZBfhoi+NVOFnzkoMytNEGNk/je
AQZ76s0fcSGxuRKXrCSjSH1Kvx3JiGTdq4ZlqFPoCMyt+4TFrKaMTvYQLTAn19nt
XaPs+jtFl6iJSYkWrZ/TrCN5lmDUHw==
=bKnB
-----END PGP SIGNATURE-----

--L8ZCm8/MLgr4CPkd--
