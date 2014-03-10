From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
	support to quirks-table
Date: Mon, 10 Mar 2014 08:26:15 -0700
Message-ID: <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.cyrusharmon.org (unknown [206.125.171.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 881372656E0
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 16:26:26 +0100 (CET)
Received: from mail.cyrusharmon.org (localhost [127.0.0.1])
 by mail.cyrusharmon.org (Postfix) with ESMTP id 0F69D2E05B
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 08:39:23 -0700 (PDT)
Received: from [192.168.1.140] (unknown [107.201.5.56])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by mail.cyrusharmon.org (Postfix) with ESMTP id AD5532E059
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 08:39:22 -0700 (PDT)
In-Reply-To: <531DAB14.5080201@ladisch.de>
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


The attached patch provides support for the Steinberg UR44 USB Audio Interf=
ace. It=92s nothing more than Clemens=92 patch to support the UR22 (http://=
linuxaudio.org/mailarchive/lad/2013/2/23/197831), with the device ID modifi=
ed for the UR44. The patch was tested with kernel versions 3.12.11 and 3.12=
.12 and I have primarily used it with a PREEMPT RT-patched 3.12.12-rt kerne=
l. I would imagine there are additional features of this audio interface th=
at aren=92t supported by the patch, but basic recording and playback seems =
to work.

I should note that on one of the systems that I used to test the patch I wa=
s never able to achieve xrun-free JACK performance at -p256 -n3 as I would =
invariably see xruns roughly once every minute. But this is a new box (Inte=
l haswell NUC) and it seems there are many possible sources of the unaccept=
able latency. The good news is that an older i3 box, the performance was mu=
ch better. Still, at some point it would be nice to understand if the probl=
em lies in 1) the device, 2) the ALSA drivers, 3) the USB drivers, 4) IRQ h=
andling, 5) CPU-specific features (power saving modes, SMIs, etc=85) or 6) =
somewhere else. In the meantime, the patch at least makes the kernel recogn=
ize and talk to the UR44.

Thanks in advance for any comments/suggestions on the patch.

Cyrus

On Mar 10, 2014, at 5:07 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Cyrus Harmon wrote:
>> Signed-off-by: Cyrus Harmon <cyrus@bobobeach.com>
>> ---
>> sound/usb/quirks-table.h | 30 ++++++++++++++++++++++++++++++
>> 1 file changed, 30 insertions(+)
> =

> What kernel version did you test this patch with?
> =

> =

> Regards,
> Clemens
> =

>> =

>> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
>> index f652b10..987ca01 100644
>> --- a/sound/usb/quirks-table.h
>> +++ b/sound/usb/quirks-table.h
>> @@ -436,6 +436,36 @@ YAMAHA_DEVICE(0x105d, NULL),
>> 		}
>> 	}
>> },
>> +{
>> +	USB_DEVICE(0x0499, 0x150e),
>> +	.driver_info =3D (unsigned long) & (const struct snd_usb_audio_quirk) {
>> +		/* .vendor_name =3D "Yamaha", */
>> +		/* .product_name =3D "Steinberg UR44", */
>> +		.ifnum =3D QUIRK_ANY_INTERFACE,
>> +		.type =3D QUIRK_COMPOSITE,
>> +		.data =3D (const struct snd_usb_audio_quirk[]) {
>> +			{
>> +				.ifnum =3D 1,
>> +				.type =3D QUIRK_AUDIO_STANDARD_INTERFACE
>> +			},
>> +			{
>> +				.ifnum =3D 2,
>> +				.type =3D QUIRK_AUDIO_STANDARD_INTERFACE
>> +			},
>> +			{
>> +				.ifnum =3D 3,
>> +				.type =3D QUIRK_MIDI_YAMAHA
>> +			},
>> +			{
>> +				.ifnum =3D 4,
>> +				.type =3D QUIRK_IGNORE_INTERFACE
>> +			},
>> +			{
>> +				.ifnum =3D -1
>> +			}
>> +		}
>> +	}
>> +},
>> YAMAHA_DEVICE(0x2000, "DGP-7"),
>> YAMAHA_DEVICE(0x2001, "DGP-5"),
>> YAMAHA_DEVICE(0x2002, NULL),
>> =

> =

> =
