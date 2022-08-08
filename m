Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16933C25B0C
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Aug 2022 16:24:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72591829;
	Mon,  8 Aug 2022 18:23:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72591829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659975882;
	bh=XjThV4rj1Nh3GCLFRepWBhK3akKLDUOxgagEgZfGkBo=;
	h=Subject:From:In-Reply-To:Date:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lHNe8ixZrv0GGfjbM6+GE40OiBDnFsjGLDGw0fIJiDGs4HVCov28NbZKk9Knzm9Xg
	 eTpKaWxuf6MjOWZcgfA1IpZxC3WPp0t+yCQWoYSEC1TKLWvquhoeEqIPa/uz3rZ39s
	 kw480rLHDWB3Jl8oCrN82k3OFn+15rnnU6ln9PvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10A3FF8012B;
	Mon,  8 Aug 2022 18:23:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84293F8049C; Mon,  8 Aug 2022 18:23:50 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77BCAF8012B
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2022 18:23:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77BCAF8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="bz3u7r7W"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1659975820; bh=XjThV4rj1Nh3GCLFRepWBhK3akKLDUOxgagEgZfGkBo=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=bz3u7r7W0i2JsYPYwf4vglkvFsht2OVepruISNFBI6ZjSIBIDrwIoICd2o+w0W5yG
 AfXCTtEdC9HNWuZnIz6I082tJHcMv3FRucwiv77PMq9UMOiEZF5wjEGx5126LdMJVM
 zp5nWmmGvXEvV7EBIpkfZXQ3BmJH96bJtYSygvcw=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 4/4] ASoC: tas2770: Fix handling of mute/unmute
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220808141246.5749-5-povik+lin@cutebit.org>
Date: Mon, 8 Aug 2022 18:23:39 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <906CDD19-1894-4106-959D-B2444036168E@cutebit.org>
References: <20220808141246.5749-1-povik+lin@cutebit.org>
 <20220808141246.5749-5-povik+lin@cutebit.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Frank Shi <shifu0704@thundersoft.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Kitt <steve@sk2.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 asahi@lists.linux.dev
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


> On 8. 8. 2022, at 16:12, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
> Because the PWR_CTRL field is modeled as the power state of the DAC
> widget, and at the same time it is used to implement mute/unmute, we
> need some additional book-keeping to have the right end result no =
matter
> the sequence of calls. Without this fix, one can mute an ongoing =
stream
> by toggling a speaker pin control.
>=20
> Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>

Ah, should have written the end of the commit message clearer...
What I meant is, if you toggle the speaker pin, you mute the
stream permanently until it's restarted, since toggling the
speaker pin back won't recover the PWR_CTRL_ACTIVE value set in
mute_stream at unmute.

Martin

