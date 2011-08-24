From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 12:14:33 +0200
Message-ID: <4E54CF09.90001@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>	<4E53959A.7090702@amlie.name>	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>	<4E53A748.4070404@amlie.name>	<CACTFLANSwy66KAyLbxyy=pB9Z+K+r7ur564Frx7ep1W_JY=XCQ@mail.gmail.com>	<4E53AAE4.2070303@amlie.name>	<CACTFLANav3woJuXjdpsYEqvvbbTb53S0d2MtVoq9EByv-j-cxw@mail.gmail.com>	<4E54B1A5.5080507@amlie.name>
	<CACTFLAPkyYNxRkd=9R12U8_dBbkJQZ=LSXr9a8au_Kfc5R78fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030806010406060008020206"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy5-pub.bluehost.com (oproxy5-pub.bluehost.com
	[67.222.38.55]) by alsa0.perex.cz (Postfix) with SMTP id 7AF79103905
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 12:17:08 +0200 (CEST)
In-Reply-To: <CACTFLAPkyYNxRkd=9R12U8_dBbkJQZ=LSXr9a8au_Kfc5R78fQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030806010406060008020206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08/24/11 10:32, Daniel Mack wrote:
> Hmm? Can you trace where this happens and which dereferenced pointer
> is NULL? I don't see it, sorry.

The attached patch solves the NULL pointer dereference. With this patch,
the device shows up as a MIDI device, but still produces no events
according to aseqdump.

I did a more thorough examination of the calls to usb_control_msg() from
the ftdi_sio driver, and this is what I came up with:

Plugging it in:

Calling usb_control_msg() from read_latency_timer(): value=0, index=0
Calling usb_control_msg() from write_latency_timer(): value=1, index=0
usb 3-2: FTDI USB Serial Device converter now attached to ttyUSB0

Starting cu:

Calling usb_control_msg() from ftdi_open(): value=0, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
Calling usb_control_msg() from change_speed(): value=16696, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=0, index=0
Calling usb_control_msg() from update_mctrl(): value=771, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
Calling usb_control_msg() from change_speed(): value=49230, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=0, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
Calling usb_control_msg() from change_speed(): value=49230, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=0, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
Calling usb_control_msg() from change_speed(): value=49230, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=4881, index=1024

Killing cu:

Calling usb_control_msg() from ftdi_set_termios(): value=8, index=0
Calling usb_control_msg() from change_speed(): value=16696, index=0
Calling usb_control_msg() from ftdi_set_termios(): value=0, index=0
Calling usb_control_msg() from ftdi_dtr_rts(): value=0, index=0
Calling usb_control_msg() from update_mctrl(): value=768, index=0

-- 
Kristian

--------------030806010406060008020206
Content-Type: text/plain;
 name="starr-labs-midi-extra1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="starr-labs-midi-extra1.diff"

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 090e193..65591df 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -306,6 +306,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_EMAGIC] = create_any_midi_quirk,
 		[QUIRK_MIDI_CME] = create_any_midi_quirk,
 		[QUIRK_MIDI_AKAI] = create_any_midi_quirk,
+		[QUIRK_MIDI_FTDI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,

--------------030806010406060008020206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030806010406060008020206--
