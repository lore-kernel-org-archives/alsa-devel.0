From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 21:51:34 +0200
Message-ID: <4E555646.2030209@ladisch.de>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>	<4E53959A.7090702@amlie.name>	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>	<4E53A748.4070404@amlie.name>	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>	<4E53AAE4.2070303@amlie.name>
	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 6B358244B8
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 21:51:57 +0200 (CEST)
In-Reply-To: <CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Ok, then let's try the attached patch.

> +		/* reset the port */
> +		err = snd_usbmidi_ftdi_command(umidi, 0, 0);
> +		if (err < 0)
> +			break;
> +
> +		/* set mctrl */
> +		err = snd_usbmidi_ftdi_command(umidi, 1, 0x303);
> +		if (err < 0)
> +			break;

The chip reads its initial configuration from the EEPROM, so these
commands might not be necessary.

> +		/* set baud rate */
> +		err = snd_usbmidi_ftdi_command(umidi, 3, 0xc04e);

Replace 0xc04e with 0x60 to get exactly 31250 baud.

Furthermore, the FT232RL chip sends two modem status bytes in its
packets, so we need something like this to prevent them from being
interpreted as MIDI:

--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -791,7 +791,8 @@ static struct usb_protocol_ops snd_usbmidi_novation_ops = {
 static void snd_usbmidi_raw_input(struct snd_usb_midi_in_endpoint* ep,
 				  uint8_t* buffer, int buffer_length)
 {
-	snd_usbmidi_input_data(ep, 0, buffer, buffer_length);
+	if (buffer_length > 2)
+		snd_usbmidi_input_data(ep, 0, buffer + 2, buffer_length - 2);
 }

 static void snd_usbmidi_raw_output(struct snd_usb_midi_out_endpoint* ep,


Regards,
Clemens
