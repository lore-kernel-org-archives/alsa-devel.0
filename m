From: Mark Knecht <markknecht@comcast.net>
Subject: Re: VT8233/A/8235 Clock Problem
Date: Mon, 08 Dec 2003 07:34:53 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070897693.1808.10.camel@Wizard.knechthome.com>
References: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: drclaw@dogsolitude.org, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-12-08 at 01:05, Clemens Ladisch wrote:
> drclaw@dogsolitude.org wrote:
> > Hi, I've got a motherboard with a builtin soundcard, proc/pci says:
> > VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 80)
> > (The Mobo is a Gigabyte GA-7VAX, a VIA KT400 chipset with a VT8235)
> >
> > and I find that (on Line 83 in alsa-kernel/pci/via82xx.c) the:
> > static int ac97_clock[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 48000};
> >
> > ...works better for me when the 48000 is changed to 44100.
> 
> This is a module option; instead of changing this line, you are
> supposed to put the following line into modules.conf:
> 
>   options snd-via82xx ac97_clock=44100
> 
> (or, if an options line for this module already exists, add it there)
> 
> 
> HTH
> Clemens
> 

Clemens,
  This is helpful. I'm having similar problems, so I'll try this out
later today.

   BTW - how can I get a list of all possible module options for a given
card or device? Is there any way to find out about this  without reading
the code?

Thanks,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
