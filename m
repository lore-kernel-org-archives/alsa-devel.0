From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Volume per voices [Feature Request]
Date: Wed, 27 Jul 2005 10:17:51 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507271011440.16586-100000@studcom.urz.uni-halle.de>
References: <XFMail.20050727094742.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20050727094742.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Dino Puller <dino@e4a.it>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
> On 26-Jul-2005 Dino Puller wrote:
> > It's should be very useful to have a standard way/function to map volume
> > per PCM stream. For now seems that only emu10k1 and via82xxx has a
> > volume control for each PCM streams, probably because a lack on the
> > others drivers. Where the HW/driver doesn't support this control, it's
> > should be emulated via software.
>
> Most cards have hw volume, but ALSA cannot answer this simple question:
> given this PCM handle, what numid:index control controls the gain of its
> Nth channel ?

But it would be very easy for the driver to answer this question, and
to extend ALSA accordingly.

> That question is not as simple as it may seem at first glance. The ctl
> may not exist at all if the cards do not support it

The ALSA library could add a software volume plugin in this case.

> or if the PCM is not an hardware PCM (eg. is uses dmix). Even if
> the card has a simple 1:1 relation between a PCM device and an hw
> control, some plugins (route, multi or any combination of any
> plugins) may have shuffled things...

These plugins would pass through the information from the slave
plugin, if appropriate.  If not, we have the same case as when there
is no hardware control.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
