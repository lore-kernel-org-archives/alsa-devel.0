From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: EWX 24/96 SPDIF input problem with 0.9.4 (and
 "compiler.h")
Date: Mon, 30 Jun 2003 16:53:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306301651490.13946-100000@pnote.perex-int.cz>
References: <s5hn0fzljm8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0fzljm8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Denis Sbragion <d.sbragion@infotecna.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Jun 2003, Takashi Iwai wrote:

> Hi,
> 
> At Tue, 17 Jun 2003 09:50:29 +0200,
> Denis Sbragion wrote:
> > 
> > Hello all,
> > 
> > I found that the SPDIF input on my TerraTec EWX 24/96 no longer works with 
> > the latest 0.9.4 drivers. I digged into the cs8427.c code and I found that 
> > this lines in function 'snd_cs8427_create' of version 0.9.3:
> > 
> > ...
> > /* CS8427_REG_RECVERRMASK: unmask the input PLL clock, V, confidence, 
> > biphase, parity status bits */
> > /* CS8427_UNLOCK | CS8427_V | CS8427_CONF | CS8427_BIP | CS8427_PAR,
> > Why setting CS8427_V causes clicks and glitches? */
> > CS8427_UNLOCK | CS8427_CONF | CS8427_BIP | CS8427_PAR,
> > ...
> > 
> > have been changed into:
> > 
> > ...
> > /* CS8427_REG_RECVERRMASK: unmask the input PLL clock, V, confidence, 
> > biphase, parity status bits */
> > /* CS8427_UNLOCK | CS8427_V | CS8427_CONF | CS8427_BIP | CS8427_PAR, * /
> > 0xff, /* set everything */
> > ...
> > 
> > in version 0.9.4, along with some other changes. The "Why setting CS8427_V 
> > causes clicks and glitches?" comment of version 0.9.3 comes from an old 
> > patch I sent to Jaroslav many months ago, when I had a similar problem with 
> > an older 0.9.0something version of the drivers. The fact that this patch 
> > has been rolled back makes me think that there are some other cards out 
> > there that need that flag, so I think that a card dependent intialization 
> > is needed here, but I don't know how to code it. Of course I'm willing to 
> > help in coding and testing everything that may be needed to make the driver 
> > run, though I can only test on my own EWX. Relevant environment: RedHat 
> > Linux 7.2, 2.4.7 kernel.
> 
> thanks for spotting this out.
> 
> as you suggested above, i added the ews-specific initialization
> there.  it just resets the RECVERRMASK register afterwards in
> ews.c.  please try the cvs version.

Sorry for late reply. My EWS 24/96 does not have this problem. I suggest 
to create a control which will turn on/off the V bit checking. I also 
suggest to verify the cable connection.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
