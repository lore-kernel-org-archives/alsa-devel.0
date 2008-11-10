From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Re: Roland/Edirol M-16DX
Date: Mon, 10 Nov 2008 05:53:13 +0200
Message-ID: <4917B029.7010809@trn.iki.fi>
References: <487F10EE.6030405@trn.iki.fi> <48883AAC.6060101@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsi1.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id F08E2103815
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 04:53:17 +0100 (CET)
Received: from trn.iki.fi (88.195.48.158) by kirsi1.inet.fi (8.5.014)
	id 48FC5AC9010BC178 for alsa-devel@alsa-project.org;
	Mon, 10 Nov 2008 05:53:17 +0200
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 7F7BC45B7BE0D
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 05:53:16 +0200 (EET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 05:53:16 +0200 (EET)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry about late reply.

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

This allows the device to be detected correctly and capture seems to be 
working flawlessly. Playback also works, but there is a severe three 
second distortion in audio once every 30 seconds, at 48 kHz. This seems 
to be related to the device sampling rate, as the cycle is only 15 
seconds when the device is running at 96 kHz.
