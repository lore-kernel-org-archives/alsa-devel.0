From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: Line-in not working on Audigy2
Date: Mon, 07 Nov 2005 10:51:23 -0500
Message-ID: <1131378684.8383.14.camel@mindpipe>
References: <20051104234906.GA7479@cm.nu>
	 <1131222612.13627.26.camel@mindpipe> <20051105204154.GA2134@cm.nu>
	 <1131226035.6781.5.camel@mindpipe>  <s5hd5lcpkpu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5lcpkpu.wl%tiwai@suse.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: Shane <shane-alsa@cm.nu>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-11-07 at 15:59 +0100, Takashi Iwai wrote:
> At Sat, 05 Nov 2005 16:27:14 -0500,
> Lee Revell wrote:
> > 
> > On Sat, 2005-11-05 at 12:41 -0800, Shane wrote:
> > > On Sat, Nov 05, 2005 at 03:30:11PM -0500, Lee Revell wrote:
> > > > > The card:
> > > > > 0000:03:00.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
> > > > >         Subsystem: Creative Labs: Unknown device 2006
> > > > 
> > > > This is probably just a driver bug.  Subsystem 2006 is not in the list
> > > > of PCI IDs.
> > > > 
> > > > Can you please provide name and the model number of the card.  This will
> > > > be something like "Audigy 2 ZS", model "SB0350".  This information may
> > > > be on the box, the card, or you can obtain it from the Windows driver.
> > > 
> > > Hmm, pulling this machine apart may take some time.  Is
> > > there any way to query the card in software under Linux. 
> > > Not sure if it helps but oss emu10k1 gives this:
> > > ACPI: PCI interrupt for device 0000:03:00.0 disabled
> > > Creative EMU10K1 PCI Audio Driver, version 0.20a, 16:12:50
> > > Nov  1 2005
> > > ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low)
> > > -> IRQ 169
> > > emu10k1: Audigy rev 4 model 0x2006 found, IO at
> > > 0xdc80-0xdcbf, IRQ 169
> > > 
> > > Could something like libdiscover or hotplug provide the
> > > model number?
> > > 
> > 
> > Try this patch.
> > 
> > Summary: Add support for Audigy 2 subsystem 2006.
> > 
> > Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> 
> FYI, I applied it to CVS now.  Thanks.
> 

It would be a big help if someone has time to write a perl script to
extract the PCI ID -> name and model number mapping from the Windows
drivers, http://www.kxproject.com, and generate the hardware features
table.  Email me privately and I'll send you the .inf file.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
