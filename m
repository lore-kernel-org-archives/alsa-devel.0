From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: trying to get an eleven rack to work
Date: Tue, 20 Mar 2012 14:19:53 +0100
Message-ID: <4F6883F9.4010405@ladisch.de>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 40FCB103EA0
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 14:16:23 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A88AC210E9
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 09:16:20 -0400 (EDT)
In-Reply-To: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Alexander <lidxv0n@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Alexander wrote:
> I bought and would like to get an eleven rack interface to work.  It
> is a usb gutiar amp emulator/audio interface.  It is a avid/digi
> device that normal uses asio vendor specific drivers.
>
>     Interface Association:
>       bFunctionClass        255 Vendor Specific Class

Indeed.

>       bInterfaceNumber        1
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      1
>       bInterfaceProtocol     32
>       ** UNRECOGNIZED:  09 24 01 00 02 0a ae 00 01 ...

This looks like it's mostly standard compliant; please try to add this
entry to sound/usb/quirks-table.h:

{
	USB_DEVICE(0x, 0x),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		.vendor_name = "M-Audio",
		.product_name = "MidiSport 2x4",
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = & (const struct snd_usb_audio_quirk[]) {
			{
				.ifnum = 1,
				.type = QUIRK_AUDIO_STANDARD_MIXER
			},
			{
				.ifnum = 2,
				.type = QUIRK_MIDI_STANDARD_INTERFACE
			},
			{
				.ifnum = 3,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum = 4,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum = -1
			}
		}
	}
}

>           Transfer Type            Isochronous
>           Synch Type               Asynchronous
>           Usage Type               Implicit feedback Data

Playback is likely to be not correctly synchronized.


Regards,
Clemens
