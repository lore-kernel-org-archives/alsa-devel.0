From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: usx2y jack driver: missing usx2yhwdeppcm.h
Date: Fri, 24 Sep 2004 18:23:21 +0200
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <200409241823.21575.annabellesgarden@yahoo.de>
References: <200409222228.38243.annabellesgarden@yahoo.de> <39820.195.245.190.94.1096039705.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <39820.195.245.190.94.1096039705.squirrel@195.245.190.94>
Content-Disposition: inline
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Freitag 24 September 2004 17:28 schrieb Rui Nuno Capela:
> Hi Karsten,
>
> > The tar.bz2 file is made of 4 parts:
> >
> > Apply snd-usb-usx2y.patch.0.7.3+hwdep_pcm to alsa-kernel/usb,
> > snd-usb-usx2y.patch.0.7.3+hwdep_pcm_asound.h to
> > alsa-kernel/include/asound.h.
> >
> > Apply jack_usx2y_driver.patch to jack and cp usx2y to jack/drivers.
> >
> > To build Jack, you'll have to call autogen.sh and then configure.
> > The tweaked snd-usb-usx2y will propably only build in linux-kernel. I
> > tried nothing else.
>
> I got the snd-usb-usx2y kernel module part done OK.
>
> The jack usx2y driver part is missing the "usx2yhwdeppcm.h" header file.
> Apparently it was included in the tarball as a symlink to some local file
> of yours. Can't build jack without it.
>
> Would you please send it to us?

you propably already have it: its exactly the same as in 
alsa-kernel/usb/usx2y. make the symlink point to where 
alsa-kernel/usb/usx2y/usx2yhwdeppcm.h is on your system.

best,
karsten


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
