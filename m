From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Where to put code for a new ioctl.
Date: Mon, 28 Nov 2005 12:57:45 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511281251250.9343@tm8103.perex-int.cz>
References: <4389943D.20100@superbug.co.uk> <s5hoe45knec.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe45knec.wl%tiwai@suse.de>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Nov 2005, Takashi Iwai wrote:

> At Sun, 27 Nov 2005 11:10:53 +0000,
> James Courtier-Dutton wrote:
> > 
> > I am looking at alsa-lib.
> > ./src/control/control_hw.c is there the actual ioctl call goes.
> > ./src/control/control.c calls the routine in control_hw.c
> > ./src/control/hcontrol.c calls the routine in control.c
> > ./src/mixer/simple_none.c handles the call from the user app, it then 
> > calls ??? hcontrol.c or control.c ?
> > 
> > So, my question is, if I have to write code between the user apps 
> > request and the ioctl. The purpose of the code is to take the request 
> > from the user, and then encapsulate it in the ioctl specific format, and 
> > then call the ioctl. Do I implement this encapsulating code in control.c 
> > or hcontrol.c ?
> 
> I vote for control.c.  But, anyway, I feel that the current
> implementation of mixer is too complex.  There are too many layers.
> 
> How about to reduce hcontrol stuff?  It's been never used except as a
> handle.

It's used for the simple mixer implementation to cache the control 
elements. Yes, the structure might look as complicated, but the mixer is 
complicated. So the structure is:

1) control - raw control API access
2) hcontrol - cached control API access, fast lookups etc...
3) mixer - mixer API
   3a) mixer simple none
   3b) mixer simple abstract

> BTW, James, please remember that you need a new ioctl just for limited
> drivers.  For dB conversion, only usb-audio, hda-codec and possibly
> emu10k1 (for user-space controls) would use this ioctl.  The other
> drivers don't need this ioctl at all - in other words, the dB
> conversion table shouldn't be implemented on the kernel space but on
> user space.

I 100% agree here. The new ioctl will fail or don't give dB info for most 
drivers. The possibility is to emulate the ioctl in control.c for rest 
hardware (probably it's the most easy solution), or leave it to 3b) mixer 
simple abstract layer. 

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
