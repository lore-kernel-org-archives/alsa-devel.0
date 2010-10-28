From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v5 1/9] davinci: EMAC support for
	Omapl138-Hawkboard
Date: Thu, 28 Oct 2010 13:34:40 -0500
Message-ID: <AANLkTi=RMHMCTue-eg2Yz0MC4QnnMELF=ns=LErrE7iB@mail.gmail.com>
References: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
	<1287511587-22216-2-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023475E6EE@dbde02.ent.ti.com>
	<4CC99C99.5010207@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EDF5510380B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 20:34:42 +0200 (CEST)
Received: by yxs7 with SMTP id 7so1699863yxs.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 11:34:42 -0700 (PDT)
In-Reply-To: <4CC99C99.5010207@mvista.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Nori,
	Sekhar" <nsekhar@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "caglarakyuz@gmail.com" <caglarakyuz@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 28, 2010 at 10:54 AM, Sergei Shtylyov <sshtylyov@mvista.com> wr=
ote:
> Hello.
>
> On 28-10-2010 18:04, Nori, Sekhar wrote:
>
>> Sorry for jumping late on this. Some comments below:
>
>>> From: Victor Rodriguez<victor.rodriguez@sasken.com>
>
>>> This patch adds EMAC support for the Hawkboard-L138 system
>
>>> Signed-off-by: Victor Rodriguez<victor.rodriguez@sasken.com>
>>> ---
>>> =A0arch/arm/mach-davinci/board-omapl138-hawk.c | =A0 47
>>> +++++++++++++++++++++++++++
>>> =A01 files changed, 47 insertions(+), 0 deletions(-)
>
>>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> index c472dd8..8633245 100644
>>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>>> @@ -19,6 +19,51 @@
>>>
>>> =A0#include<mach/cp_intc.h>
>>> =A0#include<mach/da8xx.h>
>>> +#include<mach/mux.h>
>>> +
>>> +#define HAWKBOARD_PHY_ID =A0 =A0 =A0 =A0 =A0 =A0 "0:07"
>>> +
>>> +static short omapl138_hawk_mii_pins[] __initdata =3D {
>>> + =A0 =A0 DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD=
_3,
>>> + =A0 =A0 DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_=
RXER,
>>> + =A0 =A0 DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD=
_3,
>>> + =A0 =A0 DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO=
_CLK,
>>> + =A0 =A0 DA850_MDIO_D,
>>> + =A0 =A0 -1
>
>> -1 need not be a new line. In any case, please include a ',' after it.
>
> =A0 Why is that? It's always a last entry in the array.
>
> WBR, Sergei
>

Sergei Nori Sekhar explained that in the last comment. he said that
there is no change on ti

Regards

Victor Rodriguez
