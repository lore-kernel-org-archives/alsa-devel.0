From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v6 9/9] davinci: USB1.1 support for
	Omapl138-Hawkboard
Date: Tue, 2 Nov 2010 18:00:43 -0600
Message-ID: <AANLkTim=On41sekDRH25oEhc3mQGP3PjYokYaCGe1AgG@mail.gmail.com>
References: <1288365045-2709-1-git-send-email-vm.rod25@gmail.com>
	<1288365045-2709-10-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234821A8C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 83FB224507
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 01:00:45 +0100 (CET)
Received: by gxk24 with SMTP id 24so36411gxk.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Nov 2010 17:00:44 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930234821A8C@dbde02.ent.ti.com>
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
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 2, 2010 at 12:20 PM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Victor,
>
> On Fri, Oct 29, 2010 at 20:40:45, vm.rod25@gmail.com wrote:
>> From: Victor Rodriguez <victor.rodriguez@sasken.com>
>>
>> This patch adds USB1.1 support for the Hawkboard-L138 system
>>
>> Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
>> ---
>
>> +static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
>> +{
>> + =A0 =A0 int irq =A0 =A0 =A0 =A0 =3D gpio_to_irq(DA850_USB1_OC_PIN);
>> + =A0 =A0 int error =A0 =A0 =A0 =3D 0;
>> +
>> + =A0 =A0 if (handler !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 hawk_usb_ocic_handler =3D handler;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D request_irq(irq, omapl138_hawk_usb_o=
cic_irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 IRQF_DISABLED | IRQF_TRIGGER_RISING |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 IRQF_TRIGGER_FALLING,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "OHCI over-current indicator", NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(KERN_ERR "%s: could not=
 request IRQ to watch "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "over-current =
indicator changes\n", __func__);
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_irq(irq, NULL);
>
> Per Documentation/CodingStyle, else should have braces too.

Ok thanks

>> +static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata =3D {
>> + =A0 =A0 .set_power =A0 =A0 =A0=3D hawk_usb_set_power,
>> + =A0 =A0 .get_power =A0 =A0 =A0=3D hawk_usb_get_power,
>> + =A0 =A0 .get_oci =A0 =A0 =A0 =A0=3D hawk_usb_get_oci,
>> + =A0 =A0 .ocic_notify =A0 =A0=3D hawk_usb_ocic_notify,
>> + =A0 =A0 /* TPS2087 switch @ 5V */
>
> Do we have this part on the hawkboard as well?

Yes the  TPS2087 is the   USB POWER MANAGER that we have on the board
AFAIK this is the same and besides it is working, I have tested by my
self by plugging different kind of USB devices, mas storage , Mouses
and keyboards.


> [...]
>
>> +static __init void omapl138_hawk_usb_init(void)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 u32 cfgchip2;
>> +
>> + =A0 =A0 ret =3D davinci_cfg_reg_list(da850_hawk_usb11_pins);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: USB 1.1 PinMux setup failed: %=
d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Setup the Ref. clock frequency for the HAWK at 24 MHz.
>> + =A0 =A0 =A0*/
>
> No need of multi-line comment style here.


Ok changed to

	/* Setup the Ref. clock frequency for the HAWK at 24 MHz. */

> Sorry about the piecemeal review (you really generated new versions quick=
ly).

Sorry about it I will take much more time for comments.

> That is all I have on this series.
>
> Also, you are CCing a whole lot of folks on each patch. Instead, you can
> automate CCing the relevant folks using --cc-cmd=3D<command> option =A0of
> git-send-email
>
> Use --cc-cmd=3D"scripts/get_maintainer.pl --pattern-depth=3D2 -s" to gene=
rate
> list of relevant CCs.
>
> Example:
>
> scripts/get_maintainer.pl -f arch/arm/mach-davinci/board-omapl138-hawk.c =
--pattern-depth=3D2 -s
>
> gives:
>
> Kevin Hilman <khilman@deeprootsystems.com>
> Russell King <linux@arm.linux.org.uk>
> davinci-linux-open-source@linux.davincidsp.com
> linux-arm-kernel@lists.infradead.org
>
> Recently Kevin requested all patches to CC Linux ARM Kernel mailing list =
so this
> should be OK.
>
> scripts/get_maintainer.pl -f sound/soc/davinci/davinci-evm.c --pattern-de=
pth=3D2 -s
>
> gives:
>
> Liam Girdwood <lrg@slimlogic.co.uk>
> Mark Brown <broonie@opensource.wolfsonmicro.com>
> alsa-devel@alsa-project.org
>
> This is as per what Liam and Mark have been asking for.
>
> Also, use --dry-run with git-send-email before sending actual emails to m=
ake
> sure the To and CC lists look good.

Ok I have done this

git send-email --dry-run --from "<vm.rod25@gmail.com>" --to
"<vm.rod25@gmail.com>" --cc-cmd =3Dscripts/get_maintainer.pl
patches/sendedv6/*

I just have one question on the --to i think I should put the davinci
mailing list as minimum right ? because the cover letter just will be
send to me

From: <vm.rod25@gmail.com>
To: <vm.rod25@gmail.com>
Cc: Victor Rodriguez <victor.rodriguez@sasken.com>
Subject: [PATCH v6 0/9] Add Omapl138-Hawkboard support
Date: Tue,  2 Nov 2010 17:48:03 -0600
Message-Id: <1288741692-20096-1-git-send-email-vm.rod25@gmail.com>
X-Mailer: git-send-email 1.7.0.4

Thanks for the help

Sincerely yours

Victor Rodriguez


> Thanks,
> Sekhar
>
>
