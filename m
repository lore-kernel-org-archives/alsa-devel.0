From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Delta 410 status
Date: Mon, 2 Dec 2002 19:57:54 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212021954480.521-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0212012216320.1488-100000@gin.nowhere.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0212012216320.1488-100000@gin.nowhere.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Reiner Klenk <pdq808@t-online.de>
Cc: "Alsa-devel@lists.sourceforge.net" <Alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 1 Dec 2002, Reiner Klenk wrote:

> On Sun, 1 Dec 2002, Reiner Klenk wrote:
> 
> > Greetings,
> > 
> > I have been fiddling around with a Midiman Delta 410 over the weekend. I
> > get some sort of playback but is is severly clipped. I believe there is a
> > typo in ak4524.c in inits_ak4529[]. Register 0x00 should be initialized to
> > 0x0c for i2s mode according to the data sheet (need to set DIF1 as well as
> > DIF0). I corrected this but that didn't help. My suspicion is that the
> > envy24 chip is not talking to the ak4529 at all (i.e. the control path via
> > the envy24 gpio is not working) since I also can't set or read the Volume
> > Controls with envy24control or amixer, however, the mixer elements that 
> > control the envy24 chip directly (routing, digital mix, meter readout) are 
> > all OK.
> > 
> 
> It's working now :-) . I kept the init for register 0 as stated above.  
> However, the chip adress of the 4529 is 0 (CAD1=0, CAD0=0, both pins are
> pulled down to ground with a 10k resistor) unlike the hardwired adress of
> the previous chips (0x02). Also, since the 4529 has 12 registers we cannot
> addr &= 0x07; in snd_ice1712_ak4524_write .

It's nice. Could you try the latest CVS? I've done all changes you've 
described.

> The faders in envy24control are still stuck at 000, but it is
> nevertheless possible to unmute the channels by clicking somewhere close 
> to the bottom of the faders. 

Should be fixed, too. Thank you very much.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
