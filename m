From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: [Fwd: ALSA programming example fix]
Date: Thu, 11 Jul 2002 02:37:32 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2C70DC.6080500@boosthardware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090805030706030000000907"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090805030706030000000907
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This has been sent to me as a fix for one of the doxygen docs.

--------------090805030706030000000907
Content-Type: message/rfc822;
 name="ALSA programming example fix"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ALSA programming example fix"

X-Mozilla-Status2: 10000000
Return-Path: <mwalker@attbi.com>
Delivered-To: boosth-pshirkey@boosthardware.com
Received: (qmail 19341 invoked from network); 9 Jul 2002 17:07:26 -0000
Received: from sccrmhc02.attbi.com (204.127.202.62)
  by -H with SMTP; 9 Jul 2002 17:07:26 -0000
Received: from there ([12.238.48.133]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with SMTP
          id <20020709170853.THD6023.sccrmhc02.attbi.com@there>
          for <pshirkey@boosthardware.com>; Tue, 9 Jul 2002 17:08:53 +0000
From: Matt Walker <mwalker@attbi.com>
To: pshirkey@boosthardware.com
Subject: ALSA programming example fix
Date: Tue, 9 Jul 2002 12:07:45 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XKRZHATO3893BC5MIORJ"
Message-Id: <20020709170853.THD6023.sccrmhc02.attbi.com@there>


--------------Boundary-00=_XKRZHATO3893BC5MIORJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

Patrick --

Here is a fix for the test/rawmidi.c file that comes with the 0.9 RawMidi API 
docs.

On line 18 the usage example erroneously suggests that the '-o' flag will 
work with a file descriptor. There's three days of my life I'll never get 
back.

On line 140 it suggests a ctrl-c to get contol back from read() la-la land. I 
would fix this, but perhaps the original author could be contacted as to his 
intentions when he wrote it.

Regards,

Matt Walker

--------------------------------------------------------------------------------------

Message: 1
Date: Mon, 10 Jun 2002 15:16:50 +0900
From: Patrick Shirkey <pshirkey@boosthardware.com>
Organization: Boost Hardware
To: Paul Davis <pbd@op.net>
CC: tomasz motylewski <T.Motylewski@bfad.de>, Tim Goetze <tim@quitte.de>,
        Philipp Vollmer <vollmer.philipp@t-online.de>,
        alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Alsa Programming Examples

Paul Davis wrote:

> 
> agreed. perhaps you can fix them, or produce a version of the document
> with them removed so that a better link can be used. If you would like
> to pay me to rearrange my time to get the code removed and/or fixed,
> thats fine. Otherwise, please accept the limited offering thats linked
> to right now.
> 
> 

If people send in a fix to that file I'll add it in and put up the 
revision on ALSA if Paul doesn't mind.
--------------Boundary-00=_XKRZHATO3893BC5MIORJ
Content-Type: text/x-c;
  charset="iso-8859-15";
  name="rawmidi.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rawmidi.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGN0eXBlLmg+
CiNpbmNsdWRlIDxhbHNhL2Fzb3VuZGxpYi5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CgpzdGF0aWMg
dm9pZCB1c2FnZSh2b2lkKQp7CiAgICBmcHJpbnRmKHN0ZGVyciwgInVzYWdlOiByYXdtaWRpIFtv
cHRpb25zXVxuIik7CiAgICBmcHJpbnRmKHN0ZGVyciwgIiAgb3B0aW9uczpcbiIpOwogICAgZnBy
aW50ZihzdGRlcnIsICIgICAgLXY6IHZlcmJvc2UgbW9kZVxuIik7CiAgICBmcHJpbnRmKHN0ZGVy
ciwgIiAgICAtaSBkZXZpY2UtaWQgOiB0ZXN0IEFMU0EgaW5wdXQgZGV2aWNlXG4iKTsKICAgIGZw
cmludGYoc3RkZXJyLCAiICAgIC1vIGRldmljZS1pZCA6IHRlc3QgQUxTQSBvdXRwdXQgZGV2aWNl
XG4iKTsKICAgIGZwcmludGYoc3RkZXJyLCAiICAgIC1JIG5vZGUgICAgICA6IHRlc3QgaW5wdXQg
bm9kZVxuIik7CiAgICBmcHJpbnRmKHN0ZGVyciwgIiAgICAtTyBub2RlICAgICAgOiB0ZXN0IG91
dHB1dCBub2RlXG4iKTsKICAgIGZwcmludGYoc3RkZXJyLCAiICAgIC10OiB0ZXN0IG1pZGkgdGhy
dVxuIik7CiAgICBmcHJpbnRmKHN0ZGVyciwgIiAgZXhhbXBsZTpcbiIpOwogICAgZnByaW50Zihz
dGRlcnIsICIgICAgcmF3bWlkaSAtaSBodzowLDAgLU8gL2Rldi9zbmQvbWlkaUMwRDBcbiIpOwog
ICAgZnByaW50ZihzdGRlcnIsICIgICAgdGVzdHMgaW5wdXQgZm9yIGNhcmQgMCwgZGV2aWNlIDAs
IHVzaW5nIHNuZF9yYXdtaWRpIEFQSVxuIik7CiAgICBmcHJpbnRmKHN0ZGVyciwgIiAgICBhbmQg
L2Rldi9taWRpMSB1c2luZyBmaWxlIGRlc2NyaXB0b3JzXG4iKTsKfQoKaW50IHN0b3A9MDsKCnZv
aWQgc2lnaGFuZGxlcihpbnQgZHVtKQp7CiAgICBzdG9wPTE7Cn0KCmludCBtYWluKGludCBhcmdj
LGNoYXIqKiBhcmd2KQp7CiAgICBpbnQgaTsKICAgIGludCBlcnI7CiAgICBpbnQgdGhydT0wOwog
ICAgaW50IHZlcmJvc2UgPSAwOwogICAgY2hhciAqZGV2aWNlX2luID0gTlVMTDsKICAgIGNoYXIg
KmRldmljZV9vdXQgPSBOVUxMOwogICAgY2hhciAqbm9kZV9pbiA9IE5VTEw7CiAgICBjaGFyICpu
b2RlX291dCA9IE5VTEw7CiAgICAgICAgCiAgICBpbnQgZmRfaW4gPSAtMSxmZF9vdXQgPSAtMTsK
ICAgIHNuZF9yYXdtaWRpX3QgKmhhbmRsZV9pbiA9IDAsKmhhbmRsZV9vdXQgPSAwOwogICAgICAg
IAogICAgaWYgKGFyZ2M9PTEpIHsKCXVzYWdlKCk7CglleGl0KDApOwogICAgfQogICAgICAgIAog
ICAgZm9yIChpID0gMSA7IGk8YXJnYyA7IGkrKykgewoJaWYgKGFyZ3ZbaV1bMF09PSctJykgewoJ
ICAgIHN3aXRjaCAoYXJndltpXVsxXSkgewoJCWNhc2UgJ2gnOgoJCSAgICB1c2FnZSgpOwoJCSAg
ICBicmVhazsKCQljYXNlICd2JzoKCQkgICAgdmVyYm9zZSA9IDE7CgkJICAgIGJyZWFrOwoJCWNh
c2UgJ3QnOgoJCSAgICB0aHJ1ID0gMTsKCQkgICAgYnJlYWs7CgkJY2FzZSAnaSc6CgkJICAgIGlm
IChpICsgMSA8IGFyZ2MpCgkJCWRldmljZV9pbiA9IGFyZ3ZbKytpXTsKCQkgICAgYnJlYWs7CgkJ
Y2FzZSAnSSc6CgkJICAgIGlmIChpICsgMSA8IGFyZ2MpCgkJCW5vZGVfaW4gPSBhcmd2WysraV07
CgkJICAgIGJyZWFrOwoJCWNhc2UgJ28nOgoJCSAgICBpZiAoaSArIDEgPCBhcmdjKQoJCQlkZXZp
Y2Vfb3V0ID0gYXJndlsrK2ldOwoJCSAgICBicmVhazsKCQljYXNlICdPJzoKCQkgICAgaWYgKGkg
KyAxIDwgYXJnYykKCQkJbm9kZV9vdXQgPSBhcmd2WysraV07CgkJICAgIGJyZWFrOwoJICAgIH0g
ICAgICAgICAgICAgICAgICAgICAgIAoJfQogICAgfQoKICAgIGlmICh2ZXJib3NlKSB7CglmcHJp
bnRmKHN0ZGVyciwiVXNpbmc6IFxuIik7CglmcHJpbnRmKHN0ZGVyciwiSW5wdXQ6ICIpOwoJaWYg
KGRldmljZV9pbikgewoJICAgIGZwcmludGYoc3RkZXJyLCJkZXZpY2UgJXNcbiIsZGV2aWNlX2lu
KTsKCX1lbHNlIGlmIChub2RlX2luKXsKCSAgICBmcHJpbnRmKHN0ZGVyciwiJXNcbiIsbm9kZV9p
bik7IAoJfWVsc2V7CgkgICAgZnByaW50ZihzdGRlcnIsIk5PTkVcbiIpOwoJfQoJZnByaW50Zihz
dGRlcnIsIk91dHB1dDogIik7CglpZiAoZGV2aWNlX291dCkgewoJICAgIGZwcmludGYoc3RkZXJy
LCJkZXZpY2UgJXNcbiIsZGV2aWNlX291dCk7Cgl9ZWxzZSBpZiAobm9kZV9vdXQpewoJICAgIGZw
cmludGYoc3RkZXJyLCIlc1xuIixub2RlX291dCk7ICAgICAgICAgICAgICAgIAoJfWVsc2V7Cgkg
ICAgZnByaW50ZihzdGRlcnIsIk5PTkVcbiIpOwoJfQogICAgfQogICAgICAgIAogICAgaWYgKGRl
dmljZV9pbikgewoJZXJyID0gc25kX3Jhd21pZGlfb3BlbigmaGFuZGxlX2luLE5VTEwsZGV2aWNl
X2luLDApOyAgICAKCWlmIChlcnIpIHsKCSAgICBmcHJpbnRmKHN0ZGVyciwic25kX3Jhd21pZGlf
b3BlbiAlcyBmYWlsZWQ6ICVkXG4iLGRldmljZV9pbixlcnIpOwoJfQogICAgfQogICAgaWYgKG5v
ZGVfaW4gJiYgKCFub2RlX291dCB8fCBzdHJjbXAobm9kZV9vdXQsbm9kZV9pbikpKSB7CglmZF9p
biA9IG9wZW4obm9kZV9pbixPX1JET05MWSk7CglpZiAoZmRfaW48MCkgewoJICAgIGZwcmludGYo
c3RkZXJyLCJvcGVuICVzIGZvciBpbnB1dCBmYWlsZWRcbiIsbm9kZV9pbik7Cgl9ICAgICAgIAog
ICAgfQoKICAgIHNpZ25hbChTSUdJTlQsc2lnaGFuZGxlcik7CgogICAgaWYgKGRldmljZV9vdXQp
IHsKCWVyciA9IHNuZF9yYXdtaWRpX29wZW4oTlVMTCwmaGFuZGxlX291dCxkZXZpY2Vfb3V0LDAp
OwoJaWYgKGVycikgewoJICAgIGZwcmludGYoc3RkZXJyLCJzbmRfcmF3bWlkaV9vcGVuICVzIGZh
aWxlZDogJWRcbiIsZGV2aWNlX291dCxlcnIpOwoJfQogICAgfQogICAgaWYgKG5vZGVfb3V0ICYm
ICghbm9kZV9pbiB8fCBzdHJjbXAobm9kZV9vdXQsbm9kZV9pbikpKSB7CglmZF9vdXQgPSBvcGVu
KG5vZGVfb3V0LE9fV1JPTkxZKTsgICAgICAgICAgICAgICAKCWlmIChmZF9vdXQ8MCkgewoJICAg
IGZwcmludGYoc3RkZXJyLCJvcGVuICVzIGZvciBvdXRwdXQgZmFpbGVkXG4iLG5vZGVfb3V0KTsK
CX0gICAgICAgCiAgICB9CgogICAgaWYgKG5vZGVfaW4gJiYgbm9kZV9vdXQgJiYgc3RyY21wKG5v
ZGVfb3V0LG5vZGVfaW4pPT0wKSB7CglmZF9pbiA9IGZkX291dCA9IG9wZW4obm9kZV9vdXQsT19S
RFdSKTsgICAgICAgICAKCWlmIChmZF9vdXQ8MCkgewoJICAgIGZwcmludGYoc3RkZXJyLCJvcGVu
ICVzIGZvciBpbnB1dCBhbmQgb3V0cHV0IGZhaWxlZFxuIixub2RlX291dCk7Cgl9ICAgICAgICAg
ICAgICAgCiAgICB9CgoKCiAgICBpZiAoIXRocnUpIHsKCWlmIChoYW5kbGVfaW4gfHwgZmRfaW4h
PS0xKSB7CgkgICAgZnByaW50ZihzdGRlcnIsIlJlYWQgbWlkaSBpblxuIik7CgkgICAgZnByaW50
ZihzdGRlcnIsIlByZXNzIGN0cmwtYyB0byBzdG9wXG4iKTsKCX0KCglpZiAoaGFuZGxlX2luKSB7
CgkgICAgdW5zaWduZWQgY2hhciBjaDsKCSAgICB3aGlsZSAoIXN0b3ApIHsKCQlzbmRfcmF3bWlk
aV9yZWFkKGhhbmRsZV9pbiwmY2gsMSk7CgkJaWYgKHZlcmJvc2UpIHsKCQkgICAgZnByaW50Zihz
dGRlcnIsInJlYWQgJTAyeFxuIixjaCk7CgkJfQoJICAgIH0KCX0KCWlmIChmZF9pbiE9LTEpIHsK
CSAgICB1bnNpZ25lZCBjaGFyIGNoOwoJICAgIHdoaWxlICghc3RvcCkgewoJCXJlYWQoZmRfaW4s
JmNoLDEpOwoJCWlmICh2ZXJib3NlKSB7CgkJICAgIGZwcmludGYoc3RkZXJyLCJyZWFkICUwMnhc
biIsY2gpOwoJCX0KCSAgICB9ICAgICAgIAoJfQoKCWlmIChoYW5kbGVfb3V0IHx8IGZkX291dCE9
LTEpIHsKCSAgICBmcHJpbnRmKHN0ZGVyciwiV3JpdGluZyBub3RlIG9uIC8gbm90ZSBvZmZcbiIp
OwoJfQoKCWlmIChoYW5kbGVfb3V0KSB7CgkgICAgdW5zaWduZWQgY2hhciBjaDsKCSAgICBjaD0w
eDkwOyBzbmRfcmF3bWlkaV93cml0ZShoYW5kbGVfb3V0LCZjaCwxKTsKCSAgICBjaD02MDsgICBz
bmRfcmF3bWlkaV93cml0ZShoYW5kbGVfb3V0LCZjaCwxKTsKCSAgICBjaD0xMDA7ICBzbmRfcmF3
bWlkaV93cml0ZShoYW5kbGVfb3V0LCZjaCwxKTsKCSAgICBzbmRfcmF3bWlkaV9kcmFpbihoYW5k
bGVfb3V0KTsKCSAgICBzbGVlcCgxKTsKCSAgICBjaD0weDkwOyBzbmRfcmF3bWlkaV93cml0ZSho
YW5kbGVfb3V0LCZjaCwxKTsKCSAgICBjaD02MDsgICBzbmRfcmF3bWlkaV93cml0ZShoYW5kbGVf
b3V0LCZjaCwxKTsKCSAgICBjaD0wOyAgICBzbmRfcmF3bWlkaV93cml0ZShoYW5kbGVfb3V0LCZj
aCwxKTsKCSAgICBzbmRfcmF3bWlkaV9kcmFpbihoYW5kbGVfb3V0KTsgCgl9CglpZiAoZmRfb3V0
IT0tMSkgewoJICAgIHVuc2lnbmVkIGNoYXIgY2g7CgkgICAgY2g9MHg5MDsgd3JpdGUoZmRfb3V0
LCZjaCwxKTsKCSAgICBjaD02MDsgICB3cml0ZShmZF9vdXQsJmNoLDEpOwoJICAgIGNoPTEwMDsg
IHdyaXRlKGZkX291dCwmY2gsMSk7CgkgICAgc2xlZXAoMSk7CgkgICAgY2g9MHg5MDsgd3JpdGUo
ZmRfb3V0LCZjaCwxKTsKCSAgICBjaD02MDsgICB3cml0ZShmZF9vdXQsJmNoLDEpOwoJICAgIGNo
PTA7ICAgIHdyaXRlKGZkX291dCwmY2gsMSk7Cgl9CiAgICB9IGVsc2UgewoJaWYgKChoYW5kbGVf
aW4gfHwgZmRfaW4hPS0xKSAmJiAoaGFuZGxlX291dCB8fCBmZF9vdXQhPS0xKSkgewoJICAgIGlm
ICh2ZXJib3NlKSB7CgkJZnByaW50ZihzdGRlcnIsIlRlc3RpbmcgbWlkaSB0aHJ1IGluXG4iKTsK
CSAgICB9CgkgICAgd2hpbGUgKCFzdG9wKSB7CgkJdW5zaWduZWQgY2hhciBjaDsKICAgICAgICAg
ICAgICAgICAgICAgICAgCgkJaWYgKGhhbmRsZV9pbikgewoJCSAgICBzbmRfcmF3bWlkaV9yZWFk
KGhhbmRsZV9pbiwmY2gsMSk7CgkJfQoJCWlmIChmZF9pbiE9LTEpIHsKCQkgICAgcmVhZChmZF9p
biwmY2gsMSk7CgkJfSAgICAgICAKCQlpZiAodmVyYm9zZSkgewoJCSAgICBmcHJpbnRmKHN0ZGVy
ciwidGhydTogJTAyeFxuIixjaCk7CgkJfQoKCQlpZiAoaGFuZGxlX291dCkgewoJCSAgICBzbmRf
cmF3bWlkaV93cml0ZShoYW5kbGVfb3V0LCZjaCwxKTsKCQkgICAgc25kX3Jhd21pZGlfZHJhaW4o
aGFuZGxlX291dCk7IAoJCX0KCQlpZiAoZmRfb3V0IT0tMSkgewoJCSAgICB3cml0ZShmZF9vdXQs
JmNoLDEpOwoJCX0KCSAgICB9Cgl9ZWxzZXsKCSAgICBmcHJpbnRmKHN0ZGVyciwiVGVzdGluZyBt
aWRpIHRocnUgbmVlZHMgYm90aCBpbnB1dCBhbmQgb3V0cHV0XG4iKTsgICAgICAgICAgICAgIAoJ
ICAgIGV4aXQoLTEpOwoJfQogICAgfQoKICAgIGlmICh2ZXJib3NlKSB7CglmcHJpbnRmKHN0ZGVy
ciwiQ2xvc2luZ1xuIik7CiAgICB9CiAgICAgICAgCiAgICBpZiAoaGFuZGxlX2luKSB7CglzbmRf
cmF3bWlkaV9kcmFpbihoYW5kbGVfaW4pOyAKCXNuZF9yYXdtaWRpX2Nsb3NlKGhhbmRsZV9pbik7
ICAgCiAgICB9CiAgICBpZiAoaGFuZGxlX291dCkgewoJc25kX3Jhd21pZGlfZHJhaW4oaGFuZGxl
X291dCk7IAoJc25kX3Jhd21pZGlfY2xvc2UoaGFuZGxlX291dCk7ICAKICAgIH0KICAgIGlmIChm
ZF9pbiE9LTEpIHsKCWNsb3NlKGZkX2luKTsKICAgIH0KICAgIGlmIChmZF9vdXQhPS0xKSB7Cglj
bG9zZShmZF9vdXQpOwogICAgfQoKICAgIHJldHVybiAwOwp9Cgo=

--------------Boundary-00=_XKRZHATO3893BC5MIORJ--



--------------090805030706030000000907--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Two, two, TWO treats in one.
http://thinkgeek.com/sf
