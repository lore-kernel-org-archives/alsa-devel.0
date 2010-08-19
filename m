From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of/device: Replace struct of_device with struct of_platform
Date: Thu, 19 Aug 2010 16:23:36 -0600
Message-ID: <AANLkTiktjcwQrjBf1sF+2Y8ZTpmsTwo+-4cXfkkb5H+i@mail.gmail.com>
References: <20100801074831.1099.3318.stgit@angua> <AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
 <AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com> <4C6DA3E7.20206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <4C6DA3E7.20206@freescale.com>
Sender: sparclinux-owner@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 3:36 PM, Timur Tabi <timur@freescale.com> wrote=
:
> Grant Likely wrote:
>> On Thu, Aug 19, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wr=
ote:
>>> On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretla=
b.ca> wrote:
>>>
>>>> =A0sound/soc/fsl/mpc8610_hpcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +-
>>>
>>> This file is/was significantly rewritten for 2.6.37. =A0I posted a =
fix
>>> to the alsa mailing list, but it will conflict with your patch. =A0=
You
>>> might want to remove all changes to sound/soc/fsl from this commit.
>>
>> This change is already in Linus' tree.
>
> Then I suspect the ALSA guys are going to have a merge conflict comin=
g up,
> because I had to make these changes to the -next branch.

It is a trivial conflict.  They shouldn't have any problem fixing it up=
=2E

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
