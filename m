Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918C7C38142
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Aug 2022 16:18:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85C0B1694;
	Fri, 19 Aug 2022 18:17:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85C0B1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660925901;
	bh=fYbbixQzFSgK8Zrf2Q4oayPQY0+/7tILkmGXy06F5qE=;
	h=Subject:From:In-Reply-To:Date:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBIqYTDYf3mH0iTFXGYJZwAQ20G9jDKTwsKoyznnjAKDAtGbLxT249Kqr2UWoWPt0
	 BDtD1aa9RnG2M7KGM+Q58po6fxm3KjfAjvVd5Tex14JkPrYMIfnbq6C+10uMuxt/8x
	 8FrX8/BpUzX8969QlNUh+zrZ4MFuHfuuEzQFnv1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DB4DF8016C;
	Fri, 19 Aug 2022 18:17:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AA84F801F7; Fri, 19 Aug 2022 18:17:29 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2275FF800B5
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2022 18:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2275FF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="YyQhcY9i"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1660925846; bh=fYbbixQzFSgK8Zrf2Q4oayPQY0+/7tILkmGXy06F5qE=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=YyQhcY9iV+6S/hW90dZdmO3eYQE43wxMXuDx8ZnZiUbWmL9kZK59NjYQTLPh7GdO1
 o/b9VHtbfColUtJzYo2QKJGep21V+i4kF3GPn8ldU5fGeBLw+IOb7IvwInb6mC0NIz
 AWGuT2/bFRWodIoxphNOhYjwT4DFQeKruWcI3UHE=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ASoC: ops: Don't modify the driver's plaform_max when
 reading state
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220603112508.3856519-1-broonie@kernel.org>
Date: Fri, 19 Aug 2022 18:17:25 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <4507B606-8424-4820-A8CE-F79BEDE5181D@cutebit.org>
References: <20220603112508.3856519-1-broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
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


> On 3. 6. 2022, at 13:25, Mark Brown <broonie@kernel.org> wrote:
>=20
> Currently snd_soc_info_volsw() will set a platform_max based on the =
limit
> the control has if one is not already set. This isn't really great, we
> shouldn't be modifying the passed in driver data especially in a path =
like
> this which may not ever be executed or where we may execute other =
callbacks
> before this one. Instead make this function leave the data unchanged, =
and
> clarify things a bit by referring to max rather than platform_max =
within
> the function. platform_max is now applied as a limit after working out =
the
> natural maximum value for the control.
>=20
> This means that platform_max is no longer treated as a direct register
> value for controls were min is non-zero. The put() callbacks already
> validate on this basis, and there do not appear to be any in tree =
users
> that would be affected.

At least =E2=80=98put_volsw' seem to validate on the other conflicting =
interpretation
of platform_max [as was introduced in commit 9bdd10d57a88 (=E2=80=9CASoC: =
ops:
Shift tested values in snd_soc_put_volsw() by +min=E2=80=9D)].

Also, the soc.h definitions of SOC_SINGLE_*/SOC_DOUBLE_* set =
platform_max
to the register maximum, again interpreting platform_max the other way.

>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>

This commit breaks controls with non-zero minimum.

Best,
Martin

