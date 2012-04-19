From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Wed, 18 Apr 2012 22:01:55 -0400
Message-ID: <4F8F7213.8070206@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173021pub.verizon.net (vms173021pub.verizon.net
	[206.46.173.21]) by alsa0.perex.cz (Postfix) with ESMTP id 0E18224569
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 04:02:25 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173021.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M2P003DGEZF6700@vms173021.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Wed, 18 Apr 2012 21:02:08 -0500 (CDT)
In-reply-to: <4F8E6CA2.8010005@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Stood up a new Ubuntu 12.04 VM and built alsa from 1.0.25 with the patch 
listed. I'm using VirtualBox with USB passthrough. This works fine when 
using the device in Win7 so I figured it would serve as good way to test 
the device without mucking around on my desktop.

After "alsa force-reload":

  snd-usb-audio: probe of 1-1:1.1 failed with error -5
  snd-usb-audio: probe of 1-1:1.2 failed with error -5
  snd-usb-audio: probe of 1-1:1.3 failed with error -5

Thoughts?

On 04/18/2012 03:26 AM, Clemens Ladisch wrote:
> Grant Diffey wrote:
>> So this looks reasonably familiar,
>>
>> int0 is DFU
>> int1 is mixer
>> int2 is audio out
>> int3 is audio in
>> int4 is midi
>> int5 is HID
>>
>> Quirk should look like the fast track ultra basically. maybe the mixer is less broken in this device?
> There only one way to find out.  :)
>
> {
> 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2030),
> 	.driver_info = (unsigned long)&  (const struct snd_usb_audio_quirk) {
> 		/* .vendor_name = "M-Audio", */
> 		/* .product_name = "Fast Track C400", */
> 		.ifnum = QUIRK_ANY_INTERFACE,
> 		.type = QUIRK_COMPOSITE,
> 		.data =&  (const struct snd_usb_audio_quirk[]) {
> 			{
> 				.ifnum = 1,
> 				.type = QUIRK_AUDIO_STANDARD_MIXER,
> 			},
> 			{
> 				.ifnum = 2,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
> 			},
> 			{
> 				.ifnum = 3,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
> 			},
> 			/* interface 4 (MIDI) is standard compliant */	
> 			{
> 				.ifnum = -1
> 			}
> 		}
> 	}
> },
>
>
> Chris, add this to sound/usb/quirks-table.h and recompile the kernel.
>
>
> Regards,
> Clemens
