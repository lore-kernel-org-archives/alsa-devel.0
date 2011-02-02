From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [alsa-devel] [PATCH v2 08/13] OMAP2+: McBSP: hwmod adaptation for McBSP
Date: Wed, 2 Feb 2011 11:53:32 +0530
Message-ID: <AANLkTimzjg3+yGwz1sa+dfWyrjaS1mO+zn_LT3hhDHdQ@mail.gmail.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-9-git-send-email-kishon@ti.com>
	<4D47FB19.9040901@nokia.com>
	<20110201194436.74826dd0.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20110201194436.74826dd0.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 1, 2011 at 11:14 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Tue, 01 Feb 2011 14:22:49 +0200
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
>
>> Looks good, but...
>> > + =A0 if (oh->class->rev =3D=3D MCBSP_CONFIG_TYPE3) {
>> > + =A0 =A0 =A0 =A0 =A0 if (id =3D=3D 2)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->buffer_size =3D 0x500=
; /*FIFO size is 1024 + 256*/
>> > + =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->buffer_size =3D 0x80;=
 =A0/*FIFO size is 128*/
>> > + =A0 }
>>
>> I would add spaces around these comments (after /* and before */).
>>
> Actually this part of code doesn't compile for CONFIG_ARCH_OMAP2 if
> CONFIG_ARCH_OMAP3 is not set. Reason is that the buffer_size in under
> CONFIG_ARCH_OMAP3 compilation in struct omap_mcbsp_platform_data
> definition.
>
> I think it's easiest if this patch just removes that conditional
> compilation from struct omap_mcbsp_platform_data as it really doesn't
> save that much from non !OMAP3 builds.

  Thanks. Will fix it in the next version.

>
> --
> Jarkko
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
