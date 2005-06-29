From: christophe barbe <christophe@cattlegrid.net>
Subject: Re: intel8x0 ACPI suspend/resume bug
Date: Wed, 29 Jun 2005 11:49:13 -0400
Message-ID: <20050629154913.GD8460@cattlegrid.net>
References: <20050628150638.GB6677@cattlegrid.net> <s5hacl97blk.wl%tiwai@suse.de> <1120052108.14654.3.camel@localhost.localdomain> <20050629153825.GC8460@cattlegrid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050629153825.GC8460@cattlegrid.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2005 at 11:38:25AM -0400, christophe barbe wrote:
> On Wed, Jun 29, 2005 at 09:35:08AM -0400, christophe barbe wrote:
> > I saved all proc files before and after a suspend/resume cycle and look
> > at the diff:
> > 
> > In /proc/asound/card0/intel8x0 
> > I have the following diff:
> > before: Global control : 0xc0000002
> > after: Global control : 0x00000002
> 
> I think that the real problem is here as the intel datasheet says for
> the bits 31:30 :
> 
>    "S/PDIF Slot Map (SSM) -- R/W. If the run/pause bus master bit
>    (bit 0 of offset 2Bh) is set, then the value in these bits indicate
>    which slots S/PDIF data is transmitted on.  Software must ensure 
>    that the programming here does not conflict with the PCM channels 
>    being used.  If there is a conflict, unpredictable behavior will 
>    result - the hardware will not check for a conflict.
>       00 = Reserved
>       01 = Slots 7 and 8
>       10 = Slots 6 and 9
>       11 = Slots 10 and 11"
> 
> And after a suspend/resume cycle, I have 11 which does not make sense
> since I don't have a S/PDIF output.
> 
> Is there an easy way to set this bits to 00?

Obviously I confused myself, the bits should be 11 and after the
suspend/resume cycle are 00 which is not good.

Christophe
 
-- 
Christophe Barbe <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
