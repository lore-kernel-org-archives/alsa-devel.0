From: Christian Esken <c.esken@cityweb.de>
Subject: Re: RC7 and CS46xx (GTXP)
Date: Sun, 9 Feb 2003 16:53:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302091653.30926.c.esken@cityweb.de>
References: <20030201144858.0479188a.flame@home.se> <s5h7kchip8i.wl@alsa2.suse.de> <20030203131737.00bb2c0b.flame@home.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030203131737.00bb2c0b.flame@home.se>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Monday 03 February 2003 13:17 schrieb Richard Olsson:
> On Mon, 03 Feb 2003 12:21:33 +0100
>
> Takashi Iwai <tiwai@suse.de> wrote:
> > could you try the latest cvs version?
> > i just changed a little the code.
> > hopefully this works for you...
>
> I tried the new version just a moment ago as the CVS changelog mentioned
> the magic word "amplifier" ;).  The warning message in dmesg is gone but
> the sound is still disorted - sounds just like the amplifier isn't
> turned on or something.

Same for me. Using a current version from CVS (today oder yesterday), I have
terrible distortions. The last good version for me was 0.9.0rc2.

Sound is distorted always, additionaly sometimes a kernel message pops
up in the kernel log ("Unexpected hw_pointer value"):

Feb  9 15:47:37 bjork kernel: PCI: Found IRQ 7 for device 00:0a.0
Feb  9 15:47:37 bjork kernel: ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3870: hack for Hercules Game Theatre XP enabled
Feb  9 15:52:21 bjork kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, delta: -512, max jitter = 8192): wrong interrupt acknowledge?

Chris



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
