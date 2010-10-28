From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v5 1/9] davinci: EMAC support for
	Omapl138-Hawkboard
Date: Thu, 28 Oct 2010 09:21:28 -0500
Message-ID: <AANLkTi=NNVieBNmSAfuebZQGAFMxXkpirZXeRSHLb2OA@mail.gmail.com>
References: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
	<1287511587-22216-2-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023475E6EE@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023475E702@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9F5F4244D9
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 16:21:29 +0200 (CEST)
Received: by yws5 with SMTP id 5so1447221yws.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 07:21:28 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593023475E702@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "sshtylyov@mvista.com" <sshtylyov@mvista.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 28, 2010 at 9:18 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> On Thu, Oct 28, 2010 at 19:34:10, Nori, Sekhar wrote:
>> Hi Victor,
>>
>> Sorry for jumping late on this. Some comments below:
>>
>> On Tue, Oct 19, 2010 at 23:36:19, vm.rod25@gmail.com wrote:
>> > From: Victor Rodriguez <victor.rodriguez@sasken.com>
>> >
>> > This patch adds EMAC support for the Hawkboard-L138 system
>> >
>> > Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
>> > ---
>> > =A0arch/arm/mach-davinci/board-omapl138-hawk.c | =A0 47 ++++++++++++++=
+++++++++++++
>> > =A01 files changed, 47 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/ma=
ch-davinci/board-omapl138-hawk.c
>> > index c472dd8..8633245 100644
>> > --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> > +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> > @@ -19,6 +19,51 @@
>> >
>> > =A0#include <mach/cp_intc.h>
>> > =A0#include <mach/da8xx.h>
>> > +#include <mach/mux.h>
>> > +
>> > +#define HAWKBOARD_PHY_ID =A0 =A0 =A0 =A0 =A0 =A0 "0:07"
>> > +
>> > +static short omapl138_hawk_mii_pins[] __initdata =3D {
>> > + =A0 =A0 DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TX=
D_3,
>> > + =A0 =A0 DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII=
_RXER,
>> > + =A0 =A0 DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RX=
D_3,
>> > + =A0 =A0 DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDI=
O_CLK,
>> > + =A0 =A0 DA850_MDIO_D,
>> > + =A0 =A0 -1
>>
>> -1 need not be a new line. In any case, please include a ',' after it.
>
> The justification for a ',' in the end is that it makes it easier
> to add new initialization elements. Since -1 is going to be
> the last one anyway, please ignore this comment.
>
> Thanks,
> Sekhar
>
>

Ok so let me see if I understand The only change that I should do is to rem=
ove

> +     if (!machine_is_omapl138_hawkboard())
> +             return;

right ?

Regards

Victor
