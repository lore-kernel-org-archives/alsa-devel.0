From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: MIDI input broken with ECS P4S5A/DX+ motherboard and generic
 MPU-401 driver. (Output works fine, though.)
Date: Wed, 29 Jan 2003 11:17:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301291115150.1402-100000@pnote.perex-int.cz>
References: <20030128203917.GA485@znex>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030128203917.GA485@znex>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark J Roberts <mjr@znex.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Jan 2003, Mark J Roberts wrote:

> [ An evil list-moderator bot ate the first version of this. ]
> 
> I'm running kernel 2.5.49, built with the generic MPU-401 MIDI
> driver, and booted with the "snd-mpu401=1,-1,,0x300,10" option,
> which corresponds to IO port 0x300 and IRQ 10.
> 
> I've configured my BIOS to enable the on-board MIDI interface, and
> set it to port 0x300 and IRQ 10.
> 
> I see zero interrupts in /proc/interrupts:
> 
>  10:          0          XT-PIC  MPU401 UART
> 
> So, any ideas?

You've pointed to the reason: hardware does not generate input interrupts.
Try to disable the IRQ (snd-mpu401=1,,,0x300,-1).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
