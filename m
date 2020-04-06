Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89ECC2BA19
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:08:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C9E2072A
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M96z3BQM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vYBvA3+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C9E2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91EC2822;
	Mon,  6 Apr 2020 13:07:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91EC2822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586171283;
	bh=MW0KG31dJrppaZHP8FQnU1F/hl4SWfSAkuygfDdzRsY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M96z3BQM9XqKOoMrPQ7zihsZ2FzYIUshHVdPKRsnkWZC4DfNwTuYxO8iCS8jIZ/0m
	 kXfmjTzjjv+wWtqDYMYxdEbrCirTip16thJIl3Yb5JTBAcYRPnxGpf0DPMiOrkdQ6D
	 9cMr58INpoIEqjoFAR51bpLUsfDMQMEec0A9ldco=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC498F80142;
	Mon,  6 Apr 2020 13:07:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DCDBF80143; Mon,  6 Apr 2020 13:07:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AA59F80121
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 13:07:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AA59F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vYBvA3+s"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31DE6206F8;
 Mon,  6 Apr 2020 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586171225;
 bh=MW0KG31dJrppaZHP8FQnU1F/hl4SWfSAkuygfDdzRsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vYBvA3+sGFhq3yTKh+ucCBVysSRVEhv8kbTZ7mUax4BlKAv3D4fK5qjUXj7Z5gLgl
 TISEdcdQC4Yw6kKUo0xsMd21GDTjBeoWPMIjRqPbpl8tuQjZBP5dWfsAI/LfpptVzJ
 V/SAs1M5qygo+k2m9swv+YpL4hpf8/q5LkRknr1E=
Date: Mon, 6 Apr 2020 12:07:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200406110703.GA6837@sirena.org.uk>
References: <20200404115225.4314-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20200404115225.4314-1-jbx6244@gmail.com>
X-Cookie: Serfs up!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2020 at 01:52:23PM +0200, Johan Jonker wrote:
> Current dts files with 'spdif' nodes are manually verified.
> In order to automate this process rockchip-spdif.txt
> has to be converted to yaml.

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

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6LDVQACgkQJNaLcl1U
h9At1Af9FC3z9FsNzTwUOLATMox+yRod2jIFEGJXPViju4E8V2EuoclTbhXAgNQ+
HpPLozVdeSMKzCNs57EAKph0W6rKpkaGz5R9NliqRohe0OiQpnIhftVJMHawgqCl
0e0hzX3E+R+1hOa6R2BDTdTHuA+xk2oni8V6w/MW4LVuZZ13fl2Pxa2y5dOdp+ER
woZL3J56Q1b6NkKdYWyCMZgj/GfOb8FFVfC0Dp4BTQh0VO0V2KvwCdklmWXqYC8D
kkHkggw+t/98qhSUrBu+L4FvXYwc17OzhJszkbJWGLoA83ogbf12Nqm4X2ftyteA
p+R0xiHc+axQuwhe8ch0Ei0ZBAJxvg==
=VqFs
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
