From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd-hdsp unresolved symbol and an alsa build error
Date: Mon, 14 Apr 2003 10:39:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304141038340.1255-100000@pnote.perex-int.cz>
References: <200304120118.45101.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304120118.45101.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?= <Jaakko.Prattala@Helsinki.FI>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Apr 2003, Jaakko [iso-8859-15] Pr=E4tt=E4l=E4 wrote:

> kernel 2.4.20, pcmcia support as module, alsa cvs from friday evening
> ./configure --with-cards=3Dvirmidi,hdsp,usb-audio,via82xx --with-sequence=
r=3Dyes
> --with-isapnp=3Dno
>=20
> /sbin/modprobe snd-hdsp
> /lib/modules/2.4.20/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved symbo=
l=20
> snd_hwdep_new_R42732707
>=20
> This build error comes everytime I leave out --with-isapnp=3Dno :
>=20
> pnp.c:130: redefinition of `pnp_request_card_device_Rfcc1b9a4'
> pnp.h:203: `pnp_request_card_device_Rfcc1b9a4' previously defined here

You have somewhat broken your CVS tree. Check, if CONFIG_PNP is defined in
the alsa-driver/include/config.h file.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
