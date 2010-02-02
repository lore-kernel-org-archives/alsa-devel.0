From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Zoom R16 (USB), will a quirk make it work
Date: Tue, 02 Feb 2010 08:59:26 +0100
Message-ID: <4B67DB5E.9080208@ladisch.de>
References: <e53c6f621002012146n71ac0f7enb7e9f6e9c3b098d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 8F63F1037F9
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 08:59:29 +0100 (CET)
In-Reply-To: <e53c6f621002012146n71ac0f7enb7e9f6e9c3b098d2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jani Frilander <j.frilander@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jani Frilander wrote:
> I have a Zoom R16 which audio interface part doesn't work with linux.
> 
> lsusb -v:

Thanks.  Please try the following quirk entry:

{
	/* ZOOM R16 in USB 2.0 mode */
	USB_DEVICE(0x1686, 0x00dd),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = (const struct snd_usb_audio_quirk[]) {
			{
				.ifnum = 1,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum = 2,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum = 3,
				.type = QUIRK_MIDI_STANDARD_INTERFACE
			},
			{
				.ifnum = .1
			},
		}
	}
},

> If I try to play a file with mplayer:
> 
> $ mplayer -msglevel ao=9 -ao alsa:device=hw=2 piisi.mp3
> ...
> [AO_ALSA] Format s16le is not supported by hardware, trying default.

I don't know why there was an audio device at all (in theory, your quirk
entry shouldn't have worked), but the device supports only 24-bit
samples, so use "plughw" instead of "hw" (or better "default" for
software mixing).


HTH
Clemens
