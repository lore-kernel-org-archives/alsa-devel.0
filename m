From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: Re: Raise and lower volume through Alsa Api
Date: Fri, 26 May 2006 10:36:25 +0200
Message-ID: <4476BE09.6080903@purplelabs.com>
References: <1147429541.26309.3.camel@jazc.fedora>	<s5hpsijzbof.wl%tiwai@suse.de>
	<1147676786.2963.1.camel@jazc.fedora>	<1147812562.13948.144.camel@mindpipe>	<m2psicldv8.fsf@vador2.mandriva.com>	<1147892684.2473.0.camel@mindpipe>	<1148631774.4785.2.camel@jazc.fedora>	<4476BB92.3070203@purplelabs.com>
	<1148632283.4785.4.camel@jazc.fedora>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0676276828=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1148632283.4785.4.camel@jazc.fedora>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Juan Zapatero <jazc@gmvsistemas.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0676276828==
Content-Type: multipart/alternative;
	boundary="------------000104020308050707000705"

This is a multi-part message in MIME format.
--------------000104020308050707000705
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

AFAIK, there's no way to do this... but i don't know ALSA that much to
be sure of it...
but you can easily manage such a soft volume before sending samples to AL=
SA.

-- Ben

Juan Zapatero wrote:

>But what about doing it through API, so that volume is set in the
>application, without using any volume plugin...
>
>El vie, 26-05-2006 a las 10:25 +0200, Benoit Fouet escribi=C3=B3:
> =20
>
>>you have the softvolume plugin i think.
>>
>>-- Ben
>>
>>Juan Zapatero wrote:
>>
>>   =20
>>
>>>Is there any way of modifying stream's volume through libasound API?
>>>I mean, raising or lowering a streams volume before sending it to
>>>soundcard with write(...)
>>>
>>>
>>>
>>>
>>>______________________
>>>Este mensaje, y en su caso, cualquier fichero anexo al mismo,
>>>puede contener informacion clasificada por su emisor como confidencial
>>>en el marco de su Sistema de Gestion de Seguridad de la=20
>>>Informacion siendo para uso exclusivo del destinatario, quedando=20
>>>prohibida su divulgacion copia o distribucion a terceros sin la=20
>>>autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=20
>>>erroneamente, se ruega lo notifique al remitente y proceda a su borrad=
o.=20
>>>Gracias por su colaboracion.
>>>______________________
>>>This message including any attachments may contain confidential=20
>>>information, according to our Information Security Management System,
>>>and intended solely for a specific individual to whom they are address=
ed.
>>>Any unauthorised copy, disclosure or distribution of this message
>>>is strictly forbidden. If you have received this transmission in error=
,
>>>please notify the sender immediately and delete it.
>>>______________________
>>>
>>>
>>>_______________________________________________
>>>Alsa-devel mailing list
>>>Alsa-devel@lists.sourceforge.net
>>>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>>=20
>>>
>>>     =20
>>>
>
>
>______________________
>Este mensaje, y en su caso, cualquier fichero anexo al mismo,
> puede contener informacion clasificada por su emisor como confidencial
> en el marco de su Sistema de Gestion de Seguridad de la=20
>Informacion siendo para uso exclusivo del destinatario, quedando=20
>prohibida su divulgacion copia o distribucion a terceros sin la=20
>autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=20
> erroneamente, se ruega lo notifique al remitente y proceda a su borrado=
.=20
>Gracias por su colaboracion.
>______________________
>This message including any attachments may contain confidential=20
>information, according to our Information Security Management System,
> and intended solely for a specific individual to whom they are addresse=
d.
> Any unauthorised copy, disclosure or distribution of this message
> is strictly forbidden. If you have received this transmission in error,
> please notify the sender immediately and delete it.
>______________________
>
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
> =20
>

--------------000104020308050707000705
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
AFAIK, there's no way to do this... but i don't know ALSA that much to
be sure of it...<br>
but you can easily manage such a soft volume before sending samples to
ALSA.<br>
<br>
-- Ben<br>
<br>
Juan Zapatero wrote:
<blockquote cite=3D"mid1148632283.4785.4.camel@jazc.fedora" type=3D"cite"=
>
  <pre wrap=3D"">But what about doing it through API, so that volume is s=
et in the
application, without using any volume plugin...

El vie, 26-05-2006 a las 10:25 +0200, Benoit Fouet escribi=C3=B3:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">you have the softvolume plugin i think.

-- Ben

Juan Zapatero wrote:

    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">Is there any way of modifying stream's volume throug=
h libasound API?
I mean, raising or lowering a streams volume before sending it to
soundcard with write(...)




______________________
Este mensaje, y en su caso, cualquier fichero anexo al mismo,
puede contener informacion clasificada por su emisor como confidencial
en el marco de su Sistema de Gestion de Seguridad de la=20
Informacion siendo para uso exclusivo del destinatario, quedando=20
prohibida su divulgacion copia o distribucion a terceros sin la=20
autorizacion expresa del remitente. Si Vd. ha recibido este mensaje=20
erroneamente, se ruega lo notifique al remitente y proceda a su borrado.=20
Gracias por su colaboracion.
______________________
This message including any attachments may contain confidential=20
information, according to our Information Security Management System,
and intended solely for a specific individual to whom they are addressed.
Any unauthorised copy, disclosure or distribution of this message
is strictly forbidden. If you have received this transmission in error,
please notify the sender immediately and delete it.
______________________


_______________________________________________
Alsa-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Alsa-devel@lists.sou=
rceforge.net">Alsa-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/=
lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/a=
lsa-devel</a>
=20

      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=3D""><!---->

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
 and intended solely for a specific individual to whom they are addressed=
.
 Any unauthorised copy, disclosure or distribution of this message
 is strictly forbidden. If you have received this transmission in error,
 please notify the sender immediately and delete it.
______________________


_______________________________________________
Alsa-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Alsa-devel@lists.sou=
rceforge.net">Alsa-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/=
lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/a=
lsa-devel</a>
  </pre>
</blockquote>
</body>
</html>

--------------000104020308050707000705--


--===============0676276828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0676276828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0676276828==--
