From: Justin Cormack <justin@street-vision.com>
Subject: Re: RME HDSP9652
Date: 28 Nov 2002 16:22:44 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038500569.1476.5.camel@lotte>
References: <200211281337.gASDbvf00556@tench.street-vision.com>
	<1038494386.20379.31.camel@lotte>  <s5hwumxzoqd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwumxzoqd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2002-11-28 at 15:40, Takashi Iwai wrote:

> > > all i need is the PCI ID from you. i've already spoken to RME about
> > > the card, and the claim is that it will with the existing h-dsp
> > > driver. the only thing that won't work are the RMS meters. the
> > > existing driver, however, doesn't recognize the PCI ID and so it
> > > doesn't work.
> > > 
> > 
> > Its the same PCI ID, but insmod segfaults...
> 
> does the attched patch cure the segfault?
> but it doesn't mean that your card will be supported by it :)

Thanks, this fixes the segfault, and adding the rev 0x64 in
snd_hdsp_create makes it work... It recognises the IO box as a digiface
which I think is ok (3x adat + midi + 2 * spdif). Playback works, and
the mixer is recognised - will test it further.

thanks for everyones help.

Justin




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
