Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2215DC4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 18:40:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9538F207AA
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 18:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9538F207AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89F1216D6;
	Tue,  8 Dec 2020 19:39:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89F1216D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607452808;
	bh=SH8ruAFl9jUCCAhsRUJAAMbvBmAUVYhpQwv26QF0em0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Upcm3LWnXwdwwiznNQqvdxJoDox9BI37+JT3a2UWnLpsdkJUPgYbyjqyIXevHsKr2
	 9SCKuGRr5WBSGzDsctVWEhT48oj0xc/cncm3d3La+N/fbdoqyQ6qVCnxYJrae8ks7/
	 iztPfyvt5SaMx1tOvK/SyJwJWCXDmMATFQ49YPro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C55E7F80130;
	Tue,  8 Dec 2020 19:39:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7A0EF8019D; Tue,  8 Dec 2020 19:39:15 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82035F800E1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 19:39:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82035F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Da6g3gDO"
Date: Tue, 8 Dec 2020 18:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607452749;
 bh=SH8ruAFl9jUCCAhsRUJAAMbvBmAUVYhpQwv26QF0em0=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=Da6g3gDOLoOK5iovJJl1fxSe5Xoje1sXnHfnk/femaDTDrkMnVMCFrBmZv0kv5y6M
 TLhpzM1FyTZSX1jIS0BOCtAJ7rYptHuMZIh1YLDBE1xXMTdN1TeGC21LtYEMhwrWCh
 f67wjhRaBADVuXyY07DxEYaHbCmPcaYUslsYsnWvGQv7RYtEK9/tQIyJUgeXWcsrAb
 DY14v1vkunXepIqfrqL9JyyQUZ9CJzblo5qbTeXX1SVLFEB1tOG8SeMJn61TdXd+I+
 LI3tWv0wOvE5UQ42UDsLBbUk0VSjtzSPVtXJIHKjjfSpkyFij+Da+pWjxlr2Opv1t1
 RMXVtaXP7WyGg==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: AMD Renoir - add DMI table to avoid the ACP mic
 probe (broken BIOS)
Message-ID: <20201208183901.GI6686@sirena.org.uk>
References: <20201208153654.2733354-1-perex@perex.cz>
 <s5h4kkww9j3.wl-tiwai@suse.de>
 <20201208174002.GH6686@sirena.org.uk>
 <2e4587f8-f602-cf23-4845-fd27a32b1cfc@amd.com>
 <s5htuswuqng.wl-tiwai@suse.de>
 <2c48dcdb-e8c8-ca2e-e004-4e63887788c5@amd.com>
 <098fa0b7-5493-f3e5-afd5-8296d4300590@amd.com>
 <7d7d93be-e5b5-6022-0977-b82943d10993@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <7d7d93be-e5b5-6022-0977-b82943d10993@perex.cz>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>, "Mukunda,
 Vijendar" <vijendar.mukunda@amd.com>
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


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2020 at 07:14:06PM +0100, Jaroslav Kysela wrote:
> Dne 08. 12. 20 v 19:23 Mukunda,Vijendar napsal(a):

> > But build wise both Raven and Renoir uses different Kconfig options.

> We need to build all drivers for the universal distros to one kernel. The
> Kconfig does not help here.

Yeah, even for embedded targets like phones this is getting less and
less useful over time - for systems with PCI like this people really
want a single kernel image for every user, not per-board images.

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PyEQACgkQJNaLcl1U
h9AtKgf9F2vSo3gZrgJVIHqoxsdEE4t1L7iYq0W5XfNXeIQZED3xl7DCCgmzfw7k
XRNj8gaQT7hP3JHldMOXAd5r1LwNs6g/a6gA2RrpzX160xYzvjAqOw9TX6UTDd68
ogttNdwNlBx54piPiUeeLmBtdFVvVUe5iEUF0zzUye6r3pk1R8fgIk5qea4wfZtj
DeuZXIqZ7TJWk7f69E+/plaFloP7WN1g2sn+WZUhlzsHe8vmbdOasif7UXR2FnHO
T8zSz7/X6bdKd2UPvuYhOpRvzStCsSGC9TA4ybCfXYTnliWEPK9TOa8hTp9WqJ5N
zMswbc1HjiC4RRsonZEEbhzwXIyhsw==
=s9R+
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
