From: "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: tascam us-428 patch 0.0.2
Date: Thu, 15 Aug 2002 11:17:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DAELIEGDPLDDCIJPAICBEEEKCDAA.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp013.mail.yahoo.com (smtp013.mail.yahoo.com [216.136.173.57])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA25775
	for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2002 11:16:03 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

hey,

on http://hal9000.drehmoment.org/tascam/ you can download a patch against
cvs of august 14.
it contains:

- snd-usb-us428
  downloads firmware to endpoint 2.
  creates 2 midi devices through the patched snd-usb-midi
  and 2 input + 1 output pcm devices.

- snd-usb-midi with exports
  same as before ( i hope...), except added exports to make it callable b=
y
snd-usb-us428.
  Clemens and Takashi: you think its ok, or is there a better way?

- snd-usb-us428-dl
  firmware for a coldly booted us-428.
  this driver's task can shurely be done by a generic ez-usb
firmware-loader.
  for now it is needed to prepare the us-428 for the snd-usb-us428 module.

midi & audio work i.e. with the bristol-synths (44100 & 48000 S16_LE).
the us-428 control's messages are only printked except for the master vol=
ume
slider, which is functional.

the firmware and usb messages have been sniffed from the win2k 3.09 drive=
r
with an improved version of sniffusb 1.5. (there has been no support from
tascam so far)
should you like to sniff, i'll mail the sniffer to you.

there are still some things to improve like
- mapping the controls messages to midi messages
- stearing the leds by midi messages
- enhancing audio (24bit (possible by simply using altsetting 2), input
monitoring)

cheers,
karsten

__________________________________________________________________=0D
=0D
Gesendet von Yahoo! Mail - http://mail.yahoo.de=0D
M=F6chten Sie mit einem Gru=DF antworten? http://grusskarten.yahoo.de=0D


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
