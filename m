From: "Karsten Wiese" <annabellesgarden@yahoo.de>
Subject: usb-audio: variable periodsize / nframes per callback can shorten latency times
Date: Mon, 19 Aug 2002 15:17:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DAELIEGDPLDDCIJPAICBCEFFCDAA.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp014.mail.yahoo.com (smtp014.mail.yahoo.com [216.136.173.58])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA21463
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 15:16:10 +0200
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

Hi,

usb iso transfers happen every 1ms (USB1.1) ( or at multiples of 125=B5s =
for
USB2.0).
this timing is fixed and leads to a variable amount of frames available a=
t
interrupt.
looking at 44100Hz on USB 1.1, we receive/send 44 frames on 9 of 10
USB-interrupts and 45 frames on 1 of 10
USB-interrupts.
on first sight 48000Hz seams to lead to a constant 48 frames per interrup=
t.
this does not remain true if the USB-audio device is in sync to an
externally connected device (digital in).
the current usb-audio mimics constant period size in the USB-interrupt
routines by calling snd_period_elapsed() only, if at least full period si=
zes
are transfered on the usb.
this good for constant period-size compatibility but leads to sub-optimal
latency: i.e. for capture worst case, audio apps start working 1ms later
than possible.
How can we implement the latency-optimal behaviour with alsa-driver
framework?
Can we implement something like a snd_1ms_elapsed() routine (called from
USB-interrupt), which in turn triggers a waiting app with the available
period size (which would be 44 or 45 frames for 44100Hz)?
I would like to see this in ALSA / JACK.
What do you think?

regards,
Karsten

__________________________________________________________________=0D
=0D
Gesendet von Yahoo! Mail - http://mail.yahoo.de=0D
M=F6chten Sie mit einem Gru=DF antworten? http://grusskarten.yahoo.de=0D


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
