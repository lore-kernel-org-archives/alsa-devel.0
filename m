Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7165C3F2CE
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:15:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731F320866
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="va43Cd74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731F320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCA06827;
	Thu,  5 Mar 2020 00:14:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCA06827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583363737;
	bh=EsBLIq659Fx3vuxtmvb+b7oIVh5TpLOjhO1dOzP12QA=;
	h=From:To:Subject:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=va43Cd74qmvxZ4z6VYBKIsW/p1dBHHX3jTq3j2y46MazDcHloqUXZ3QjOyUVkrVIs
	 XbV6JZWsdvqeXBD5hUna9F4EHE2GsdPKkHe+zYp1G323n2jHsLZOgWp8hvLNd4AHlI
	 mxp+sbhfMsEpO3eIrfoAM6pKARxq3kEd0b0q/I0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 486CBF801EC;
	Thu,  5 Mar 2020 00:14:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B12FCF801ED; Thu,  5 Mar 2020 00:14:45 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1AC28F8012D
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 00:14:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AC28F8012D
Received: from belgarion ([86.210.245.36]) by mwinf5d33 with ME
 id APEe220030nqnCN03PEeCk; Thu, 05 Mar 2020 00:14:41 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 05 Mar 2020 00:14:41 +0100
X-ME-IP: 86.210.245.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Guenter Roeck <linux@roeck-us.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
References: <20200224112537.14483-1-geert@linux-m68k.org>
 <20200303143444.GA25683@roeck-us.net>
 <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
X-URL: http://belgarath.falguerolles.org/
Date: Thu, 05 Mar 2020 00:14:38 +0100
In-Reply-To: <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
 (Geert Uytterhoeven's message of "Tue, 3 Mar 2020 15:56:25 +0100")
Message-ID: <878skf1zmp.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi G=C3=BCnter
>
> On Tue, Mar 3, 2020 at 3:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Mon, Feb 24, 2020 at 12:25:37PM +0100, Geert Uytterhoeven wrote:
>> > On i386 randconfig:
>> >
>> >     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
>> >     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
>> >     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
>> >     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
>> >     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
>> >     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
>> >
>> > Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
>> >
>>
>> With this patch applied, arm:pxa_defconfig reports a variety of unmet
>> SND_SOC dependencies, and it fails to build.
>>
>> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9713.ko] undefined!
>> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9712.ko] undefined!
>> ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9705.ko] undefined!
>>
>> Reverting this patch fixes the problem.
>
> Should SND_PXA2XX_SOC_AC97 in sound/soc/pxa/Kconfig select
> SND_SOC_AC97_BUS instead of SND_SOC_AC97_BUS_NEW?
> The latter does not exist.
Hi Geert,

The answer is no, PXA is now specifically ported to work with the new AC97 =
bus
implementation, ie. AC97_BUS_NEW=3Dy as in sound/ac97/.

The 2 implementations of AC97 bus, ie. CONFIG_AC97_BUS and CONFIG_AC97_BUS_=
NEW
are exclusive, they cannot coexist in the same kernel AFAIR.

Sorry for the late reply on this thread, but I moved house lately and I'm q=
uite
busy, so my answers are delayed.

As a side note, I've seen somewhere in the patches this :
SND_SOC_WM971{2,3} depends on SND_SOC_AC97_BUS. This looks wrong to me, as =
it
implies that a wolfson wm97xx sound driver can only exist with
CONFIG_AC97_BUS=3Dy, which is false, because it can exist with
CONFIG_AC97_BUS_NEW=3Dy.

I also saw someone saying the CONFIG_SND_SOC_AC97_BUS_NEW didn't exist; thi=
s is
true, most likely because I forgot it when I created the new AC97 bus. I'd =
think
the natural fix would be to add CONFIG_SND_SOC_AC97_BUS_NEW just after his =
twin
definition in sound/soc/Kconfig, but I might be wrong ...

Cheers.

--
Robert
