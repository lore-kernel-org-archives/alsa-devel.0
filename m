Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA0CC32792
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 11:54:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C68F6E0E;
	Tue, 23 Aug 2022 13:53:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C68F6E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661255639;
	bh=3MyIj80qgAj9YHVDmfyBOskKxLFXfIREv97Wtqjbftw=;
	h=Subject:From:In-Reply-To:Date:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GMGoQeiGigKViqOK+/BQ065/pUt+ju82tmk/GYMBW2iZkK0syCJ5wAezyAiWGeqi+
	 mHUGI+JbOvYv1mYaebieTUIHNjERXx7He2aQJmUO8Zkv0VFz04a99AU3F37Cpey3zd
	 8IG4QTunRjq6EpXjXVJ3PGWHX6KOPrNOACHK8KBM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6311FF8020D;
	Tue, 23 Aug 2022 13:53:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A79EF8027B; Tue, 23 Aug 2022 13:53:08 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1CF5F800C9
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 13:53:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1CF5F800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="eLdFwguV"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1661255580; bh=C+qYzg3MiDGTFt2SnOj/uPYpItAq9KcnqTfZxJRJUvQ=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=eLdFwguVO9Al2h37zHcURvgU/NLAzSrE+FrlcUFVbpseZjBCnz261whssmh7FJT9i
 BstM7oxGbltfBT7yWA9I2Xm8Lkn/Kiys7OETC+MvkkPSy2/VSdohCFdS5NbTUjwbhp
 kyKhQq6uF2A91IWufZCGszTe/x9VdmYoDEYjfx7E=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 3/4] ASoC: apple: mca: Start new platform driver
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <6C89CA60-D0E2-4869-B21C-17AD4AA1974C@cutebit.org>
Date: Tue, 23 Aug 2022 13:53:00 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <E307FA6A-749E-450D-B200-4509848BDA69@cutebit.org>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-4-povik+lin@cutebit.org>
 <YwO/aqs7eqZx07kS@sirena.org.uk>
 <24C0ABFA-BF71-4492-8A6A-E9BE1462B403@cutebit.org>
 <YwS6lHeGH0BZKHeB@sirena.org.uk>
 <6C89CA60-D0E2-4869-B21C-17AD4AA1974C@cutebit.org>
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, asahi@lists.linux.dev,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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


> On 23. 8. 2022, at 13:51, Martin Povi=C5=A1er <povik+lin@cutebit.org> =
wrote:
>=20
>=20
>=20
>> On 23. 8. 2022, at 13:31, Mark Brown <broonie@kernel.org> wrote:
>>=20
>> On Tue, Aug 23, 2022 at 09:33:36AM +0200, Martin Povi=C5=A1er wrote:
>>>> On 22. 8. 2022, at 19:39, Mark Brown <broonie@kernel.org> wrote:
>>>> On Fri, Aug 19, 2022 at 02:54:29PM +0200, Martin Povi=C5=A1er =
wrote:
>=20
>>>>> +	/*
>>>>> +	 * We can't power up the device earlier than this because
>>>>> +	 * the power state driver would error out on seeing the device
>>>>> +	 * as clock-gated.
>>>>> +	 */
>>>>> +	cl->pd_link =3D device_link_add(mca->dev, cl->pd_dev,
>>>>> +				 DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME =
|
>>>>> +					 DL_FLAG_RPM_ACTIVE);
>>=20
>>>> I'm not clear on this dynamically adding and removing device links =
stuff
>>>> - it looks like the main (only?) purpose is to take a runtime PM
>>>> reference to the target device which is fine but it's not clear why
>>>> device links are involved given that the links are created and =
destroyed
>>>> every time the DAI is used, AFAICT always in the same fixed
>>>> relationship. It's not a problem, it's just unclear.
>>=20
>>> Indeed the only purpose is powering up the cluster=E2=80=99s power =
domain (there=E2=80=99s
>>> one domain for each cluster). Adding the links is the only way I =
know to
>>> do it. They need to be added dynamically (as opposed to statically =
linking,
>>> say, the DAI=E2=80=99s ->dev to the cluster=E2=80=99s ->pd_dev, =
which I guess may do
>>> something similar), because we need to sequence the =
power-up/power-down
>>> with the enablement of the clocks.
>>=20
>> You could also just do the underlying runtime power management
>> operations directly couldn't you? It's not clear what the device link
>> stuff is adding.
>=20
> This seems to be the way to do it. Quoting from documentation of
> dev_pm_domain_attach_by_id, by which we obtain the mca->dev and =
cl->pd_dev
> the link is between:
>=20
> * This function should typically be invoked by a driver during the =
probe phase,
> * in case its device requires power management through multiple PM =
domains. The
> * driver may benefit from using the received device, to configure =
device-links
> * towards its original device. Depending on the use-case and if =
needed, the
> * links may be dynamically changed by the driver, which allows it to =
control
> * the power to the PM domains independently from each other.
>=20
> --
> Martin

Pardon, just the cl->pd_dev is from dev_pm_domain_attach_by_id, mca->dev =
is
the original device.

Martin

