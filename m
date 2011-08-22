From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Mon, 22 Aug 2011 18:07:46 +0530
Message-ID: <CAJe_Zhdb7d23_x=1GWV2EnEjdn69XBKEz+hCeCuBx4v9XAmykg@mail.gmail.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
	<20110822113002.GD30398@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110822113002.GD30398-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 22 August 2011 17:00, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Fri, Aug 19, 2011 at 04:52:14PM +0530, Jassi Brar wrote:
>> This is a flexible USB Audio Class 2.0 compliant gadget driver that
>> implements a simple topology with a virtual sound card exposed at
>> the function side.
>>
>> The driver doesn't expect any real audio codec to be present on the
>> function - the audio streams are simply sinked to and sourced from a
>> virtual ALSA sound card created. The user-space application may choo=
se
>> to do whatever it wants with the data received from the USB Host and
>> choose to provide whatever it wants as audio data to the USB Host.
>>
>> Capture(USB-Out) and Playback(USB-In) can be run at independent
>> configurations specified via module parameters while loading the dri=
ver.
>>
>> Signed-off-by: Yadi Brar <yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> How To Test
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =A0 USB_DEV$ insmod g_audio2.ko c_srate=3D64000 p_srate=3D48000 ; sa=
y
>> =A0 =A0 gadget: high speed config #1: UAC2
>>
>> =A0 USB_DEV$ aplay -l
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: uac2 [uac2], device 0: UAC2 PCM [UAC2 PCM]
>> =A0 Subdevices: 1/1
>> =A0 Subdevice #0: subdevice #0
>>
>> =A0 USB_DEV$ arecord -l
>> **** List of CAPTURE Hardware Devices ****
>> card 0: uac2 [uac2], device 0: UAC2 PCM [UAC2 PCM]
>> =A0 Subdevices: 1/1
>> =A0 Subdevice #0: subdevice #0
>>
>> =A0 USB_HOST$ aplay -l
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: PCH [HDA Intel PCH], device 0: ALC665 Analog [ALC665 Analog]
>> =A0 Subdevices: 0/1
>> =A0 Subdevice #0: subdevice #0
>> card 1: Gadget [UAC2 Gadget], device 0: USB Audio [USB Audio] =A0<<<=
<<<
>> =A0 Subdevices: 1/1
>> =A0 Subdevice #0: subdevice #0
>>
>> =A0 USB_HOST$ arecord -l
>> **** List of CAPTURE Hardware Devices ****
>> card 0: PCH [HDA Intel PCH], device 0: ALC665 Analog [ALC665 Analog]
>> =A0 Subdevices: 1/1
>> =A0 Subdevice #0: subdevice #0
>> card 1: Gadget [UAC2 Gadget], device 0: USB Audio [USB Audio] <<<<<<=
<
>> =A0 Subdevices: 1/1
>> =A0 Subdevice #0: subdevice #0
>>
>> =A0After this confirmation, you should be able to use it just like a=
nother
>> sound card in your system. That is, a new sound card should appear i=
n the
>> sound preferences which you can select to route your default audio t=
o and
>> from.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Test Results
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =A0The driver has been tested for Half as well as Full Duplex at
>> Stereo, S16_LE at 44.1KHz, 48KHz and 64KHz. It should also
>> work for other configurations as well, except for different
>> sample-size(TODO).
>>
>> Obviously, much depends upon the underlying UDC driver.
>>
>> While testing with OMAP's implementation of Inventra HDRC, I observe=
d
>> some noise for configurations for which the USB-OUT packet size chos=
en
>> by the Host is not a power of 2. USB-IN works just fine.
>> For ex, on both Beagle/Panda board, 48KHz USB-OUT has some noise whi=
le
>> 64KHz is smooth. Also, with full duplex, it occasioanally shows nois=
e.
>>
>> Taking benefit of doubt, I assume this driver has unmasked some subt=
le
>> bug in the underlying UDC's ISOCH handling code ;)
>> Please feel free to find issue with this driver by testing it over
>> some other UDC.
>>
>> =A0drivers/usb/gadget/Kconfig =A0 =A0| =A0 20 +
>> =A0drivers/usb/gadget/Makefile =A0 | =A0 =A02 +
>> =A0drivers/usb/gadget/audio2.c =A0 | =A0155 +++++
>> =A0drivers/usb/gadget/f_audio2.c | 1448 ++++++++++++++++++++++++++++=
+++++++++++++
>> =A04 files changed, 1625 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/usb/gadget/audio2.c
>> =A0create mode 100644 drivers/usb/gadget/f_audio2.c
>>
>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>> index e35dfef..95c65d8 100644
>> --- a/drivers/usb/gadget/Kconfig
>> +++ b/drivers/usb/gadget/Kconfig
>> @@ -599,6 +599,26 @@ config USB_ZERO_HNPTEST
>> =A0 =A0 =A0 =A0 the "B-Peripheral" role, that device will use HNP to=
 let this
