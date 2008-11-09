From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: Stuttering 100mA and 500mA MaxPower usb audio
 investigation on bus powered and external powererd usb hubs
Date: Sun, 09 Nov 2008 16:55:31 +0100
Message-ID: <491707F3.4070806@powercraft.nl>
References: <4915FCF8.9040703@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node04.cambriumhosting.nl (node04.cambriumhosting.nl
	[217.19.16.165])
	by alsa0.perex.cz (Postfix) with ESMTP id 85981103815
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 16:55:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by node04.cambriumhosting.nl (Postfix) with ESMTP id E3345B0000E1
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 16:55:34 +0100 (CET)
Received: from node04.cambriumhosting.nl ([127.0.0.1])
	by localhost (node04.cambriumhosting.nl [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id 2IYnAH3XG3HX for <alsa-devel@alsa-project.org>;
	Sun,  9 Nov 2008 16:55:33 +0100 (CET)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by node04.cambriumhosting.nl (Postfix) with ESMTP id 31DB4B0000BA
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 16:55:33 +0100 (CET)
Received: from [192.168.1.213] (unknown [192.168.1.213])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id AD5CF23BC3D2
	for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2008 15:20:34 +0100 (CET)
In-Reply-To: <4915FCF8.9040703@powercraft.nl>
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

Jelle de Jong wrote:
> Hello everybody,
> 
> I have been testing several scenarios to find some glues why some usb
> audio devices did not fully work and gave stuttering sounds I found the
> following:
> 
> usb devices define a max power attribute during there enumeration
> process. I have some usb devices that have this at 500mA and some that
> have this on 100mA.
> 
> I also have some usb hubs that have external extra power supply and some
> that are only a hub with bus power.
> 
> Here it comes:
> 
> Make sure the 4 port usb hub is full with for example:
> - usb keyboard (100mA)
> - usb mouse (100mA)
> - usb audio (100mA or 500mA)
> - usb stick (200mA/500mA)
> 
> - usb hub with external power (500mA MaxPower) (AC adapter delivers 1A)
> - usb hub without external power (100mA MaxPower)
> 
> Make sure to use audio with several tones low tones (most dvds will do)
> 
> When connecting a 100mA usb audio devices on a hub with external power
> it will give stuttering sound!! (most usb audo devices are 100mA and
> most hubs are external powered due to more then one usb stick)
> 
> When connecting a 500mA usb audio device on a hub with external power it
> will work perfectly.
> 
> When connecting a 100mA or a 500mA usb audio device on a hub without
> external power it will work perfectly.
> 
> I have the idea there is something wrong with the power distribution
> system when using external powered usb hubs...
> 
> Any ideas how to correctly address this problem/bug?
> 
> Best regards,
> 
> Jelle
>

I did some more debugging, it think the 100mA/500mA behavior is just an
effect of the real problem the usb isochronous audio bandwidth under
Linux is doing some things that make usb audio not working very well.

I wanted to be able to use 4 usb audio device on one usb at the same
time. using a powered usb hub this gives shuttering sound. What are the
max usb bandwidth limits on Linux?

I also found out that the only what that all usb audio device work is to
connected them directly without any hub between them. This takes up a
lot of resources.

Would somebody have to possibility to take a good look at the usb audio
issues with multiple devices and isochronous transfers?

Thank in advance,

Jelle
