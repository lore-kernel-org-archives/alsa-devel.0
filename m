From: David Balazic <robinud@volja.net>
Subject: Re: Change default sound card ?
Date: Tue,  8 Mar 2005 15:00:05 +0100
Message-ID: <1110290405.422dafe5d01a6@webmail.volja.net>
References: <Pine.HPX.4.33n.0503081443540.835-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Pine.HPX.4.33n.0503081443540.835-100000@studcom.urz.uni-halle.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Navajanje Clemens Ladisch <clemens@ladisch.de>:

> robinud@volja.net wrote:
> > Recently I tried to change my default sound card (I have two) and it =
seems
> > more complicated than needed.
> >
> If you just want to swap your cards, use different "index" options in
> your modprobe.conf/modules.conf, e.g.:
>
> options snd-emu10k1 index=3D0
> options snd-intel8x0 index=3D1
>
> This has the benefit of changing the card numbers for OSS emulation,
> too.

Yes,  but I need something I can put into a users .asoundrc.
(different for different uses)

----------------------------------------------------------------
Varno. Enostavno. Vredno. Internet dodatne storitve.
http://www.voljatel.si/storitve/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
