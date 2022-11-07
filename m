Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CC1C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 13:02:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26BA082C;
	Mon,  7 Nov 2022 14:01:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26BA082C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667826151;
	bh=8+c6psCy/ONoLcYN2dYmcBN/EJD5IUKyayz1VRePUcI=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSVHbGb+sh2UeY8TTm9mZq0F1PayAjm1MPeCfJtx51wsFjHDeyAoImun4qG8K1uq9
	 eqsEtbWJNXAD80f43fhoO9eIkzQXOxuohay1+Qf8x8BesKRurXcNb3Nho2Usoar2sm
	 JaR1l75+zOQOiGQDjQuc9uJRJhjmCv2HqqY98cxw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6613F800EC;
	Mon,  7 Nov 2022 14:01:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D3CDF8025A; Mon,  7 Nov 2022 14:01:38 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D64AF800EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 14:01:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D64AF800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="iOPNyAbZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1667826094; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jg77whTZveEoQ4sEVKCo7IpSsBmp7pePPNkjnV6eYEg=;
 b=iOPNyAbZkJoMiPOsLg/c6jtp5DOovGsw0OK1QlusFqCJaikvF+7HoqshP/uAVBPlS6jsEC
 6W7tjsyTGC8MvWDJNXqq7zqdxUcd9rYNWbWdouEUQIL/1TE3OGMAeq9x224hILegRFdApk
 M6HBKtP3l9TPbqVK3CUeD2aNMlXvrVw=
Date: Mon, 07 Nov 2022 13:01:24 +0000
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: dapm: Don't use prefix for regulator name
To: Mark Brown <broonie@kernel.org>
Message-Id: <CUAZKR.FFCM32N7ZV5C@crapouillou.net>
In-Reply-To: <Y2kAoV8gCEZZgHhk@sirena.org.uk>
References: <20221025150149.113129-1-paul@crapouillou.net>
 <166680764848.867857.6473365992161385316.b4-ty@kernel.org>
 <C32ZKR.QZWY19EUAOMQ3@crapouillou.net> <Y2kAoV8gCEZZgHhk@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org
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



Le lun. 7 nov. 2022 =E0 12:57:05 +0000, Mark Brown <broonie@kernel.org>=20
a =E9crit :
> On Mon, Nov 07, 2022 at 09:52:24AM +0000, Paul Cercueil wrote:
>>  Le mer. 26 oct. 2022 =E0 19:07:28 +0100, Mark Brown=20
>> <broonie@kernel.org> a
>=20
>>  > Applied to
>>  >
>>  >   =20
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>>  > for-next
>=20
>>  Small reminder that this is a fix for a bug introduced in -rc1, so=20
>> it should
>>  be queued for the next RC.
>=20
> This is already queued as a fix.

Ok, thanks. I didn't see it in -rc4 and thought that it was queued for=20
6.2 instead.

Cheers,
-Paul


