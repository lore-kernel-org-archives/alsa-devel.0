From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: 1.0.6rc1 packages
Date: Thu, 5 Aug 2004 10:44:32 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <59465.195.245.190.94.1091699072.squirrel@195.245.190.94>
References: <32796.192.168.1.5.1091660025.squirrel@192.168.1.5>   
    <26012.1091692137@www37.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.netcabo.pt (smtp.netcabo.pt [212.113.174.9])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0DF27215
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 11:45:16 +0200 (MEST)
In-Reply-To: <26012.1091692137@www37.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@alsa-project.org, annabellesgarden@yahoo.de, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi Martin,

>
>> Tomorrow I'll try on my dreaded laptop, Mdk10.0, 2.6.8-rc2 UP kernel,
>> where recent snd-usb-usx2y it's known to freeze the whole system :(
>>
>> BTW, it's not a SMP vs. UP issue, as I've tested today on a SMP kernel
>> with a very same config as of my other box, and the freezing result wa=
s
>> the same.
>
> different usb controllers? Problems with non-UHCI?
>

Probably. lspci -v gives:

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at d4000000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <available only to root>

00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at d4009000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <available only to root>

where relevant lines of lsmod output are:

ohci_hcd               21124  0
usbcore               113892  5 snd_usb_usx2y,snd_usb_lib,ohci_hcd

so, it seems that is a non-UHCI system.

Is there a definite issue with OHCI controllers?

Please note that it used to work, right before Karten's 0.7.1 patch of
July 13, or something. The other fact is that all the firmware load steps
are taken successfully, even us428control starts and works as expected.
The MIDI interface is working OK.

The main problem "only" happens exactly when one tries to open the PCM
device: the whole system freezes pretty bad, bang!. Again, when using
stock alsa-driver-1.0.5a this does not occur.

Is there anything I can do to get around this ?

Highly appreciated.
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
