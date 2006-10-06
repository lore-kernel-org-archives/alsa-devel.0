From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: 1.0.13 and indigoio
Date: Fri, 6 Oct 2006 19:02:22 +0400
Message-ID: <70a871c80610060802n22a3f184g8b206b11bd0608de@mail.gmail.com>
References: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
	<s5hbqororyw.wl%tiwai@suse.de>
	<70a871c80610050549i67273c2bs4eab40731685bb47@mail.gmail.com>
	<s5hu02iu1ni.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0610061220220.4839@denise.shiny.it>
	<70a871c80610060712k2f04c1bbpa73fd1473f840871@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80610060712k2f04c1bbpa73fd1473f840871@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

linux-2.6.17-gentoo-r6, alsa-driver-1.0.11, alsa-firmware-1.0.11

booted without the card.

[4294713.088000] pccard: CardBus card inserted into slot 0
[4294713.140000] PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
[4294713.140000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 185
[4294713.248000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5
[4294724.488000] pccard: card ejected from slot 0
[4294724.519000] PCMCIA: socket c18cb028: *** DANGER *** unable to
remove socket power
[4294734.271000] pccard: CardBus card inserted into slot 0
[4294734.271000] PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
[4294734.271000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 185
[4294734.292000] ALSA
/mnt/bits/portage/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/pci/echoaudio/echoaudio.c:2010:
Card registered: Indigo IO rev.0 (DSP56361) at 0x54000000 irq 185

cards works. Then:

[4294888.595000] pccard: card ejected from slot 0
[4294892.873000] pccard: CardBus card inserted into slot 0
[4294892.873000] PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
[4294892.873000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 185
[4294892.898000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5
[4294901.091000] pccard: card ejected from slot 0
[4294901.122000] PCMCIA: socket c18cb028: *** DANGER *** unable to
remove socket power
[4294904.843000] pccard: CardBus card inserted into slot 0
[4294904.843000] PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
[4294904.843000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 185
[4294904.892000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5
[4294976.527000] pccard: card ejected from slot 0
[4294976.558000] PCMCIA: socket c18cb028: *** DANGER *** unable to
remove socket power
[4294983.133000] pccard: CardBus card inserted into slot 0
[4294983.133000] PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
[4294983.133000] ACPI: PCI Interrupt 0000:07:00.0[A] -> GSI 18 (level,
low) -> IRQ 185
[4294983.158000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
