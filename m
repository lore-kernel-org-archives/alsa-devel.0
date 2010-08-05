From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 16:04:06 -0600
Message-ID: <AANLkTinia_D1XeWwZ-m+ayQv3JHaH3h9GVpZULU7r9U7@mail.gmail.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
	<20100805145430.GB26801@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
	<20100805160310.GA17454@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914F@az33exm25.fsl.freescale.net>
	<20100805181832.GA32359@rakim.wolfsonmicro.main>
	<AANLkTi=oYiW5_6mEwjgzwJxUHJV5fG3pwKntkTr0Cn3m@mail.gmail.com>
	<AANLkTinBK79FTsJCkL5aAJmN1fRoN327WOHY4cUKwPU-@mail.gmail.com>
	<AANLkTim3Tbyajxxc3c-aeso0x=UjimLDdrL33vX=TBak@mail.gmail.com>
	<14BB2727-715C-4AF7-9750-75F011BE71FD@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9352E103923
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 00:04:27 +0200 (CEST)
Received: by gwj22 with SMTP id 22so2873430gwj.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 15:04:26 -0700 (PDT)
In-Reply-To: <14BB2727-715C-4AF7-9750-75F011BE71FD@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 5, 2010 at 3:42 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On 5 Aug 2010, at 22:19, Grant Likely wrote:
>
>> You are; but the lack of dts factorization must be solved first before
>> looking at whether or not .dtb overlays make sense. =A0Otherwise we
>> don't have a source for the factorized data. =A0I personally don't think
>> .dtb overlays are needed, but I'm not closed to the idea either.
>
> I think all the issues from the recent discussion about bootloaders also =
make it strongly desirable to get the SoC generic stuff out of the DTS that=
's shipped separately to the kernel...

The board specific data has the same issues as the soc specific data
in this regard, so I don't think it helps much to split it up at the
.dtb level.  However....

> ... You've got issues on reference boards where the SoC vendor may have s=
hipped a low quality device tree in flash and users are scared to try to re=
flash the board due to a lack of recovery facilities (so the less we rely o=
n being able to update data flashed into the device the better) and you've =
got issues on end user projects with large, potentially distributed, teams =
where coordinating updates between everyone can be tricky especially if tho=
se updates need to be done in lockstep (so the less data is shipped outside=
 the kernel the better).

Absolutely correct.  All of this discussion and lessons learned has
distilled the fact the .dtb file must not be linked into the boot
firmware.  Any design that requires a boot firmware upgrade to
update/replace the .dtb is broken.  There will still be broken cases,
but fortunately for the broken cases the .dtb can always be linked
into the kernel image.  So, for "good" firmware, the .dtb use case
works really well.  In the "broken" firmware case, the .dtb(s) can be
linked into the wrapper image and the correct one can be chosen based
on machine-id or some other discernible board data.  I'm being very
careful to make sure that using a .dtb doesn't paint anybody into a
corner.

> Remember rmk's constant complaint about bootloaders on ARM - these are pr=
ograms that need to get two registers right on kernel start and don't relia=
bly do so.

Understood.  It is my priority to complete a full-featured sample
implementation so I can prove that it is actually a useful solution.
I'm going to start with U-Boot and make sure upstream u-boot always
passes the correct thing for passing a .dtb

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
