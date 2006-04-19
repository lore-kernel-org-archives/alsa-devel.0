From: Juan Zapatero <jazc@gmvsistemas.es>
Subject: Re: Use a plughw device inside the dmix plugin.
Date: Wed, 19 Apr 2006 13:51:13 +0200
Message-ID: <1145447473.10487.8.camel@jazc.fedora>
References: <1145443998.8025.4.camel@jazc.fedora>
	 <s5hhd4pu813.wl%tiwai@suse.de> <1145445860.9402.1.camel@jazc.fedora>
	 <s5hd5fdu7dp.wl%tiwai@suse.de> <1145446753.10487.1.camel@jazc.fedora>
	 <s5h8xq1u6so.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xq1u6so.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok as the VoIP is intendeed to work over GPRS links, it uses as=0A=
configuration:=0A=
=0A=
Capture:=0A=
	-16bitLE=0A=
	-8000Hz=0A=
	-1 channel=0A=
=0A=
Playback:although the stream is of the same type as the one captured and=0A=
sent, in playback, it's needed for other reasons to process it into a=0A=
one channel stereo(meaning it is a stereo stream with audio only in one=0A=
of the channels), so the configuration is:=0A=
	-16bitLE=0A=
	-8000Hz=0A=
	-2 channels=20=0A=
