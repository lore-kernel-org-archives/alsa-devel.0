From: Alain Lauzon <alauzon@alainlauzon.com>
Subject: Help needed to develop quirks for USB Sound device for
 Roland Edirol PC-80 MIDI controller
Date: Mon, 14 Dec 2009 21:19:45 -0500
Message-ID: <1260843585.11219.15.camel__14354.9406705008$1260865098$gmane$org@Ubuntu>
Reply-To: alauzon@alainlauzon.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Heloo I just bought a Roland Edirol PC-80 MIDI controller and found out
that it was not supported on LINUX.  I looked on the web and found
the /usr/src/alsa/alsa-driver-xxx/usbquirks.h file to be the place to
change some code to support it.

I have tried many things but I don't enough info to get it right once
and for all.

Here is what I did :

{
	/* PC-80 Wave */
	USB_DEVICE(0x0582, 0x0092),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		/* .vendor_name = "EDIROL", */
		/* .product_name = "PC-80", */
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = (const struct snd_usb_audio_quirk[]) {
			{
				.ifnum = 0,
				.type = QUIRK_AUDIO_EDIROL_UAXX
			},
			{
				.ifnum = 1,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat) {
					.format = SNDRV_PCM_FORMAT_S24_3LE,
					.channels = 2,
					.iface = 0,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x81,
					.ep_attr = 0x01,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 48000,
					.rate_max = 48000, //(96?)
				}
			},
			{
				.ifnum = 2,
				.type = QUIRK_MIDI_FIXED_ENDPOINT,
				.data = & (const struct snd_usb_midi_endpoint_info) {
					.out_cables = 0x0007,
					.in_cables  = 0x0007
				}
			},
			{
				.ifnum = -1
			}
		}
}

What I got working is the audio out but cannot have the audio working.

Is there some resources somewhere that I could read to understand what I
need to do?

Thank you, Alain Lauzon

