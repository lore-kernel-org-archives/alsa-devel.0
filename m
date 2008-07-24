From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Roland/Edirol M-16DX
Date: Thu, 24 Jul 2008 10:17:48 +0200
Message-ID: <48883AAC.6060101@ladisch.de>
References: <487F10EE.6030405@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CB0232468D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 10:17:53 +0200 (CEST)
In-Reply-To: <487F10EE.6030405@trn.iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lasse K=E4rkk=E4inen wrote:
> This device doesn't seem to be supported yet. Does Roland make the
> specifications available, etc? The device is not compatible with USB
> Audio, but rather uses Vendor Specific Class.

It appears to have most of the audio class descriptors, so it should be
possible to tell the driver to just use it.

Please try to add the following entry somewhere in sound/usb/usbquirks.h
and to recompile the driver:


{
	/* Edirol M-16DX */
	USB_DEVICE(0x0582, 0x00c4),
	.driver_info =3D (unsigned long) & (const struct snd_usb_audio_quirk) {
		.ifnum =3D QUIRK_ANY_INTERFACE,
		.type =3D QUIRK_COMPOSITE,
		.data =3D (const struct snd_usb_audio_quirk[]) {
			{
				.ifnum =3D 0,
				.type =3D QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum =3D 1,
				.type =3D QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum =3D 2,
				.type =3D QUIRK_MIDI_FIXED_ENDPOINT,
				.data =3D & (const struct snd_usb_midi_endpoint_info) {
					.out_cables =3D 0x0001,
					.in_cables  =3D 0x0001
				}
			},
			{
				.ifnum =3D -1
			}
		}
	}
},



HTH
Clemens
