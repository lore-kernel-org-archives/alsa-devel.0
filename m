From: Dino <dino@e4a.it>
Subject: RE: Volume per voices [Feature Request]
Date: Wed, 27 Jul 2005 10:34:07 +0200
Message-ID: <1122453247.42e746ffbc446@mail.e4a.it>
References: <XFMail.20050727094742.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Scrive Giuliano Pochini <pochini@shiny.it>:

>
> On 26-Jul-2005 Dino Puller wrote:
> > Hi all,
> >     i don't know if this is the right place to ask for a new feature,
> > BTW here it is:
> > It's should be very useful to have a standard way/function to map vol=
ume
> > per PCM stream. For now seems that only emu10k1 and via82xxx has a
> > volume control for each PCM streams, probably because a lack on the
> > others drivers. Where the HW/driver doesn't support this control, it'=
s
> > should be emulated via software.
>
> Most cards have hw volume, but ALSA cannot answer this simple question:
> given this PCM handle, what numid:index control controls the gain of it=
s
> Nth channel ?
This is exactly what i'd like. I'd like to skip this access to a control =
gain,
and instead create a standard map to the relative pcm stream.

> That question is not as simple as it may seem at first glance. The ctl
> may not exist at all if the cards do not support it or if the PCM is
> not an hardware PCM (eg. is uses dmix). Even if the card has a simple
> 1:1 relation between a PCM device and an hw control, some plugins (rout=
e,
> multi or any combination of any plugins) may have shuffled things...
Hmm i know nothing about route and others plugins, but we can use this vo=
lume
control only if it's direct and use an emulation otherwise, it's a simple
access to a lookup table and two multipications. This emulation should be=
 done
even if our hardware doesn't support this gain. At this purpouse i'm look=
ing at
the code of cs46xx driver witch play with my soundcard, and i'm trying to=
 add
this controls and its seems to work (a bit buggy but i've just started) b=
tw
it's really simple to do.
Anyway it's strange that alsa doesn't support this feature, because the o=
ld GUS
classic supports volume per pcm, volume ramp, and looping! And alsa was b=
orn
from it's drivers.

regards,
   Dino

>
>
> --
> Giuliano.
>




----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
