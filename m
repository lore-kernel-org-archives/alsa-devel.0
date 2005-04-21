From: "rwd" <rwd@arcor.de>
Subject: maestro3 hardware volume control
Date: Thu, 21 Apr 2005 16:17:55 +0200
Message-ID: <000001c5467c$ea1bb2e0$6502a8c0@SCA600>
References: <s5hu0m3asei.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1F5D61B8
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2005 16:18:03 +0200 (MEST)
In-Reply-To: <s5hu0m3asei.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Von: alsa-devel-admin@lists.sourceforge.net 
> von Takashi Iwai
> Gesendet: Dienstag, 19. April 2005 14:00
> 
> The registers above didn't work at the last time we tried.
> Feel free to debug it :)
> 
> 
> Takashi
> 

Hi,

I tried to :)
Some findings:

I configured the PCI_ALLEGRO_CONFIG with additional  HV_CTRL_ENABLE |
HV_BUTTON_FROM_GD
to enable the HV according to the wiring of the buttons in my box.

snd_m3_interrupt constantly comes up with status 0x04 !?! What's that? Bad
docu - no info, as you said, any idea?
When i press a HV button, status changes to 0x44 -> HV interrupt pending!
Also you can see the HV registers SHADOW_MIX_REG_VOICE 0x1C etc. changing
when the buttons are pressed.
Looks like i'm almost there??

Still some questions:
- I tried to apply HV_INT_ENABLE to the HOST_INT_CTRL register. Box freezes
when i press a button - obviously an interrupt is fired & not handled
correctly - no idea how to do it. Is it required anyway? Buttons respond
even without HV_INT_ENABLE.

- status from snd_m3_interrupt is stuck to 0x44. Any way to clear/ack the
pending interrupts?

- now that i can read the buttons - what's the right way to change the
master/mixer/whatever volume (oops, i admit i'm a rookie...:) ?

Thanks, Ruediger



-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
