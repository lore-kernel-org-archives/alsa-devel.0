From: Laurielle LEA <lauriellelea@yahoo.fr>
Subject: Re: Overrun buffer
Date: Sat, 2 Apr 2005 04:22:04 +0200 (CEST)
Message-ID: <20050402022204.36393.qmail@web25103.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-961091484-1112408524=:16552"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: 6667
Sender: alsa-devel-admin@lists.sourceforge.net
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

--0-961091484-1112408524=:16552
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code is in attached file.

Thanks.



--- Lee Revell <rlrevell@joe-job.com> wrote:
> On Sat, 2005-04-02 at 00:43 +0200, Laurielle LEA
> wrote:
> > Hi,=20
> >=20
> > I have now a problem of overrun buffer during
> capture.
> > But it's not occured all the time. Sometimes i
> have
> > -EPIPE for snd_pcm_readi
> > I tried to use  snd_pcm_prepare(), snd_pcm_drop()
> or
> > snd_pcm_drain() calls but I have still -EPIPE.
> >=20
> > Do you know how can I solve this ?
>=20
> Please post the problematic code to this mailing
> list (don't mail it to
> me privately).
>=20
> Lee
>=20
>=20


=09

=09
	=09
__________________________________________________________________
D=E9couvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos=
 mails !=20
Cr=E9ez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
--0-961091484-1112408524=:16552
Content-Type: application/octet-stream; name="alsa.cpp"
Content-Transfer-Encoding: base64
Content-Description: alsa.cpp
Content-Disposition: attachment; filename="alsa.cpp"

aW50CkF1ZGlvRHJpdmVyc0FMU0E6OnJlYWRCdWZmZXIgKHZvaWQgKnB0ciwg
aW50IGJ5dGVzKSB7CiAgICBpZiggZGV2c3RhdGUgIT0gRGV2aWNlT3BlbmVk
ICkgewogICAgICAgIHByaW50ZiAoIkFMU0E6IHJlYWRCdWZmZXIoKTogRGV2
aWNlIE5vdCBPcGVuXG4iKTsKICAgICAgICByZXR1cm4gLTE7CiAgICB9CiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICBzc2l6ZV90
IGNvdW50ID0gYnl0ZXM7CiAgICBzc2l6ZV90IHJjOwogICAgZG8gewogICAg
ICAgIHJjID0gc25kX3BjbV9yZWFkaShhdWRpb19oZGwsIChzaG9ydCopcHRy
LCBjb3VudCk7CiAgICB9IHdoaWxlIChyYyA9PSAtRUFHQUlOKTsKICAgIGlm
IChyYyA9PSAtRVBJUEUpIHsKICAgICAgICAgICAgcHJpbnRmICgiQUxTQTog
cmVhZCBFUElQRSA9ICVkXG4iLHJjKTsKICAgICAgICAgICAgc25kX3BjbV9w
cmVwYXJlKGF1ZGlvX2hkbCk7CiAgICB9CiAgICBpZiAocmMgPiAwICYmIHJj
ICE9IGNvdW50KSB7CiAgICAgICAgcHJpbnRmKCJSZWFkOiB3YXJuaW5nOiBh
c2tlZCBtaWNyb3Bob25lIGZvciAlZCBmcmFtZXMgYnV0IGdvdCAlZFxuIiwK
ICAgICAgICAgICAgY291bnQsIHJjKTsKICAgIH0KICAgIHJldHVybiByYzsK
fQoK

--0-961091484-1112408524=:16552--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
