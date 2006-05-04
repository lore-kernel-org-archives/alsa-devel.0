From: Nigel Gilbert <norb@dscape.freeserve.co.uk>
Subject: Re: Hard lock up when using ALSA midi in
Date: Thu, 04 May 2006 10:01:07 +0100
Message-ID: <1146733268.8805.13.camel@maltbury3.norbnet.org>
References: <1146652407.7497.4.camel@maltbury3.norbnet.org>
	 <s5hodyfgwng.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hodyfgwng.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-05-03 at 13:44 +0200, Takashi Iwai wrote:
> At Wed, 03 May 2006 11:33:27 +0100,
> Nigel Gilbert wrote:
> > 
> > Hi all,
> > 
> >   I've been trying to use Rosegarden or Museseq to compose some music
> > and have discovered that, when software connects to the MIDI IN on my
> > sound card, the machine locks up totally (a reboot is required).
> > 

[snip]

> It's likely the problem of integrated mpu401 on cmedia chip.
> In the earlier version, only the legacy mpu port (0x300-0x330) was
> used, but it was changed to detect the availabilty of the built-in mpu
> port in the recent version.   It seems that this brings up a problem
> sometimes (e.g. at rmmod).

Out of interest, when you say "earlier version" do you mean earlier
version of the hardware, or earlier version of the driver?

> 
> Try the patch below to disable the integrated midi.  You need to pass
> mpu_port=0x300 or another value to activate the legacy MPU port on
> this chip.  Or, depending on the hardware implementation, you need to
> use snd-mpu401 with ACPI PnP as the secondary card, instead.

That patch works a treat. I already had mpu_port=0x320 as a module
option and it just works.

Cheers,
  -Nige

> 
> Takashi
> 
> diff -r 0f367ec087bb pci/cmipci.c
> --- a/pci/cmipci.c	Wed May  3 09:59:03 2006
> +++ b/pci/cmipci.c	Wed May  3 13:43:23 2006
> @@ -2931,7 +2931,8 @@
>  		return err;
>  	}
>  
> -	integrated_midi = snd_cmipci_read_b(cm, CM_REG_MPU_PCI) != 0xff;
> +	/* integrated_midi = snd_cmipci_read_b(cm, CM_REG_MPU_PCI) != 0xff; */
> +	integrated_midi = 0;
>  	if (integrated_midi)
>  		iomidi = cm->iobase + CM_REG_MPU_PCI;
>  	else {
> 
-- 
Nigel Gilbert <norb@dscape.freeserve.co.uk>




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
