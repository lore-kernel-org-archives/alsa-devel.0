From: Juan Zapatero <jazc@gmvsistemas.es>
Subject: Re: Mix audio at different frequencies
Date: Mon, 15 May 2006 09:06:26 +0200
Message-ID: <1147676786.2963.1.camel@jazc.fedora>
References: <1147429541.26309.3.camel@jazc.fedora>
	 <s5hpsijzbof.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsijzbof.wl%tiwai@suse.de>
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

What do you mean? Here is my .asoundrc, what has to be changed?=0A=
=0A=
# this makes native ALSA apps default to using dmix=0A=
pcm.!default {=0A=
  type plug=0A=
  slave.pcm "duplex"=0A=
}=0A=
=0A=
ctl.!default {=0A=
  type hw=0A=
  card 0=0A=
}=0A=
=0A=
pcm.duplex{=0A=
   type asym=0A=
   playback.pcm "dmix0"=0A=
   capture.pcm "plughw:0,0"=0A=
}=0A=
=0A=
pcm.dmix0 {=0A=
    type dmix=0A=
    ipc_key 219345           # any unique number here=0A=
    slave {=0A=
            pcm "hw:0,0"=0A=
            period_time 0=0A=
            #buffer_time 0=0A=
            period_size 2048    # jm: much smoother than 1024/8192!=0A=
            buffer_size 32768=0A=
            rate 44100=0A=
    }=20=20=20=20=0A=
    bindings {=0A=
        0 0   # from 0 =3D> to 0=0A=
        1 1   # from 1 =3D> to 1=0A=
    }=0A=
}=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
El vie, 12-05-2006 a las 14:10 +0200, Takashi Iwai escribi=C3=B3:=0A=
> At Fri, 12 May 2006 12:25:41 +0200,=0A=
> Juan Zapatero wrote:=0A=
> >=20=0A=
> > Hello,=0A=
> > I need to mix in playback two different audio streams, one coming from=
=0A=
> > an ogg player, which is at 44100Hz, and the other one, coming out of a=
=0A=
> > VoIP application, in this case, at 8000Hz. As I am using the dmix plugin=
=0A=
> > for mixing, I can't find out how to implement the resampling operations=
=0A=
> > needed.=0A=
>=20=0A=
> Use plug or rate plugin.  The default setting does it automatically,=0A=
> too.=0A=
>=20=0A=
> Note that the rate plugin in 1.0.11 release has some bugs that was=0A=
> already fixed on HG repo.=0A=
>=20=0A=
>=20=0A=
> Takashi=0A=
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
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