=0A=
El mi=C3=A9, 19-04-2006 a las 13:46 +0200, Takashi Iwai escribi=C3=B3:=0A=
> At Wed, 19 Apr 2006 13:39:13 +0200,=0A=
> Juan Zapatero wrote:=0A=
> >=20=0A=
> > No I don't know why 1 channel configuration is only available through=
=0A=
> > plughw,=0A=
>=20=0A=
> That's what I don't understand.  What configuration did you try?=0A=
>=20=0A=
> > but it is, so I want to know if there is a way to force the dmix=0A=
> > plugin to work over plughw insted of hw:0,0 as actually it does.=0A=
>=20=0A=
> No way.  Use plug _over_ dmix instead of _under_ dmix.=0A=
>=20=0A=
>=20=0A=
> Takashi=0A=
>=20=0A=
>=20=0A=
> > El mi=C3=A9, 19-04-2006 a las 13:33 +0200, Takashi Iwai escribi=C3=B3:=
=0A=
> > > At Wed, 19 Apr 2006 13:24:20 +0200,=0A=
> > > Juan Zapatero wrote:=0A=
> > > >=20=0A=
> > > > By doing so, I would not be able to use dmixing...=0A=
> > > > The problem is that capture must be configured in 1 channel, and=0A=
> > > > playback in two, but, 1 channel setup can only be made through plug=
hw.=0A=
> > >=20=0A=
> > > Then I don't understand your requirment at all...=0A=
> > >=20=0A=
> > > You just want to wrap plug over dmix for channel shrink/expansion?=0A=
> > >=20=0A=
> > >=20=0A=
> > > Takashi=0A=
> > >=20=0A=
> > > > El mi=C3=A9, 19-04-2006 a las 13:19 +0200, Takashi Iwai escribi=C3=
=B3:=0A=
> > > > > At Wed, 19 Apr 2006 12:53:18 +0200,=0A=
> > > > > Juan Zapatero wrote:=0A=
> > > > > >=20=0A=
> > > > > > I am using a VoIP application which uses different devices for =
capturing=0A=
> > > > > > and playback, because some audio processing is needed between a=
udio=0A=
> > > > > > reception and playback. I have configured my default to use dmi=
x plugin,=0A=
> > > > > > because it is required to be able to play different audio strea=
ms at=0A=
> > > > > > once. I can force the capture device to use 'default' plugin, b=
ut the=0A=
> > > > > > playback device only works under plughw. So, is there a way to =
use a=0A=
> > > > > > plughw device inside the dmix plugin?=0A=
> > > > >=20=0A=
> > > > > You can override the definition of plughw, such as=0A=
> > > > >=20=0A=
> > > > > 	pcm.!plughw "default"=0A=
> > > > >=20=0A=
> > > > > But, fixing the app would be a better option, of course.=0A=
> > > > >=20=0A=
> > > > >=20=0A=
> > > > > Takashi=0A=
> > > >=20=0A=
> > > >=20=0A=
> > > > ______________________=0A=
> > > > Este mensaje, y en su caso, cualquier fichero anexo al mismo,=0A=
> > > >  puede contener informacion clasificada por su emisor como confiden=
cial=0A=
> > > >  en el marco de su Sistema de Gestion de Seguridad de la=20=0A=
> > > > Informacion siendo para uso exclusivo del destinatario, quedando=20=
=0A=
> > > > prohibida su divulgacion copia o distribucion a terceros sin la=20=
=0A=
> > > > autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=
=20=0A=
> > > >  erroneamente, se ruega lo notifique al remitente y proceda a su bo=
rrado.=20=0A=
> > > > Gracias por su colaboracion.=0A=
> > > > ______________________=0A=
> > > > This message including any attachments may contain confidential=20=
=0A=
> > > > information, according to our Information Security Management Syste=
m,=0A=
> > > >  and intended solely for a specific individual to whom they are add=
ressed.=0A=
> > > >  Any unauthorised copy, disclosure or distribution of this message=
=0A=
> > > >  is strictly forbidden. If you have received this transmission in e=
rror,=0A=
> > > >  please notify the sender immediately and delete it.=0A=
> > > > ______________________=0A=
> > > >=20=0A=
> > > >=20=0A=
> > > > -------------------------------------------------------=0A=
> > > > This SF.Net email is sponsored by xPML, a groundbreaking scripting =
language=0A=
> > > > that extends applications into web and mobile media. Attend the liv=
e webcast=0A=
> > > > and join the prime developer group breaking into this new coding te=
rritory!=0A=
> > > > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=110944&bid$1720&dat=
=121642=0A=
> > > > _______________________________________________=0A=
> > > > Alsa-devel mailing list=0A=
> > > > Alsa-devel@lists.sourceforge.net=0A=
> > > > https://lists.sourceforge.net/lists/listinfo/alsa-devel=0A=
> > > >=20=0A=
> > >=20=0A=
> >=20=0A=
> >=20=0A=
> > ______________________=0A=
> > Este mensaje, y en su caso, cualquier fichero anexo al mismo,=0A=
> >  puede contener informacion clasificada por su emisor como confidencial=
=0A=
> >  en el marco de su Sistema de Gestion de Seguridad de la=20=0A=
> > Informacion siendo para uso exclusivo del destinatario, quedando=20=0A=
> > prohibida su divulgacion copia o distribucion a terceros sin la=20=0A=
> > autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=20=
=0A=
> >  erroneamente, se ruega lo notifique al remitente y proceda a su borrad=
o.=20=0A=
> > Gracias por su colaboracion.=0A=
> > ______________________=0A=
> > This message including any attachments may contain confidential=20=0A=
> > information, according to our Information Security Management System,=
=0A=
> >  and intended solely for a specific individual to whom they are address=
ed.=0A=
> >  Any unauthorised copy, disclosure or distribution of this message=0A=
> >  is strictly forbidden. If you have received this transmission in error,=
=0A=
> >  please notify the sender immediately and delete it.=0A=
> > ______________________=0A=
> >=20=0A=
> >=20=0A=
> > -------------------------------------------------------=0A=
> > This SF.Net email is sponsored by xPML, a groundbreaking scripting lang=
uage=0A=
> > that extends applications into web and mobile media. Attend the live we=
bcast=0A=
> > and join the prime developer group breaking into this new coding territ=
ory!=0A=
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=110944&bid$1720&dat=121642=
=0A=
> > _______________________________________________=0A=
> > Alsa-devel mailing list=0A=
> > Alsa-devel@lists.sourceforge.net=0A=
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel=0A=
> >=20=0A=
>=20=0A=
=0A=
=0A=
______________________=0A=
Este mensaje, y en su caso, cualquier fichero anexo al mismo,=0A=
 puede contener informacion clasificada por su emisor como confidencial=0A=
 en el marco de su Sistema de Gestion de Seguridad de la=20=0A=
Informacion siendo para uso exclusivo del destinatario, quedando=20=0A=
prohibida su divulgacion copia o distribucion a terceros sin la=20=0A=
autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=20=0A=
 erroneamente, se ruega lo notifique al remitente y proceda a su borrado.=
=20=0A=
Gracias por su colaboracion.=0A=
______________________=0A=
This message including any attachments may contain confidential=20=0A=
information, according to our Information Security Management System,=0A=
 and intended solely for a specific individual to whom they are addressed.=
=0A=
 Any unauthorised copy, disclosure or distribution of this message=0A=
 is strictly forbidden. If you have received this transmission in error,=0A=
 please notify the sender immediately and delete it.=0A=
______________________=0A=


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