>> =A0 =A0 =A0 =A0 one serve as the USB host instead (in the "B-Host" r=
ole).
>>
>> +config USB_AUDIO_2
>> + =A0 =A0 tristate "Audio Gadget Class 2.0 (EXPERIMENTAL)"
>> + =A0 =A0 depends on SND && EXPERIMENTAL
>> + =A0 =A0 select SND_PCM
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This Gadget Audio driver is compatible with USB Audio =
Class
>> + =A0 =A0 =A0 specification 2.0. It implements 1 AudioControl interf=
ace,
>> + =A0 =A0 =A0 1 AudioStreaming Interface each for USB-OUT and USB-IN=
=2E
>> + =A0 =A0 =A0 Number of channels, sample rate and sample size can be
>> + =A0 =A0 =A0 specified as module parameters.
>> + =A0 =A0 =A0 This driver doesn't expect any real Audio codec to be =
present
>> + =A0 =A0 =A0 on the device - the audio streams are simply sinked to=
 and
>> + =A0 =A0 =A0 sourced from a virtual ALSA sound card created. The us=
er-space
>> + =A0 =A0 =A0 application may choose to do whatever it wants with th=
e data
>> + =A0 =A0 =A0 received from the USB Host and choose to provide whate=
ver it
>> + =A0 =A0 =A0 wants as audio data to the USB Host.
>> +
>> + =A0 =A0 =A0 Say "y" to link the driver statically, or "m" to build=
 a
>> + =A0 =A0 =A0 dynamically linked module called "g_audio2".
>> +
>> =A0config USB_AUDIO
>> =A0 =A0 =A0 tristate "Audio Gadget (EXPERIMENTAL)"
>> =A0 =A0 =A0 depends on SND
>> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefi=
le
>> index 7409338..fa8472e 100644
>> --- a/drivers/usb/gadget/Makefile
>> +++ b/drivers/usb/gadget/Makefile
>> @@ -40,6 +40,7 @@ obj-$(CONFIG_USB_COMPOSITE) +=3D usb-composite.o
>> =A0#
>> =A0g_zero-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D zero.o
>> =A0g_audio-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D audio.o
>> +g_audio2-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D audio2.o
>
> instead of adding a new gadget driver, can't you just re-use g_audio =
and
> add what's missing ?
>
Hi Felipe,

=46unctionality wise, audio.c hardcodes the data-path to the physical
audio-codec onboard
whereas audio2.c provides user-space with a virtual sound-card to fool =
around
with audio-data the way the user wants. The functionality that has
lion's share of code.
Also, although the functionality of audio.c can be achieved by audio2.c=
 (but not
vice-versa) we'll break user-space by changing the behavior of audio.c
to audio2.c

Besides fundamental differences in functionality, they differ by
Usb-Audio-Class
compliance as well.  audio.c is UAC_1 compliant, whereas audio2.c is UA=
C_2
complaint.
One can not replace the other. For ex, MS-Windows doesn't support
UAC_2 by default
yet, Linux does reasonably well. And by definition having
Linux-USB-Gadget support
UAC_2 also, is only better. So by having both we cover more ground than=
 by
having just one.

Thanks
-jassi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
