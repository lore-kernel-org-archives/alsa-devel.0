From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio FastTrack C400
Date: Wed, 18 Apr 2012 09:26:26 +0200
Message-ID: <4F8E6CA2.8010005@ladisch.de>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 259A024336
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 09:23:17 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1AA132165E
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 03:23:15 -0400 (EDT)
In-Reply-To: <CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org, chris-alsa@rauros.net, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Grant Diffey wrote:
> So this looks reasonably familiar,
>
> int0 is DFU
> int1 is mixer
> int2 is audio out
> int3 is audio in
> int4 is midi
> int5 is HID
>
> Quirk should look like the fast track ultra basically. maybe the mixer is less broken in this device?

There only one way to find out.  :)

{
	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2030),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		/* .vendor_name = "M-Audio", */
		/* .product_name = "Fast Track C400", */
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = & (const struct snd_usb_audio_quirk[]) {
			{
				.ifnum = 1,
				.type = QUIRK_AUDIO_STANDARD_MIXER,
			},
			{
				.ifnum = 2,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
			},
			{
				.ifnum = 3,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
			},
			/* interface 4 (MIDI) is standard compliant */	
			{
				.ifnum = -1
			}
		}
	}
},


Chris, add this to sound/usb/quirks-table.h and recompile the kernel.


Regards,
Clemens
