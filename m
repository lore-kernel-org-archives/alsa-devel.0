From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH]snd-usb-usx2y 0.8.7: Use macro usb_maxpacket()
 for portability
Date: Thu, 9 Dec 2004 09:18:04 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412090914550.3423@pnote.perex-int.cz>
References: <200412021319.20027.annabellesgarden@yahoo.de>
 <200412062315.01880.annabellesgarden@yahoo.de> <s5hfz2iba7x.wl@alsa2.suse.de>
 <200412072301.52065.annabellesgarden@yahoo.de> <s5hoeh4a8nh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoeh4a8nh.wl@alsa2.suse.de>
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
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Dec 2004, Takashi Iwai wrote:

> At Tue, 7 Dec 2004 23:01:51 +0100,
> Karsten Wiese wrote:
> > 
> > >>>>
> > Summary: hwdep interface for pcm data.
> > 
> > Implements "rawusb" pcm data transfer through hwdep interface:
> > The usb_hc moves pcm data from/into memory via DMA.
> > That memory is mmaped by jack's usx2y driver.
> > Jack's usx2y driver is the first/last executable code to read/write pcm data.
> > Read/write is a combination of power of 2 period shaping and float/int conversation.
> > Compared to standard alsa/jack we leave out power of 2 period shaping
> > inside snd-usb-usx2y which needs memcpy() and additional buffers.
> > As a side effect possible unwanted pcm-data coruption resulting of
> > standard alsa's snd-usb-usx2y period shaping scheme falls away.
> > Result is sane jack operation at buffering schemes down to 128frames, 2 periods.
> > Also changed Kconfig file, so snd-usb-usx2y is only available for X86, PPC or ALPHA platforms,
> > as on others DMA-memory isn't mmapable.
> > 
> > Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
> > <<<<
> 
> Thanks, applied to the CVS tree now.
> Please check later whether it works for you...

My feeling is that it's against all we're trying to do with the PCM 
interface. Cannot we extend/optimize the current PCM API? Using hwdep for 
PCM data transfers seems very ugly. We can add a new special access method 
for example for URBs etc. I think that we will have exactly similar 
problem with Bluetooth and Firewire.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
