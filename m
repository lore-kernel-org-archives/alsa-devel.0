From: Darwin Marcus Johnson <schwaahed@yahoo.com>
Subject: Re: Fwd: Midiator MS-124w w/ALSA0.9.0beta12
Date: Mon, 4 Mar 2002 09:06:25 -0500
Message-ID: <200203040906.25404.schwaahed@yahoo.com>
References: <Pine.LNX.4.33.0203041445490.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Pine.LNX.4.33.0203041445490.487-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "linux-audio-dev@music.columbia.edu" <linux-audio-dev@music.columbia.edu>
List-Id: alsa-devel@alsa-project.org

That did it thanks!

On Monday 04 March 2002 08:46 am, Jaroslav Kysela wrote:
> On Mon, 4 Mar 2002, Darwin Marcus Johnson wrote:
> > Hi All,
> >
> > I am trying to get my Midiator Midi interface working with ALSA0.9.0b=
eta
> > 12. I am trying to insert the snd-serial-u16550 module. My
> > /etc/modules.conf seems to have the right options for this card.
>
> You must turn the default Linux serial driver off before trying the ALS=
A
> driver:
>
> setserial /dev/ttyS0 uart none
>
> =09=09=09=09=09=09Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
