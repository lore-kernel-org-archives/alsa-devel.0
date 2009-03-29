From: Tom Watson <sdc695@yahoo.com>
Subject: Attempts to get a USB device operating.
Date: Sat, 28 Mar 2009 22:15:53 -0700 (PDT)
Message-ID: <219966.95306.qm@web65406.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65406.mail.ac4.yahoo.com (web65406.mail.ac4.yahoo.com
	[76.13.9.26]) by alsa0.perex.cz (Postfix) with SMTP id 7E3BB1037EA
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Mar 2009 07:15:54 +0200 (CEST)
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


I've got a (real) cheap usb sound "card" that partially works with ALSA.  I can get the microphone input to respond by fiddling with some of the switches, but I have been unable to ge the output functions to work (produce output) at all.  The "indicating" (power) light flashes, but I get no sound.  Another thing that is weird is that while the litle box has SPDIF connections (both in and out) I don't see them on the mixer panel.  Any clues would be appreciated.  I have done the upload using 'alsa-info' with the defaults.  Some brief details:
lsusb yields:
Bus 001 Device 034: ID 0d8c:0102 C-Media Electronics, Inc.

The output mixer panel shows two outputs (speakers),
The input mixer shows three inputs (2xPCM, 1 Mic).
The switches mixer shows a PCM capture source and a single PCM switch.

Are there any experiments I can do to help out in the investigation?  I'm only using aplay/arecord in doing this test, just to make things 'easy' to diagnose.

Thanks for the help.

-- 
Tom Watson
tsw@johana.com
