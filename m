Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA61C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 13:22:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB8064DC4
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 13:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB8064DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 709CF176A;
	Wed,  3 Feb 2021 14:21:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 709CF176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612358563;
	bh=Da4M1bnf1Wqx12eiTUgDdPCdruKdDYCPyv3ytTn0Apk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFvt2km4KVL/vmm4gkAJ8GhNj3h3UvLxMnFQX9zilYsehP5sdVJRK7hjGunDS+iAG
	 XwD+2IMYOkjU4fYCr0zWyZla3zd+CPesMULooopuVhRc381UfbZcBU/iGN9QzzpicF
	 c5RB5GqRNd9REuDPIsHd/cnPLeop8L0UzHdh0BEY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E3ECAF8013C;
	Wed,  3 Feb 2021 14:21:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A829FF8015A; Wed,  3 Feb 2021 14:21:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D46F5F8013C
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2021 14:21:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D46F5F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dtcpod9M"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 362F864E38;
 Wed,  3 Feb 2021 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612358499;
 bh=Da4M1bnf1Wqx12eiTUgDdPCdruKdDYCPyv3ytTn0Apk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dtcpod9ME1FXG3N24V04PY+nY2vROgeKptqjMgrKti7aX957Ip/v3YdTpvJ00yNjq
 nBOLzSyyCh2P1ugeIJgKeXGK8iydKO6UEiic5I3j1xi3mAxqe2cnGZtBCyXI/dFcp6
 jrfveRwAYmW6TLrEdhnXMk2HNOZkveYa+9TWUrOPs/cv2PEncnBW5NvuBOSCRg0csq
 8AQfaQ0q0bL/+t4p2DM6y9dZgxvzXIf/ahDi1Sh5JjWMHQh3JMjvlxXfnFlGUILQ5+
 lAWbazIcoLd0mCEMhXtrkIPIhgncPxyiRGLQswOj6N3vju/SgRqvJ1GRV2Fe5TVXJT
 PHeM32wXPna2w==
Date: Wed, 3 Feb 2021 13:20:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Argus Lin <argus.lin@mediatek.com>
Subject: Re: [PATCH 0/2] Add mediatek MT6359 accdet driver
Message-ID: <20210203132051.GC4880@sirena.org.uk>
References: <1609935546-11722-1-git-send-email-argus.lin@mediatek.com>
 <1612335462.9202.1.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <1612335462.9202.1.camel@mtkswgap22>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 wsd_upstream <wsd_upstream@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jiaxin Yu =?utf-8?B?KOS/nuWutumRqyk=?= <Jiaxin.Yu@mediatek.com>,
 Tzung-Bi Shih <tzungbi@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 ChiPeng Chang =?utf-8?B?KOW8teeQpuaciyk=?= <chipeng.chang@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Dan Murphy <dmurphy@ti.com>, Shuming Fan <shumingf@realtek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jack Yu <jack.yu@realtek.com>,
 Shane Chien =?utf-8?B?KOewoeS9kei7kik=?= <Shane.Chien@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2021 at 02:57:42PM +0800, Argus Lin wrote:
> Dear maintainers:
> Can you reply to me if any opinion?
> thanks

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

IIRC I did review this...

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAaozIACgkQJNaLcl1U
h9CrKQf/acfnUSuQONwN1RT/hy5GX9WSF9RkgE8dip0te22amV9V/s7zWzNqGtcA
4CaPqT8pSNN975HVcr388zMgdi/wa7g3n6nnGYWcIlFwVncCuxcGiUqxMzqqKk8p
xAPDqZibzPj5RWoFkNdJo9QLiKi04GGNPliTcHRYxrvFtr5m8MZRLQI7yRIUjOT9
pxe+CscoJ8p3Gadbi4ZH95aRDIqy//hStJKHn2YRW5vXlCNJkbXKRE78iWJo4//4
Ll2vLjZeS3fBxflFSkk8Tqcl6LhN5zp1Le/6qE1oHVWmRiKTqPc1irYFKs1iBZI/
1ioNJnhOryevfmraD/TUdCB+xN3z3Q==
=Hlk7
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
