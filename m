From: Andrea Borgia <andrea@borgia.bo.it>
Subject: added support for remote in Toshiba SB0500
Date: Sun, 04 Jan 2009 23:24:43 +0100
Message-ID: <4961372B.1010905@borgia.bo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vsmtp4.tin.it (vsmtp4.tin.it [212.216.176.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F3F21037F1
	for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2009 23:24:45 +0100 (CET)
Received: from mononoke.chateaunet (79.2.57.216) by vsmtp4.tin.it (8.0.022)
	id 48BEAB7B0744FC97 for alsa-devel@alsa-project.org;
	Sun, 4 Jan 2009 23:24:43 +0100
Received: from localhost.chateaunet ([127.0.0.1])
	by mononoke with esmtp (Exim 4.69)
	(envelope-from <andrea@borgia.bo.it>) id 1LJbOl-0002qQ-84
	for alsa-devel@alsa-project.org; Sun, 04 Jan 2009 23:24:43 +0100
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

I have a Toshiba SB-0500 (041e:3048), which is basically a USB hub plus
ethernet card plus sound card with remote. As of alsa 1.0.18a / linux
2.6.28 this beast is only partially supported by snd-usb-audio and, most
importantly for me, the remote does not work (hub and ethernet are ok).

Considering the similarities with the SB 24 Live External and with the
Audigy, I tried patching usbmixer.c and usbmixer_maps.c until I got it
working with lirc's alsa_usb module. Please note that I didn't test
mixer functionality and I have not much interest in that part for my use.

What should I do to get my patches reviewed and possibly incorporated
into the next version? The changes are rather trivial imho but still
this is my first serious attempt at kernel hacking.

Thanks for your help,
Andrea.
