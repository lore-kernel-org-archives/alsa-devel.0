From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 15:19:11 -0600
Message-ID: <AANLkTim3Tbyajxxc3c-aeso0x=UjimLDdrL33vX=TBak@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1534E103911
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 23:19:31 +0200 (CEST)
Received: by ywa6 with SMTP id 6so2878712ywa.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 14:19:31 -0700 (PDT)
In-Reply-To: <AANLkTinBK79FTsJCkL5aAJmN1fRoN327WOHY4cUKwPU-@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 5, 2010 at 3:13 PM, Timur Tabi <timur@freescale.com> wrote:
> On Thu, Aug 5, 2010 at 2:43 PM, Grant Likely <grant.likely@secretlab.ca> =
wrote:
>
>> The lack of shared soc data in device trees is indeed a problem that
>> has been on my radar for a while now. =A0Fortunately I do have a
>> solution[1] which is partially implemented plus a contractual
>> obligation to deliver it to a client in the near future. =A0I fully
>> expect this will become a non-issue between now and about mid
>> November.
>>
>> g.
>>
>> [1] http://www.mail-archive.com/devicetree-discuss@lists.ozlabs.org/msg0=
0680.html
>
> I haven't read through all of it, but it looks like your solution
> affects only DTS files. =A0I think Mark's concern is mostly with DTB
> files, because we still need to have a unique DTB for every possible
> board variation.
>
> Am I reading that correctly?

You are; but the lack of dts factorization must be solved first before
looking at whether or not .dtb overlays make sense.  Otherwise we
don't have a source for the factorized data.  I personally don't think
.dtb overlays are needed, but I'm not closed to the idea either.

g.
