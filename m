From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: My Codec: IDT 92HD75B3X5 issues
Date: Mon, 28 Sep 2009 06:58:46 +0300
Message-ID: <200909280658.46580.munzirtaha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 09EA9103813
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 05:58:51 +0200 (CEST)
Received: by bwz25 with SMTP id 25so7005381bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2009 20:58:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Daniel Chen <seven.steps@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi sirs,
These are the issues I have with my Laptop HP Pavilion dv6 1225ee regarding 
audio support.

1. No sense for headphone jack (jack_present?), when headphone is plugged 
(present_int_hp?)

2. There headphone mic jack is not working. The one next to the webcam is 
always recording even when I change the "Mic Jack" control from "Mic In" to 
"Line In"

3. The mute/unmute LED doesn't change color to RED when its muted like in 
Windows.

Touching that LED shows this in /var/log/messages:

Sep 28 06:53:47 dv6 kernel: [ 9197.986789] atkbd.c: Unknown key released 
(translated set 2, code 0x94 on isa0060/serio0).
Sep 28 06:53:47 dv6 kernel: [ 9197.986791] atkbd.c: Use 'setkeycodes e014 
<keycode>' to make it known.
Sep 28 06:53:47 dv6 kernel: [ 9198.353568] atkbd.c: Unknown key pressed 
(translated set 2, code 0x94 on isa0060/serio0).
Sep 28 06:53:47 dv6 kernel: [ 9198.353572] atkbd.c: Use 'setkeycodes e014 
<keycode>' to make it known.
Sep 28 06:53:47 dv6 kernel: [ 9198.359205] atkbd.c: Unknown key released 
(translated set 2, code 0x94 on isa0060/serio0).
Sep 28 06:53:47 dv6 kernel: [ 9198.359208] atkbd.c: Use 'setkeycodes e014 
<keycode>' to make it known.

alsa info is at:
http://www.alsa-project.org/db/?f=8f8518c634bc6880a1633e025fe7a7f975f3ed28


I also played with different models like
  hp-m4         HP mini 1000
  hp-dv5        HP dv series
  hp-hdx        HP HDX series
  hp-dv4-1222nr HP dv4-1222nr (with LED support)

but nothing helps.

-- 
Munzir Taha
Telecommunications and Electronics Engineer
Master CIW Designer, ICDL, MOUS, Linux+, LPI, SCSA
Riyadh, SA
