From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Stuttering 100mA and 500mA MaxPower usb audio
 investigation on bus powered and external powererd usb hubs
Date: Sat, 08 Nov 2008 21:56:24 +0100
Message-ID: <4915FCF8.9040703@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node02.cambriumhosting.nl (node02.cambriumhosting.nl
	[217.19.16.163])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DFCB10381E
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 21:55:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by node02.cambriumhosting.nl (Postfix) with ESMTP id 1411EB00017D
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 21:55:24 +0100 (CET)
Received: from node02.cambriumhosting.nl ([127.0.0.1])
	by localhost (node02.cambriumhosting.nl [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id djEr6PltSu3y for <alsa-devel@alsa-project.org>;
	Sat,  8 Nov 2008 21:55:23 +0100 (CET)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by node02.cambriumhosting.nl (Postfix) with ESMTP id 850DFB000115
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 21:55:23 +0100 (CET)
Received: from [192.168.1.213] (unknown [192.168.1.213])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id CE18423BC331
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 20:20:24 +0100 (CET)
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

Hello everybody,

I have been testing several scenarios to find some glues why some usb
audio devices did not fully work and gave stuttering sounds I found the
following:

usb devices define a max power attribute during there enumeration
process. I have some usb devices that have this at 500mA and some that
have this on 100mA.

I also have some usb hubs that have external extra power supply and some
that are only a hub with bus power.

Here it comes:

Make sure the 4 port usb hub is full with for example:
- usb keyboard (100mA)
- usb mouse (100mA)
- usb audio (100mA or 500mA)
- usb stick (200mA/500mA)

- usb hub with external power (500mA MaxPower) (AC adapter delivers 1A)
- usb hub without external power (100mA MaxPower)

Make sure to use audio with several tones low tones (most dvds will do)

When connecting a 100mA usb audio devices on a hub with external power
it will give stuttering sound!! (most usb audo devices are 100mA and
most hubs are external powered due to more then one usb stick)

When connecting a 500mA usb audio device on a hub with external power it
will work perfectly.

When connecting a 100mA or a 500mA usb audio device on a hub without
external power it will work perfectly.

I have the idea there is something wrong with the power distribution
system when using external powered usb hubs...

Any ideas how to correctly address this problem/bug?

Best regards,

Jelle
