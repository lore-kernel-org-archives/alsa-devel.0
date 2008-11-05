From: LCID Fire <lcid-fire@gmx.net>
Subject: Hints for usb audio patch
Date: Wed, 05 Nov 2008 12:07:19 +0100
Message-ID: <49117E67.8000100@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id DAE821037EB
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 12:07:24 +0100 (CET)
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
I have a patch lying around for some month now and would need some hints
how to correctly implement it.

1. What's the correct way to save the state of a special feature? There
is a switch which turns on a certain feature in the usb mixer. Looking
at the struct usb_mixer_interface I implemented it similar to
"audigy2nx_leds" - by adding a new u8 (and the necessary functions).

2. Should one rather set ignore_ctl_error to 1 (which I currently do) or
sort the errors out by adding a handling for a specific device?

3. For the switch to active I need an interrupt message for which I
implemented snd_usb_interrupt_trans since I did not find any other
convenience function to do this.
