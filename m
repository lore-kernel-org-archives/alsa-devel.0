From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Change default sound card ?
Date: Tue, 8 Mar 2005 15:20:31 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503081519160.835-100000@studcom.urz.uni-halle.de>
References: <1110290405.422dafe5d01a6@webmail.volja.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110290405.422dafe5d01a6@webmail.volja.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Balazic <robinud@volja.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Balazic wrote:

> Navajanje Clemens Ladisch <clemens@ladisch.de>:
>
> > If you just want to swap your cards, use different "index" options in
> > your modprobe.conf/modules.conf, e.g.:
> >
> > options snd-emu10k1 index=0
> > options snd-intel8x0 index=1
>
> Yes,  but I need something I can put into a users .asoundrc.
> (different for different uses)

Then you have to change default.pcm.card and defaults.ctl.card.

If you want to use an environment variable, use ALSA_CARD.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
