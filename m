From: =?ISO-8859-1?Q?J=F6rn_Nettingsmeier?=
 <nettings@stackingdwarves.net>
Subject: Re: Can't get capturing from RME Hammerfall MADI card
 to work: sound loops & silcence
Date: Wed, 02 Oct 2013 17:16:15 +0200
Message-ID: <524C38BF.9070200@stackingdwarves.net>
References: <CANYi0v7OD_AFC9-jFeH4MGLZQGsPX91S5NdjqDsmZ_9pOR0hPg@mail.gmail.com>
 <CAGqxWvJQPFd_v_iN0eyVG1qCCUxeYpcOP0YU961Gn2JGdN3RgA@mail.gmail.com>
 <5245370C.5060408@ladisch.de> <52453824.9070308@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.stackingdwarves.net (evil.stackingdwarves.net
 [188.40.12.36]) by alsa0.perex.cz (Postfix) with ESMTP id 845A0265495
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 17:16:16 +0200 (CEST)
Received: from hoppetosse.villakunterbunt.netz (p508B9E50.dip0.t-ipconnect.de
 [80.139.158.80])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by mail.stackingdwarves.net (Postfix) with ESMTPSA id D99176074A
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 17:16:14 +0200 (CEST)
In-Reply-To: <52453824.9070308@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/27/2013 09:47 AM, Florian Faber wrote:
> Clemens,
>
>>> Similar issues here, but can add it all seems to work absolutely fine w=
ith
>>> alsa 1.0.15, but fails with 1.0.18+.
>> This sound like some change in the driver introduced a bug.
>
> the driver works fine with versions up to 1.0.27. I have the card
> running on a daily base with current kernel versions.

same here, although mine is a bit older (lspci says rev d2).
current 3.10.x and 3.11 kernels, alsa at 1.0.26.

niels, pretty much everyone who uses such hardware on linux will be =

running jack. can i suggest you run a brief check with jack, and then =

maybe look at its backend implementation to find out where stuff goes wrong?



-- =

J=F6rn Nettingsmeier
Lortzingstr. 11, 45128 Essen, Tel. +49 177 7937487

Meister f=FCr Veranstaltungstechnik (B=FChne/Studio)
Tonmeister VDT

http://stackingdwarves.net
