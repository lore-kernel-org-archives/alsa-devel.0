From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic@trn.iki.fi>
Subject: Re: Roland/Edirol M-16DX
Date: Sun, 15 Mar 2009 04:06:29 +0200
Message-ID: <49BC62A5.9070103@trn.iki.fi>
References: <487F10EE.6030405@trn.iki.fi> <48883AAC.6060101@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jenni1.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id CDD2D243D7
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 03:06:31 +0100 (CET)
In-Reply-To: <48883AAC.6060101@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
List-Id: alsa-devel@alsa-project.org

>> This device doesn't seem to be supported yet. Does Roland make the
>> specifications available, etc? The device is not compatible with USB
>> Audio, but rather uses Vendor Specific Class.
> 
> It appears to have most of the audio class descriptors, so it should be
> possible to tell the driver to just use it.
> 
> Please try to add the following entry somewhere in sound/usb/usbquirks.h
> and to recompile the driver:
> 
> 
> {
> 	/* Edirol M-16DX */
> 	USB_DEVICE(0x0582, 0x00c4),
> 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> 		.ifnum = QUIRK_ANY_INTERFACE,
> 		.type = QUIRK_COMPOSITE,
> 		.data = (const struct snd_usb_audio_quirk[]) {
> 			{
> 				.ifnum = 0,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> 			},
> 			{
> 				.ifnum = 1,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> 			},
> 			{
> 				.ifnum = 2,
> 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
> 				.data = & (const struct snd_usb_midi_endpoint_info) {
> 					.out_cables = 0x0001,
> 					.in_cables  = 0x0001
> 				}
> 			},
> 			{
> 				.ifnum = -1
> 			}
> 		}
> 	}
> },

Could you add this quirk to the alsa-driver distribution as well? I'm 
getting tired of patching it myself for every new release :)

Note: playback doesn't actually work because it is not properly 
synchronized. The device also doesn't have any MIDI ports, but maybe 
that's for remote control of parameters?
