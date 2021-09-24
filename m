Return-Path: <SRS0=QEGn=OO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1BC433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 19:54:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47D3610EA
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 19:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D47D3610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBF7515F2;
	Fri, 24 Sep 2021 21:53:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBF7515F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632513264;
	bh=OiUNSvyz1EmRMT6R0d225VbFfig+V3m7VhUGcuw4VSI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=heT88vFNCaz1YxLz++H0CEuEAubuda0Yj9IRd5zU4oPIjv/QZYJRfstZIX7r3e1Vg
	 PH6x5rd4wd2AMNBMpcuH/li9aSpSHVx0gaxiCZ2zMMx5u2DkXlAB7W89LJHrk+QMup
	 5jcj19GOLpOc/UgAop50WAaA8+7wkq/Dt4Lsasco=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77110F80246;
	Fri, 24 Sep 2021 21:53:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3310F802A0; Fri, 24 Sep 2021 21:53:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04C86F8013F
 for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2021 21:53:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04C86F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N3f3aqmu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8332F61038;
 Fri, 24 Sep 2021 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632513202;
 bh=OiUNSvyz1EmRMT6R0d225VbFfig+V3m7VhUGcuw4VSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N3f3aqmuSdtpAUcVRlMrrnbJhmOFDigpqDxd+iSYSYqwjUCkAmn0+jRsJwan2Ppxf
 hviAEgbxDztt8k76I5aVQfn8m3XH0A2EBL4T9S8M6ApzvyCLGHGY/FRpY3ILA8qYGe
 2VN5I6E4+rdHnQVQsZBq1bM47fpXCGMAJ9sav6GxRTUrxF6C4pxxZjmBE/nx9a9ET9
 mAigVuR77nuvxdjwV8mzx8acamQUdGk4okvhLCllZDQmpIVW0Hh7KCHtj0wUO+4Sf7
 AwonHJAsKj76Q8L8/nLoOygFQ6PCxwKUA2V/E9fYzLXQRG3bdQjanL9f8DCVCAkhnI
 gZM7LPD3+Z33w==
Date: Fri, 24 Sep 2021 20:52:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 4/4] ASoC: SOF: Intel: hda-dai: fix potential locking
 issue
Message-ID: <20210924195235.GC4840@sirena.org.uk>
References: <20210924192417.169243-1-pierre-louis.bossart@linux.intel.com>
 <20210924192417.169243-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <20210924192417.169243-5-pierre-louis.bossart@linux.intel.com>
X-Cookie: Are we live or on tape?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>,
 alsa-devel@alsa-project.org, vkoul@kernel.org
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


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 24, 2021 at 02:24:17PM -0500, Pierre-Louis Bossart wrote:
> The initial hdac_stream code was adapted a third time with the same
> locking issues. Move the spin_lock outside the loops and make sure the
> fields are protected on read/write.

Acked-by: Mark Brown <broonie@kernel.org>

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFOLIMACgkQJNaLcl1U
h9AOMgf/RYBFy/HO4bFG0l/70FU7ghrDVLBNnmQZ8R+7ttOfcQA+hwVhdbgnu0t0
9XBb2urtCe04uF43ARfgH+a8oWZIalofJuGO1TQQuvrOoa2gxNYgzw8q9tu7VI4j
E4aP5+dz5qZSj1GKAchd8KbgWrhLIypqT1oyAcE0KOf5Io5R9xJwjMZBptYBR+uj
5zj7gIzrtH0G297CALRFfpSExS4KvX3NhJAO5qPhBH+5sSnAocjPP23gVZInJlVm
7rEcrwLvS0PcQHMcsj98U/g3hPBzZ3tHODGeXHQ/0b6c/LIpU+3YI9hYjVeKumVe
SNT6jK3TEnTOeebyrkZwIyMszppojA==
=27yg
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
