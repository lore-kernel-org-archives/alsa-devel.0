From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Re: Roland/Edirol M-16DX
Date: Wed, 27 May 2009 23:49:43 +0300
Message-ID: <4A1DA767.1030909@trn.iki.fi>
References: <487F10EE.6030405@trn.iki.fi>
	<48883AAC.6060101@ladisch.de>	<49BC62A5.9070103@trn.iki.fi>
	<s5hsklerlsa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jenni2.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id C5E1B243E2
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 22:49:47 +0200 (CEST)
In-Reply-To: <s5hsklerlsa.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is still missing in 1.0.20.

>>>> This device doesn't seem to be supported yet. Does Roland make the
>>>> specifications available, etc? The device is not compatible with USB
>>>> Audio, but rather uses Vendor Specific Class.
>>> It appears to have most of the audio class descriptors, so it should be
>>> possible to tell the driver to just use it.
>>>
>>> Please try to add the following entry somewhere in sound/usb/usbquirks.h
>>> and to recompile the driver:
>>>
>>>
>>> {
>>> 	/* Edirol M-16DX */
>>> 	USB_DEVICE(0x0582, 0x00c4),
>>> 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
>>> 		.ifnum = QUIRK_ANY_INTERFACE,
>>> 		.type = QUIRK_COMPOSITE,
>>> 		.data = (const struct snd_usb_audio_quirk[]) {
>>> 			{
>>> 				.ifnum = 0,
>>> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
>>> 			},
>>> 			{
>>> 				.ifnum = 1,
>>> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
>>> 			},
>>> 			{
>>> 				.ifnum = 2,
>>> 				.type = QUIRK_MIDI_FIXED_ENDPOINT,
>>> 				.data = & (const struct snd_usb_midi_endpoint_info) {
>>> 					.out_cables = 0x0001,
>>> 					.in_cables  = 0x0001
>>> 				}
>>> 			},
>>> 			{
>>> 				.ifnum = -1
>>> 			}
>>> 		}
>>> 	}
>>> },
>> Could you add this quirk to the alsa-driver distribution as well? I'm 
>> getting tired of patching it myself for every new release :)
> 
> I didn't get any response about the patch, so I couldn't apply it...

Perhaps you missed the entire thread that was going on about this in 
2008? The one where I reported my results and other people also 
participated in the analysis.

> Seriously, without the response from testers, the development can
> never go on.  It'd be helpful if you give back the result precisely
> and soon at the next time...

Are you still expecting some feedback? You didn't suggest so in your 
last message, so I didn't see the need to answer.
