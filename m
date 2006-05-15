From: "Juan Antonio Zapatero Campo" <jazc@gmvsistemas.es>
Subject: Re: Mix audio at different frequencies
Date: Mon, 15 May 2006 13:25:39 +0200
Message-ID: <000601c67812$4b80e240$8ca8a8c0@gmvsistemas.es>
References: <1147429541.26309.3.camel@jazc.fedora><s5hpsijzbof.wl%tiwai@suse.de><1147676786.2963.1.camel@jazc.fedora> <s5h4pzrwqp0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

No, it returns wrong buffer sizes. Instead of 160 samples, which is what =
I=20
am expecting at 8000Hz, it returns a value of 341, which I do not=20
understand.

----- Original Message -----=20
From: "Takashi Iwai" <tiwai@suse.de>
To: "Juan Zapatero" <jazc@gmvsistemas.es>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Monday, May 15, 2006 12:03 PM
Subject: Re: [Alsa-devel] Mix audio at different frequencies


> At Mon, 15 May 2006 09:06:26 +0200,
> Juan Zapatero wrote:
>>
>> What do you mean? Here is my .asoundrc, what has to be changed?
>
> It looks OK.  And doesn't it work with your voip program?
>
>
> Takashi
>
>>
>> # this makes native ALSA apps default to using dmix
>> pcm.!default {
>>   type plug
>>   slave.pcm "duplex"
>> }
>>
>> ctl.!default {
>>   type hw
>>   card 0
>> }
>>
>> pcm.duplex{
>>    type asym
>>    playback.pcm "dmix0"
>>    capture.pcm "plughw:0,0"
>> }
>>
>> pcm.dmix0 {
>>     type dmix
>>     ipc_key 219345           # any unique number here
>>     slave {
>>             pcm "hw:0,0"
>>             period_time 0
>>             #buffer_time 0
>>             period_size 2048    # jm: much smoother than 1024/8192!
>>             buffer_size 32768
>>             rate 44100
>>     }
>>     bindings {
>>         0 0   # from 0 =3D> to 0
>>         1 1   # from 1 =3D> to 1
>>     }
>> }
>>
>>
>>
>>
>>
>> El vie, 12-05-2006 a las 14:10 +0200, Takashi Iwai escribi=F3:
>> > At Fri, 12 May 2006 12:25:41 +0200,
>> > Juan Zapatero wrote:
>> > >
>> > > Hello,
>> > > I need to mix in playback two different audio streams, one coming=20
>> > > from
>> > > an ogg player, which is at 44100Hz, and the other one, coming out =
of=20
>> > > a
>> > > VoIP application, in this case, at 8000Hz. As I am using the dmix=20
>> > > plugin
>> > > for mixing, I can't find out how to implement the resampling=20
>> > > operations
>> > > needed.
>> >
>> > Use plug or rate plugin.  The default setting does it automatically,
>> > too.
>> >
>> > Note that the rate plugin in 1.0.11 release has some bugs that was
>> > already fixed on HG repo.
>> >
>> >
>> > Takashi
>>
>>
>> ______________________
>> Este mensaje, y en su caso, cualquier fichero anexo al mismo,
>>  puede contener informacion clasificada por su emisor como confidencia=
l
>>  en el marco de su Sistema de Gestion de Seguridad de la
>> Informacion siendo para uso exclusivo del destinatario, quedando
>> prohibida su divulgacion copia o distribucion a terceros sin la
>> autorizacion expresa del remitente. Si Vd. ha recibido este mensaje
>>  erroneamente, se ruega lo notifique al remitente y proceda a su borra=
do.
>> Gracias por su colaboracion.
>> ______________________
>> This message including any attachments may contain confidential
>> information, according to our Information Security Management System,
>>  and intended solely for a specific individual to whom they are=20
>> addressed.
>>  Any unauthorised copy, disclosure or distribution of this message
>>  is strictly forbidden. If you have received this transmission in erro=
r,
>>  please notify the sender immediately and delete it.
>> ______________________
>>
>=20


______________________
Este mensaje, y en su caso, cualquier fichero anexo al mismo,
 puede contener informacion clasificada por su emisor como confidencial
 en el marco de su Sistema de Gestion de Seguridad de la=20
Informacion siendo para uso exclusivo del destinatario, quedando=20
prohibida su divulgacion copia o distribucion a terceros sin la=20
autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=20
 erroneamente, se ruega lo notifique al remitente y proceda a su borrado.=
=20
Gracias por su colaboracion.
______________________
This message including any attachments may contain confidential=20
information, according to our Information Security Management System,
 and intended solely for a specific individual to whom they are addressed.
 Any unauthorised copy, disclosure or distribution of this message
 is strictly forbidden. If you have received this transmission in error,
 please notify the sender immediately and delete it.
______________________


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
