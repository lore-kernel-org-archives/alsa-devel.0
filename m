From: =?ISO-8859-1?Q?J=F6rn_Nettingsmeier?=
 <nettings@stackingdwarves.net>
Subject: Re: [PATCH] hdspm.c: make driver name generic to avoid
 user	confusion
Date: Tue, 07 Jun 2011 12:46:03 +0200
Message-ID: <4DEE016B.7010308@stackingdwarves.net>
References: <4DEDE4E2.4060303@folkwang-hochschule.de>
	<20110607091132.GI17989@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.stackingdwarves.net (vm-evil.stackingdwarves.net
	[78.47.233.26]) by alsa0.perex.cz (Postfix) with ESMTP id 29AFD2433B
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 12:39:33 +0200 (CEST)
In-Reply-To: <20110607091132.GI17989@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Adrian Knoth <adi@drcomp.erfurt.thur.de>
List-Id: alsa-devel@alsa-project.org

On 06/07/2011 11:11 AM, Adrian Knoth wrote:

> "HDSPe" is also confusing, only referring to the PCIe versions. Since we
> also support the old PCI versions, I suggest to name it
>
>     "RME Hammerfall HDSP(e) Series"
>
> On the other hand, the 'H' in "HDSP" stands for "Hammerfall", so
>
>     "RME HDSP(e) Series"
>
> would be more appropriate. Luckily, we don't collide with the hdsp.c
> driver name, but still, it's misleading, because there are cards that
> match "RME HDSP(e) Series" (like the Multiface/Digiface) but are handled
> by hdsp.c instead.
>
> What at mess. ;) Merging hdsp.c into hdspm.c would be the clean approach
> to this problem, still I don't have time for this in the near future.
> Maybe in July.
>
>
> Given that all current variants are misleading in one way or another, we
> could also leave everything as is. What do you think?

no. MADI is way too specific, and the only reason it's there is that =

winni started with just the MADI card...

enumerate supported cards? "RME HDSP AES32, AIO, RayDAT, MADI, MADIface"
kludgy, but less potential for user confusion.



-- =

J=F6rn Nettingsmeier
Lortzingstr. 11, 45128 Essen, Tel. +49 177 7937487

Meister f=FCr Veranstaltungstechnik (B=FChne/Studio)
Tonmeister (VDT)

http://stackingdwarves.net
