From: John F Leach <jfleach@jfleach.com>
Subject: Re: ALSA Support for Roland Gaia SH-01
Date: Mon, 21 Nov 2011 12:19:03 -0500
Message-ID: <1321895943.3336.8.camel@darkside>
References: <1321835088.14960.22.camel@darkside>
	<CACckToWK3kr4tfWjAOXnpVxH792tOZekeCVT8=g7zPCD31gm5Q@mail.gmail.com>
	<4ECA4913.7050307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a62.g.dreamhost.com (caiajhbdcagg.dreamhost.com
	[208.97.132.66])
	by alsa0.perex.cz (Postfix) with ESMTP id E6174103843
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 18:19:13 +0100 (CET)
In-Reply-To: <4ECA4913.7050307@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Grant Diffey <gdiffey@gmail.com>, clemens <clemens@ladisch.de>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Thanks for the help everyone.  I was able to get the device's USB audio
and MIDI to work, but need additional time for testing and tweaking of
the code.  

Here's the patch so far, please let me know if there are any other
enhancements I should consider.

{
        /* Roland GAIA SH-01 */
        USB_DEVICE(0x0582, 0x0111),
        .driver_info = (unsigned long) & (const struct
snd_usb_audio_quirk) {
                .vendor_name = "Roland",
                .product_name = "SH-01",
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_COMPOSITE,
                .data = (const struct snd_usb_audio_quirk[]) {
                        {
                                .ifnum = 0,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = 1,
                                .type = QUIRK_AUDIO_STANDARD_INTERFACE
                        },
                        {
                                .ifnum = 2,
                                .type = QUIRK_MIDI_FIXED_ENDPOINT,
                                .data = & (const struct
snd_usb_midi_endpoint_info) {
                                       .out_cables = 0x0003,
                                       .in_cables  = 0x0003
                                }
                        },
                        {
                                .ifnum = -1
                        }
                }
        }
},

Regards,

John F Leach
