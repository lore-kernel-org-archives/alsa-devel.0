From: Fabrice DELENTE <delentef@gmail.com>
Subject: Bluetooth: alsa says connection refused?
Date: Fri, 17 Feb 2012 20:20:42 +0100
Message-ID: <20120217192042.GA15631@smtp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-eu.gmx.com (mailout-eu.gmx.com [213.165.64.42])
	by alsa0.perex.cz (Postfix) with SMTP id 6EC1E1038FA
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 20:20:42 +0100 (CET)
Content-Disposition: inline
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

Hello.

I have a bluetooth headset that I have successfully used with a cell
phone and an Android tablet, and that I could use in Ubuntu on a
friend's machine.

I'd like to use it with mplayer on my laptop (under Slackware 13.37).

I have the BT address, and the test-audio script in bluez-4.98/test
works (at least, I hear two beeps in the headphone, and hcitool con
shows

# hcitool con
Connections:
< ACL 00:18:91:D0:7A:24 handle 42 state 1 lm MASTER AUTH ENCRYPT

so I guess it is possible to connnect to the device. However, if I try
hcitool cc $HEADSET, the connection is closed immediately...)

I created an ~/.asoundrc with:

pcm.btheadset {
type plug
slave {
pcm {
type bluetooth
device "00:18:91:D0:7A:24"
profile "auto"
}
}
hint {
show on
description "BlueTooth Halterrego H.EAR 01 Headset"
}
}
ctl.btheadset {
type bluetooth
}

but when I try to use it with mplayer:

# mplayer -ao alsa:device=btheadset file.mp3

I get

bt_audio_service_open: connect() failed: Connection refused (111)
[AO_ALSA] Playback open error: Connection refused
Failed to initialize audio driver 'alsa:device=btheadset'
Could not open/initialize audio device -> no sound.
Audio: no sound
Video: no video


Exiting... (End of file)

What did I miss? (I recompiled bluez with support for alsa and alsa
with support for bluetooth)

Thanks! 

-- 
F. Delente
