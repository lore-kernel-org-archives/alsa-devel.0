From: Helian <helian.seele@gmail.com>
Subject: usb-audio erro during playback
Date: Fri, 8 Apr 2011 14:37:40 -0300
Message-ID: <BANLkTi=DtqbXvysJc_9CPrkbp+FJZ4-gBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016369f9b18bd36c104a06bae94
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A3A4810382C
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 19:37:41 +0200 (CEST)
Received: by iwc10 with SMTP id 10so4205876iwc.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 10:37:40 -0700 (PDT)
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

--0016369f9b18bd36c104a06bae94
Content-Type: text/plain; charset=ISO-8859-1

Hi,

 I'm trying to use a KingRex UC-192 usb/spdif with my linux setup but I
can't play anything. I'm using slackware 13.1 with alsa 1.0.24.
Alsa recognizes the device, the output of "lsusb -v" is in the gzip file.
The "/proc/asound/cardX/stream0" shows

KingRex technology co.,ltd KingRex UC-192 USB TO Spdif/I2S at
usb-0000:00:0b.1- :
USB Audio

Playback:
Status: Stop
Interface 1
Altset 1
Format: S16_LE
Channels: 2
Endpoint: 4 OUT (ADAPTIVE)
Rates: 44100, 88200, 176400, 48000, 96000, 192000
Data packet interval: 1000 us
Interface 1
Altset 2
Format: S24_3LE
Channels: 2
Endpoint: 4 OUT (ADAPTIVE)
Rates: 44100, 88200, 176400, 48000, 96000, 192000
Data packet interval: 500 us
Interface 1
Altset 3
Format: S32_LE
Channels: 2
Endpoint: 4 OUT (ADAPTIVE)
Rates: 44100, 88200, 176400, 48000, 96000, 192000
Data packet interval: 500 us

but when I try to play anything I only get a distorted sound and the syslog
message "ALSA clock.c:116: uac_clock_source_is_valid(): cannot get clock
validity for 128"

Any suggestions on how to fix this problem ?



Thanks

--0016369f9b18bd36c104a06bae94
Content-Type: application/x-gzip; name="lsusb.gz"
Content-Disposition: attachment; filename="lsusb.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gm9eew730

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
--0016369f9b18bd36c104a06bae94
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016369f9b18bd36c104a06bae94--
