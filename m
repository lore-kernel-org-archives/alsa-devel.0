From: Ronald Horn <Ronald.Horn@web.de>
Subject: Re: ICH9 Sound
Date: Mon, 06 Oct 2008 18:38:07 +0200
Message-ID: <1952499267@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=-------------12233110882565906937"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate06.web.de (fmmailgate06.web.de [217.72.192.247])
	by alsa0.perex.cz (Postfix) with ESMTP id E7977244AF
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 18:38:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, suse@easylinux.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--=-------------12233110882565906937
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hello,

all mixer levels are ok.
I have several times checked all settings. I deinstalled and reinstalled the drivers in yast2, too.

The phenomenon is that then a sound is playing, once an incredible noice is playing over the original sound.
And this sound is stopping first about ten seconds after I closed the player. It's like an feedback loop.

Greetings
Ronald




> ICH9 sound should be supported. And, as you see, your card is
> detected. Perhaps the codec or that specific notebook isn't supported.
> Are you sure mixer levels are adjusted properly?



> > I'm using a HP Pavilion dv7-1045eg. The Problem is I have no sound,
> > because there is no driver witch works.
> > Here are some reports from my system:
> > /
> > lspci -nv/
> > 00:1b.0 0403: 8086:293e (rev 03)
> >        Subsystem: 103c:30f4
> >        Flags: bus master, fast devsel, latency 0, IRQ 22
> >        Memory at df300000 (64-bit, non-prefetchable) [size=16K]
> >        Capabilities: [50] Power Management version 2
> >        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
> > Queue=0/0 Enable+
> >        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
> >        Capabilities: [100] Virtual Channel <?>
> >        Capabilities: [130] Root Complex Link <?>
> >        Kernel driver in use: HDA Intel
> >        Kernel modules: snd-hda-intel
> >
> > /
> > cat /proc/asound/cards/
> >  0 [Intel      ]: HDA-Intel - HDA Intel
> >                      HDA Intel at 0xdf300000 irq 22
> >
> >
> > /head -n 1 /proc/asound/card0/codec*/
> > ==> /proc/asound/card0/codec#0 <==
> > Codec: IDT 92HD71B7X
> > ==> /proc/asound/card0/codec#2 <==
> > Codec: Generic 10de ID 6
> >
> >
> > I'm using openSuse 11.0 with Kernel 2.6.25.16-0.1-pae.
> > Maybe your project could develop some drivers.




--=-------------12233110882565906937
Content-Type: text/x-vCard;
 name="Ronald Horn.vcf"
Content-Disposition: attachment;
 filename="Ronald Horn.vcf"
Content-Transfer-Encoding: 7bit

BEGIN:VCARD
VERSION:2.1
N:Horn;Ronald;;;
FN:Ronald Horn
EMAIL;INTERNET:ronald.horn@web.de
END:VCARD
--=-------------12233110882565906937
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-------------12233110882565906937--
