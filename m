Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42588C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BDE20720
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pUnPtw+W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTlBmaBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BDE20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C33B846;
	Mon, 29 Jun 2020 23:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C33B846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593464576;
	bh=Jw99Eln4NR27lYmsha0rb9lBLDgygQ3OKHxN8L1UuhE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pUnPtw+W4qxRO4l1qlzWbHIdUTrpnbkFUWdgel9QXXY+t2pZFoVNG3GXsVKgBQcsD
	 0ZQYORE5OJcGdcyHPaCIbOuhwESQnhE/6RRUSaElv+u4zA8A6tJ/VUqF3znNEYMQgk
	 x0lHf0j5tCd8dHokc8ZjwswDMqaEMdve0HWry2LI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7AC4F800BA;
	Mon, 29 Jun 2020 23:02:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC010F80217; Mon, 29 Jun 2020 23:02:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9F0EF800BA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 23:02:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9F0EF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XTlBmaBb"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 11AE2206F1;
 Mon, 29 Jun 2020 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593464518;
 bh=Jw99Eln4NR27lYmsha0rb9lBLDgygQ3OKHxN8L1UuhE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XTlBmaBblASOOrx2JOf1ND5MBrcooAgX1RFnuD47aYtC5ucJpwAmpdx0lqFwgGZVv
 HMIPC492C53ey1t2J34bV8OB0xi8D+dSFdexEvPl+9VsJmIwF49mh2p7iKufiUnZbJ
 DHYXm1HJcWjXy3pBmx2kKFB0sm/4xNPn22Qpck4c=
Date: Mon, 29 Jun 2020 22:01:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 5/6] ASoC: rt5670: Remove struct rt5670_platform_data
Message-ID: <20200629210156.GP5499@sirena.org.uk>
References: <20200628155231.71089-1-hdegoede@redhat.com>
 <20200628155231.71089-6-hdegoede@redhat.com>
 <20200629200904.GK5499@sirena.org.uk>
 <25d7879e-8e6e-40db-78eb-c8dc150d6264@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RtGa12sjXv8gVUZO"
Content-Disposition: inline
In-Reply-To: <25d7879e-8e6e-40db-78eb-c8dc150d6264@redhat.com>
X-Cookie: Real programs don't eat cache.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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


--RtGa12sjXv8gVUZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2020 at 10:24:01PM +0200, Hans de Goede wrote:
> On 6/29/20 10:09 PM, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> Did you try to apply this to your for-5.9 branch (I know that was
> my own suggestion) ?  I must admit I did not think this through,
> this patch depends on some of the changes made in patches 1-4 :|

Yes, and on a merge of that with the 5.8 branch.  It's probably a
conflict with Morimoto-san's work.

--RtGa12sjXv8gVUZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl76VsMACgkQJNaLcl1U
h9By9gf/XBSb5D/4u5TLT75j4AJBwazXuP3kLqe0/oc30SgYom0HlunNTF/1hkZh
erDJAmp/Z44HHxadZe4eL1raxNTmQUCBsQvpg4xP16fjHgRWWQbVYpw0hQmkDFHa
FwHH810bh6tbG6BX5sidrCkQgDyvVoIQtyIfGCcbjbVkvHLTfrjeQ1YtqDCoUEu6
bxLwXCC+82PQ46Oz3uYbXNkIO1G9FSnlePySuDv3x1hediAM35mlftAdwsSHjC6f
0qDTb9lV18Pezuz0f6zOrVqVdTlInQ9BH6mR/mtIBOV+QOjsWEEkPGl2w9MVUqE0
ZyogGSe1EHskxmf9vM0YeoShb8fOow==
=Ujz2
-----END PGP SIGNATURE-----

--RtGa12sjXv8gVUZO--
