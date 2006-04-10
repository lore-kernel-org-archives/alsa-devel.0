From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [2.6 patch] move EXPORT_SYMBOL's away from sound/pci/emu10k1/emu10k1_main.c
Date: Mon, 10 Apr 2006 19:22:14 +0200
Message-ID: <20060410172214.GA8612__4328.02238869971$1144689823$gmane$org@mars.ravnborg.org>
References: <20060407003105.GG7118@stusta.de> <s5hu095y367.wl%tiwai@suse.de> <20060407184909.GB9097@mars.ravnborg.org> <s5hodz992lx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pasmtp.tele.dk (pasmtp.tele.dk [193.162.159.95])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1353E172
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 19:22:22 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hodz992lx.wl%tiwai@suse.de>
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
Cc: Adrian Bunk <bunk@stusta.de>, perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 10, 2006 at 11:55:22AM +0200, Takashi Iwai wrote:
 > > > This patch moves the EXPORT_SYMBOL's from 
> > > > sound/pci/emu10k1/emu10k1_main.c to the files with the actual functions.
> > > 
> > > What is the merit of this movement?
> > 
> > 1) Documentation - it is obvious that the function/data is exported so
> > be a bit mroe careful when introducing changes
> > 2) Style. In 2.6 the preferred style is to put the EXPORT_SYMBOL on the
> > line following the closing } of the exported function.
> > 3) Keep changes local. If one removes a previously exported symbol less
> > files needs to be touched.
> 
> I know the above for the new codes, yes.  But my question is wheter do
> we get a good enough benifit by changing the existing code.
> 
> I'm not against such an action but just wornder whether it's really
> needed.  If yes, we should do it over the whole tree.
That has been done to a lot of existing code also.
In the 2.4 days it made sense to have them grouped due to build system
limitations - that is no longer the case with 2.6 so it is preferred to
do it correct.

	Sam


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
