From: LCID Fire <lcid-fire@gmx.net>
Subject: Usb driver correction
Date: Sun, 27 Jan 2008 18:14:16 +0100
Message-ID: <479CBBE8.3090306@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 153D71037F9
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 18:14:23 +0100 (CET)
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

Hi.
I hope you guys can help me with 3 problems I have.
I have a usb device which has 3 streams - which all work fine (that's
not the problem yet ;)).
Aside from this there is also a mixer created. Alsa cannot retrieve any
information from the mixer - not the minimum, nor the maximum or current
value. Basicly alsa leaves the mixer in a state where it cannot be used
- which leads to a question why not omnit the mixer?
What I am ending up with are these 2 volumes:
[4] FU [PCM Capture Volume] ch = 1, val = 0/1/1
[9] FU [PCM Capture Volume] ch = 1, val = 0/1/1

What would I have to do to disable these?
Is it enough to define a usbmix_name_map in usbmixer_maps.c with {4,
NULL} and {9, NULL}?

Also, the usb device has a switch - from line input to phono input. I
know what control message I have to send to change the switch - but
where has such an additional switch to be implemented?
Is it similar to snd_audigy2nx_led_get in usbmixer.c?

Would be great if someone could explain these mysteries to me ;)
