From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: How to get set/fixed sample rate of ALSA device?
Date: Mon, 08 Oct 2007 01:52:26 +0200
Message-ID: <4709713A.8000404@keyaccess.nl>
References: <b97f4ee40710061456l5aa0764alce22c505401c7e6f@mail.gmail.com>	<b97f4ee40710071004o23ea40a1w8c8f754b47083b95@mail.gmail.com>	<470958A9.7040607@keyaccess.nl>
	<200710080841.37709.markc@renta.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030605090705070407050505"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <200710080841.37709.markc@renta.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Mark Constable <markc@renta.net>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030605090705070407050505
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/08/2007 12:41 AM, Mark Constable wrote:

> Any chance that your program could take an arg to investigate
> other cards (or perhaps plugins) and also return an errno so
> it could be used in scripts ?

Only if you promise to never drop CCs again (although I don't know about=20
plugins).

>  # gcc -W -Wall -o snd_rate snd_rate.c -l asound
>  snd_rate.c: In function 'main':
>  snd_rate.c:14: warning: the address of =E2=80=98params=E2=80=99 will a=
lways evaluate as 'true'

That's the ALSA snd_pcm_hw_params_alloca(). No such warning here, but I'v=
e=20
made it a regular malloc.

>  # snd_rate
>  snd_pcm_open: Device or resource busy
>=20
> In fact, why isn't there a single simple "alsainfo" type
> program that tells a user some (or a lot) of info about
> their hardware and alsa-lib install ?

I guess because noone wrote one :-)

It seems by the way that dir !=3D 0 _can_ be returned for hw devices, and=
 this=20
just ignores it. Just some rounding issue I guess.

Rene.


--------------030605090705070407050505
Content-Type: text/plain;
 name="alsa-rate.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="alsa-rate.c"

LyogZ2NjIC1XIC1XYWxsIC1vIGFsc2EtcmF0ZSBhbHNhLXJhdGUuYyAtbGFzb3VuZCAqLwoK
I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxhbHNhL2Fzb3VuZGxpYi5oPgoKaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJY2hhciAqZGV2aWNlOwoJc25kX3BjbV90
ICpoYW5kbGU7CglzbmRfcGNtX2h3X3BhcmFtc190ICpwYXJhbXM7Cgl1bnNpZ25lZCBpbnQg
bWluOwoJdW5zaWduZWQgaW50IG1heDsKCWludCBkaXI7CglpbnQgZXJyOwoKCWRldmljZSA9
IGFyZ2MgPiAxID8gYXJndlsxXSA6ICJodzowLDAiOwoKCWVyciA9IHNuZF9wY21fb3Blbigm
aGFuZGxlLCBkZXZpY2UsIFNORF9QQ01fU1RSRUFNX1BMQVlCQUNLLCAwKTsKCWlmIChlcnIg
PCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJzbmRfcGNtX29wZW46ICVzXG4iLCBzbmRfc3Ry
ZXJyb3IoZXJyKSk7CgkJcmV0dXJuIGVycjsKCX0KCWVyciA9IHNuZF9wY21faHdfcGFyYW1z
X21hbGxvYygmcGFyYW1zKTsKCWlmIChlcnIgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJz
bmRfcGNtX2h3X3BhcmFtc19hbGxvYzogJXNcbiIsCgkJCXNuZF9zdHJlcnJvcihlcnIpKTsK
CQlyZXR1cm4gZXJyOwoJfQoJZXJyID0gc25kX3BjbV9od19wYXJhbXNfYW55KGhhbmRsZSwg
cGFyYW1zKTsKCWlmIChlcnIgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJzbmRfcGNtX2h3
X3BhcmFtc19hbnk6ICVzXG4iLAoJCQlzbmRfc3RyZXJyb3IoZXJyKSk7CgkJcmV0dXJuIGVy
cjsKCX0KCWVyciA9IHNuZF9wY21fY2xvc2UoaGFuZGxlKTsKCWlmIChlcnIgPCAwKSB7CgkJ
ZnByaW50ZihzdGRlcnIsICJzbmRfcGNtX2Nsb3NlOiAlc1xuIiwgc25kX3N0cmVycm9yKGVy
cikpOwoJCXJldHVybiBlcnI7Cgl9CgllcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19nZXRfcmF0
ZV9taW4ocGFyYW1zLCAmbWluLCAmZGlyKTsKCWlmIChlcnIgPCAwKSB7CgkJZnByaW50Zihz
dGRlcnIsICJzbmRfcGNtX2h3X3BhcmFtc19nZXRfcmF0ZV9taW46ICVzXG4iLAoJCQlzbmRf
c3RyZXJyb3IoZXJyKSk7CgkJcmV0dXJuIGVycjsKCX0KCWVyciA9IHNuZF9wY21faHdfcGFy
YW1zX2dldF9yYXRlX21heChwYXJhbXMsICZtYXgsICZkaXIpOwoJaWYgKGVyciA8IDApIHsK
CQlmcHJpbnRmKHN0ZGVyciwgInNuZF9wY21faHdfcGFyYW1zX2dldF9yYXRlX21heDogJXNc
biIsCgkJCXNuZF9zdHJlcnJvcihlcnIpKTsKCQlyZXR1cm4gZXJyOwoJfQoJc25kX3BjbV9o
d19wYXJhbXNfZnJlZShwYXJhbXMpOwoKCXByaW50ZigiJXUtJXVcbiIsIG1pbiwgbWF4KTsK
CXJldHVybiAwOwp9Cg==
--------------030605090705070407050505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------030605090705070407050505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------030605090705070407050505--
