From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Support for Midiman M-Audio Delta 410
Date: Thu, 31 Oct 2002 13:23:19 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210311322380.521-100000@pnote.perex-int.cz>
References: <s5hadkuc44h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadkuc44h.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "ajh@watri.uwa.edu.au" <ajh@watri.uwa.edu.au>
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Oct 2002, Takashi Iwai wrote:

> At Wed, 30 Oct 2002 09:14:56 +0100,
> Kristof Pelckmans wrote:
> > 
> > Hi all,
> > 
> > I bought a M-Audio Delta 410 card last weekend. When I tried loading the snd-
> > ice1712 module and unmuting all channels, I got a scrambled sound. (I did not 
> > try the envy24control since I have no X)
> > 
> > The last few days, I did some research and I found out in the sourcecode that 
> > the card is not fully supported.
> > 
> > Based on my pictures (see 
> > http://home.planetinternet.be/~kpelckma/delta410/delta410.html) I deduct that 
> > the Delta 410 has following chips :
> > - 1x AK4529VQ (A/D and D/A conversion) NOT SUPPORTED ?
> > - 1x CS8427 (tranceiver, I/O for AK4529 & S/PDIF), SUPPORTED also appears in 
> > Delta 1010LT and Delta Audiophile cards
> > - 1x ENVY24, SUPPORTED by ice1712
> > - 1x L7805CV (voltage regulator)
> > - 6x 5532 2036B JRC (operational amplifier, buffering & filtering)
> > 
> > In my opinion the real missing piece of code is the driver for the AK4529. Has 
> > any development been done to support this chipset ? For more technical 
> > information, see http://www.asahi-kasei.co.jp/akm/en/product/ak4529/ak4529.html.
> 
> the patch for ak4529 is already on my tree, but still lack of
> information about GPIO bits for Delta410, so it's not functional at
> all.
> just waiting for answers from m-Audio.

Kristof, could you give us info to which GPIO pins of ICE1712 is the 
AK4529 chip connected?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
