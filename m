Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0BCC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 12:02:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA368B7AD;
	Thu, 20 Oct 2022 14:01:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA368B7AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666267349;
	bh=mk0ghXVJ82W9PVouSAurUXTT68SJHNJhNTEKYzoATrM=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aQsiSRZQVqWKaFX5MfjyEZ4dN/rWlPR2cZtfKXveQgswCCojL5Jxbpda0vhdjatLS
	 31df4XhznfpusLiF/TUKO6IliYr8gm5vXL0o0ZcdWF7alD7QdNPP1Nfi7W2ERDN7Tc
	 sO7PkF91JEZerTGb37LUx7eUT2ur4CqoJOwB8o2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B89BF8032B;
	Thu, 20 Oct 2022 14:01:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A76FAF804D8; Thu, 20 Oct 2022 14:01:37 +0200 (CEST)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F7EFF800B5
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2022 14:01:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F7EFF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net
 header.b="L18CzQrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
 s=mail; t=1666267294; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYZkMXb8cLrbAN/CA61ncAdPT59/Ov5LSx67xqlB97U=;
 b=L18CzQrw7V+n4B5ZpLcqlPBG/6rfQV04LgnOvTJ6SITL6SqOXJRru6HOVr7mXV67vKz82z
 XisgI6GBSkwD0psBpHRV63JFijaOkmotWJ+2CmYYyJROkxz0cnFCqb5LyiUdPGHnvZiijV
 /MNpWHEOKupv92NNGocYJSSrpCBQt3U=
Date: Thu, 20 Oct 2022 13:01:24 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 0/7] ASoC: codecs: jz4725b: Various improvements and
 fixes
To: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <C2W1KR.XY3W8ZXSCSAD1@crapouillou.net>
In-Reply-To: <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com>
References: <20221016132648.3011729-1-lis8215@gmail.com>
 <166609251307.155136.11548088283059583394.b4-ty@kernel.org>
 <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-mips@vger.kernel.org
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

Hi Siarhei,

Le jeu., oct. 20 2022 at 14:58:51 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D0=B2=D1=82, 18 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 14:28, Mark Brow=
n <broonie@kernel.org>:
>>  Applied to
>>=20
>>    =20
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20
>> for-next
>>=20
>>  Thanks!
>=20
> Great! Thank you!
>=20
> Unfortunately I found a critical bug in my patchset, yet easy to fix.
> So I need some help to make and send the fix.
>=20
>>  If any updates are required or you are submitting further changes=20
>> they
>>  should be sent as incremental updates against current git, existing
>>  patches will not be replaced.
>=20
> What are mailing lists it needs to be sent to?
> Any additional tags needed? I know about Fixes tag.
> Do I need to keep a link on this patchset somehow?
> Do I need to mail a patch with the fix to this thread or
> create a new one?
>=20
> PS: the patch will look like:
>  - {"ADC Sourc Capture Routee", "Line In", "Line In"},
>  + {"ADC Source Capture Route", "Line In", "Line In"},

Somebody already submitted a fix.

> Thanks in advance,
> Siarhei

Cheers,
-Paul


