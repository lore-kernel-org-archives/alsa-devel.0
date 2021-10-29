Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF438C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 15:23:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E3060187
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 15:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10E3060187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F48F16FB;
	Fri, 29 Oct 2021 17:22:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F48F16FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635520998;
	bh=K3N5Az/gCC0BKAsrlVXDoRH6GnWNwjX21xmwxUaiu4k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDEPyhk5YicUcp8uVSWEm2tbQ48CDr2mzF9ZjVwvyQSebv/drIUZ6IA4Gs/J5XR2C
	 02sPZxC/et9I3qvT5PDRxyqA9BdlvgK7V1cbg+kNIn4oLbKycT7hghYKMVF6aGIn+u
	 AhahK6dzyHGM3A9bK6AQP+E8yh7KXkg44Ind3MeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 191C5F801EC;
	Fri, 29 Oct 2021 17:22:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6AB7F800D1; Fri, 29 Oct 2021 17:22:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EE29F800D1
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 17:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EE29F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tBBp5Tys"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B48B60F55;
 Fri, 29 Oct 2021 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635520934;
 bh=K3N5Az/gCC0BKAsrlVXDoRH6GnWNwjX21xmwxUaiu4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tBBp5TysnpZ7a3l8x+KecThcE6UPsz1Yy5AaHXezyrazZv6bk1dm0HM47XK1rv/B+
 R4bGIYF0UGrY0f9OpnZZAKztniaDQ6e51sYkwXAcvLvoL/SDZT8a0bjoXfxK/mZUHn
 /A/yqMQV2oopFAEAPiesebYEL1DQQIYDTDGKOuabxBbO6lyQqQKge1IHNtDXiPW03o
 b+pZoU/1o0HdiVIJpJbQox7Hm0jJ0zifortCdbj53jjcdP027cg7Gg+TKQQQckd3pf
 kF2G3swH+3BcQmsSE+lpjxz9QaM4WIH8RZ0aVOVbq89eKuJBDG5wJkxAq6mp59G4OB
 edUELgF64F0ug==
Date: Fri, 29 Oct 2021 16:22:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] ASoC: tegra: Add master volume/mute control support
Message-ID: <YXwRoWPF+ctNJRyp@sirena.org.uk>
References: <1635159976-17355-1-git-send-email-spujar@nvidia.com>
 <79541c76-2c2b-fd4b-60c8-67ee6b8ea3fa@perex.cz>
 <8cb777f9-b73b-136c-f560-de4c31af931e@nvidia.com>
 <18b61046-ac0b-0fb3-669c-6524a03eecf0@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FzXysqnWhsplUAtn"
Content-Disposition: inline
In-Reply-To: <18b61046-ac0b-0fb3-669c-6524a03eecf0@nvidia.com>
X-Cookie: "Just the facts, Ma'am"
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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


--FzXysqnWhsplUAtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 29, 2021 at 08:38:54PM +0530, Sameer Pujar wrote:
> On 10/26/2021 11:53 AM, Sameer Pujar wrote:
> > On 10/25/2021 6:28 PM, Jaroslav Kysela wrote:

> > > It's a bit unrelated comment to this change, but it may be worth to
> > > verify all
> > > kcontrol put callbacks in the tegra code. Ensure that value 1 is
> > > returned only
> > > when something was really changed in hardware.

> There are cases when the mixer control update is not immediately written to
> HW, instead the update is ACKed (stored in variable) and writen to HW at a
> later point of time. Do these cases qualify for "return 1" as well?

What matters is the user visible effect.  It doesn't matter when the
change gets written to the hardware, the important thing is that an
applicaton will read back a new value and users will observe whatver
change the control change caused.

--FzXysqnWhsplUAtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF8EaAACgkQJNaLcl1U
h9AF8wf6Au6TOBbNtZfeRJ7HMsQ6sHTIYNis+bR/zS8cVSqlPF4sFhOLkx1Vk921
mFw6qqrRgTXdq5mJSUXqgQwgl1KFxfFiJyzI2b8j7sz+AEhTzcx51ZFD+teKzejw
QWoiOHtK6cS7fq9PAXVMaLnq0zA1EPCTU7sMDPb0xaJS1G+sFBULEEXnucT4UFPi
+aoQQ4SY8C1OCdT5MOFjhr79jeH0WTUa6RgkmhE5/mdqUF+6+yg7TTSwVETcaMk9
3muMn/+qPURk/qT7wZ6KxQVkut5/5hhPHh23MuusFzM+SkAchrIgeho+nvrsKWDZ
Zb3dE2wfxyWISHnG+Bo0iIepB8PrwA==
=QxNz
-----END PGP SIGNATURE-----

--FzXysqnWhsplUAtn--
