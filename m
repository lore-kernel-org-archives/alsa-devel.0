Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A20C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 14:07:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB249184D;
	Fri, 22 Apr 2022 16:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB249184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650636425;
	bh=Jx1f161qNwaJZ19dEZPUoH3jlZPFEq+qTOhpse63VLc=;
	h=Subject:From:In-Reply-To:Date:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Au0qURJl3hvUY4F9hwzH6E6BK4LPLQjYgYmeo7NcitlII2FBaXs796PtgRi6n6lEc
	 Dc3pAXAHE4B3VXKmTjhZLqT5UDkEXl/JWkUnsISb8si8o2HKUmK7e+uek/1xWtFfRH
	 zsRRxwGhACal73LqbUuxdmNAeKHFW1a2iSNh5N5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B19DF80154;
	Fri, 22 Apr 2022 16:06:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 396C9F80245; Fri, 22 Apr 2022 16:06:13 +0200 (CEST)
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92939F800D1
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2022 16:06:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92939F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="AbzuRb2n"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1650636366; bh=ORZSwNwJzdGAfaoDUNcAQX21DFUv58T6uCJA7N2SVTc=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=AbzuRb2nCEb9tGr4A98sKwHCclqpfoPJ+JEHYNK5dLFftUJJVezy5owr1B+8cKlGs
 EB0kVx7hseoi7KhAq2vlaQ7VQTODoxwXzu3P5q2zC+JUDbdSULSZs5pfByRmgVh+RG
 00qNWyMt9UIzQnEd2gszyAChExbuYCQ9Q7gSyqNw=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YkrkbBNYULLgeS5w@sirena.org.uk>
Date: Fri, 22 Apr 2022 16:06:06 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
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


> On 4. 4. 2022, at 14:28, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Mar 31, 2022 at 02:04:47AM +0200, Martin Povi=C5=A1er wrote:
>=20
>> +#if 0
>> 				dev_err(rtd->card->dev,
>> 					"N cpus to M codecs link is not =
supported yet\n");
>> 				return -EINVAL;
>> +#endif
>> +				cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);
>=20
> We need to figure out an interface for describing which CODEC/CPU
> combinations are connected to each other.  I'm not seeing a great way =
to
> do that right now, probably some side data table is going to be =
needed,
> or perhaps the CPU DAI drivers can be persuaded to only have one DAI
> actually register and claim to support more channels?  I'm not sure =
how
> a configuraiton like this is going to work at userspace level if the
> multiple CPU DAIs end up being visible...

To understand the issue better: How could the multiple CPU DAIs be
visible from userspace?

What about this interim solution: In case of N-to-M links we put in
the most restrictive condition for checking capture/playback stream
validity: we check all of the CPU DAIs. Whatever ends up being the
proper solution later can only be less restrictive than this.

As a reminder what happens on the Macs: the platform driver drives
all the CPU-side I2S ports that belong to the link with the same data,
so the particular CPU/CODEC wiring doesn=E2=80=99t matter.

