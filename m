From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Rane SL-4 USB sound card
Date: Sun, 05 Jul 2015 19:32:37 +0200
Message-ID: <55996A35.6030904@ladisch.de>
References: <5597A9AE.2090002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 91866260449
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 19:33:59 +0200 (CEST)
In-Reply-To: <5597A9AE.2090002@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tuukka Pasanen <pasanen.tuukka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tuukka Pasanen wrote:
> I've been hacking to get Rane SL-4 USB audio ... to work with ALSA.
> I have compiled kernel and tried to get USB-quirks to work with this ... it doesn't do the trick

> If I need interface association how to do that?

The interface association descriptor should have been provided by the firmware.

Anyway, try the following quirk:

{
	USB_DEVICE(0x1cc5, 0x000f),
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
				.ifnum = -1,
			}
		}
	}
},


Regards,
Clemens
