From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Volume per voices [Feature Request]
Date: Wed, 27 Jul 2005 09:47:42 +0200 (CEST)
Message-ID: <XFMail.20050727094742.pochini@shiny.it>
References: <42E60732.4090808@e4a.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42E60732.4090808@e4a.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dino Puller <dino@e4a.it>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 26-Jul-2005 Dino Puller wrote:
> Hi all,
>     i don't know if this is the right place to ask for a new feature,
> BTW here it is:
> It's should be very useful to have a standard way/function to map volum=
e
> per PCM stream. For now seems that only emu10k1 and via82xxx has a
> volume control for each PCM streams, probably because a lack on the
> others drivers. Where the HW/driver doesn't support this control, it's
> should be emulated via software.

Most cards have hw volume, but ALSA cannot answer this simple question:
given this PCM handle, what numid:index control controls the gain of its
Nth channel ?
That question is not as simple as it may seem at first glance. The ctl
may not exist at all if the cards do not support it or if the PCM is
not an hardware PCM (eg. is uses dmix). Even if the card has a simple
1:1 relation between a PCM device and an hw control, some plugins (route,
multi or any combination of any plugins) may have shuffled things...


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
