From: Gustavo Guillermo <gustavo@compunauta.com>
Subject: Re: [REPORT as said in via82xx.c] ad1980 Asus A7V8
Date: Wed, 14 Jan 2004 01:43:19 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040114.1431900.3548811780@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO_8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Yes, is much better quality with automatic option, arts is ok, just only=

the surround control is Master Volume, then no one mixer including
alsamixer can change the volume with master one.
And of course alsamixer is the almost only one that avoid to change
surround state (Master control volume).


GusGus

>>>>>>>>>>>>>>>>>> Mensaje original <<<<<<<<<<<<<<<<<<

El 12/01/04, 20:06:51, Takashi Iwai <tiwai@suse.de> escribi=F3 sobre el =
tema
Re: [Alsa-devel] [REPORT as said in via82xx.c] ad1980 Asus A7V8:


> At Mon, 12 Jan 2004 06:12:04 GMT,
> Gustavo Guillermo wrote:
> >
> > I'm use via82xx module for ad1980 Asus A7V8X-X with option dxs_suppo=
rt=3D1
> > and weird sounds gets out, master channel volume seems to be Surroun=
d,
> > and VIA DXS (first one) needs to be at 75% to hear full volume, othe=
r
> > positions doesn't work.

> with the recent version, A7V8X-X should be autoamtically set to
> dxs_support=3D4.  this option worked better for the board of testers a=
t
> that time.  please check the pci subsystem id whether it's 1043:80a1.

> >
> > PCM sound from whatever is a little bit weird because conversion to =
48k,
> > but just fine, if we use arts, we can set sampling to 48k and everyt=
hing
> > is perfect.

> arts has (had) a different problem.  this should have been fixed.
> anyway, try the latest version if you didn't try it.


> Takashi


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
