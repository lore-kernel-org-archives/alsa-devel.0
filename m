From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Line-in not working on Audigy2
Date: Sat, 05 Nov 2005 16:27:14 -0500
Message-ID: <1131226035.6781.5.camel@mindpipe>
References: <20051104234906.GA7479@cm.nu>
	 <1131222612.13627.26.camel@mindpipe>  <20051105204154.GA2134@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <20051105204154.GA2134@cm.nu>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Shane <shane-alsa@cm.nu>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-11-05 at 12:41 -0800, Shane wrote:
> On Sat, Nov 05, 2005 at 03:30:11PM -0500, Lee Revell wrote:
> > > The card:
> > > 0000:03:00.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
> > >         Subsystem: Creative Labs: Unknown device 2006
> > 
> > This is probably just a driver bug.  Subsystem 2006 is not in the list
> > of PCI IDs.
> > 
> > Can you please provide name and the model number of the card.  This will
> > be something like "Audigy 2 ZS", model "SB0350".  This information may
> > be on the box, the card, or you can obtain it from the Windows driver.
> 
> Hmm, pulling this machine apart may take some time.  Is
> there any way to query the card in software under Linux. 
> Not sure if it helps but oss emu10k1 gives this:
> ACPI: PCI interrupt for device 0000:03:00.0 disabled
> Creative EMU10K1 PCI Audio Driver, version 0.20a, 16:12:50
> Nov  1 2005
> ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low)
> -> IRQ 169
> emu10k1: Audigy rev 4 model 0x2006 found, IO at
> 0xdc80-0xdcbf, IRQ 169
> 
> Could something like libdiscover or hotplug provide the
> model number?
> 

Try this patch.

Summary: Add support for Audigy 2 subsystem 2006.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- alsa-kernel/pci/emu10k1/emu10k1_main.c~	2005-11-05 14:22:34.000000000 -0500
+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-11-05 16:25:13.000000000 -0500
@@ -647,6 +647,16 @@
 	 .spk71 = 1,
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
+	/* Tested by shane-alsa@cm.nu 5th Nov 2005 */
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20061102,
+	 .driver = "Audigy2", .name = "Audigy 2 [2006]", 
+	 .id = "Audigy2",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20021102,
 	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0350]", 
 	 .id = "Audigy2",




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
