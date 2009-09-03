From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: <alsa-dev> RFC for OMAP4 audio driver
Date: Thu, 3 Sep 2009 08:56:30 -0500
Message-ID: <6160a5130909030656j89cad98x1821f135d526621@mail.gmail.com>
References: <baee637d0909011927m5df3bd58uf7cabfc474f50274@mail.gmail.com>
	<20090902120120.GB4012@sirena.org.uk>
	<67059DBF19D7214F9C66BB0EA91BA90E80FDEDAA@dlee04.ent.ti.com>
	<20090903091011.GA10313@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f181.google.com (mail-px0-f181.google.com
	[209.85.216.181])
	by alsa0.perex.cz (Postfix) with ESMTP id A23A82454A
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 15:56:31 +0200 (CEST)
Received: by pxi11 with SMTP id 11so1699567pxi.17
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 06:56:30 -0700 (PDT)
In-Reply-To: <20090903091011.GA10313@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, hari n <hnagalla@gmail.com>, "Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

>> They will also have their DAIs which should be connected to the
>> physical outputs of ABE (McPDM, McBSP, ...), and that confuses me.
>> AFAIK, SoC allows to have multiple CODECs attached to the same
>> processor, but not a CODEC connected to the output of another CODEC.
>
> At the minute it's a bit tricky but it's definitely something that ought
> to be supported - you may remember the refactoring that was done to
> unify the CODEC and CPU DAI structures, this sort of use case was one of
> the motivators for that. =A0Where there's problems the core isn't a fixed
> thing, we can change it if required.

Very interesting thread.
My 2 cents: I find the notion of codec confusing.
In most products from Wolfson and others, you have a digital/mixing
part, and a second one for digital/analog conversions. OMAP4 and
others have a digital part on the application processor, but the
partition is still the same, only implemented on two chips instead of
one. It shouldn't really matter software-wise where the digital part
is done, as long as you can express the connection between these two
parts. A logical split would avoid having a description of a codec
connected to another codec, you would only have a digital part and an
analog part. With a CPU/digital/analog split, you could address all
topologies without developers incurring any risk of brain damage.
-Pierre
