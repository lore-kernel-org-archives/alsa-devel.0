From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Volume per voices [Feature Request]
Date: Wed, 27 Jul 2005 10:23:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507271020110.8129@tm8103.perex-int.cz>
References: <Pine.HPX.4.33n.0507271011440.16586-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507271011440.16586-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Giuliano Pochini <pochini@shiny.it>, Dino Puller <dino@e4a.it>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Jul 2005, Clemens Ladisch wrote:

> Giuliano Pochini wrote:
> > On 26-Jul-2005 Dino Puller wrote:
> > > It's should be very useful to have a standard way/function to map volume
> > > per PCM stream. For now seems that only emu10k1 and via82xxx has a
> > > volume control for each PCM streams, probably because a lack on the
> > > others drivers. Where the HW/driver doesn't support this control, it's
> > > should be emulated via software.
> >
> > Most cards have hw volume, but ALSA cannot answer this simple question:
> > given this PCM handle, what numid:index control controls the gain of its
> > Nth channel ?
> 
> But it would be very easy for the driver to answer this question, and
> to extend ALSA accordingly.

It's not necessary. The alsa-lib can do it, but having consistent control 
names in driver is not a bad idea, too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
