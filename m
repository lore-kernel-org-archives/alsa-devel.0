From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help needed to develop quirks for USB Sound device
 for Roland Edirol PC-80 MIDI controller
Date: Fri, 18 Dec 2009 15:19:03 +0100
Message-ID: <4B2B8F57.90401__39312.2553512969$1261145967$gmane$org@ladisch.de>
References: <1260843585.11219.15.camel@Ubuntu> <4B28C5AC.30706@ladisch.de>
	<1261076148.5000.1.camel@Ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1261076148.5000.1.camel@Ubuntu>
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
Cc: linux-usb@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

Alain Lauzon wrote:
> Bus 001 Device 014: ID 0582:0092 Roland Corp. EDIROL PC-80 WAVE
> ...
> Bus 001 Device 013: ID 0582:0093 Roland Corp. EDIROL PC-80 MIDI
> ...

This is implemented as two logical devices, so it will show up as two
ALSA sound cards.

You didn't show the descriptors for a full-duplex mode, so I'm assuming
it works like with any other Roland device.

Please try the following quirk entries:

{
	/* WAVE part only; see ID 0x0093 for MIDI */
	USB_DEVICE(0x0582, 0x0092),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		/* .vendor_name = "EDIROL", */
		/* .product_name = "PC-80", */
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
				.ifnum = -1
			}
		}
	}
},
{
	/* MIDI part only; see ID 0x0092 for WAVE */
	USB_DEVICE(0x0582, 0x0093),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		/* .vendor_name = "EDIROL", */
		/* .product_name = "PC-80", */
		.ifnum = 0,
		.type = QUIRK_MIDI_FIXED_ENDPOINT,
		.data = & (const struct snd_usb_midi_endpoint_info) {
			.out_cables = 0x0000,
			.in_cables = 0x0003,
		}
	}
},
