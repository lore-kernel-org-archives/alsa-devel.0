From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: .hw_free() while audio is running ??
Date: Tue, 10 Aug 2004 11:25:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408101124230.1779@pnote.perex-int.cz>
References: <20040808172946.43212219.pochini@shiny.it>
 <Pine.LNX.4.58.0408082235380.1771@pnote.perex-int.cz>
 <20040810111427.7815ec73.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463789468-1244407756-1092129905=:1779"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040810111427.7815ec73.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463789468-1244407756-1092129905=:1779
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 10 Aug 2004, Giuliano Pochini wrote:

> On Sun, 8 Aug 2004 22:39:57 +0200 (CEST)
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > > The call sequence in the logs is:
> > >
> > > pcm_trigger (start)	- of two synced ss's
> > > pcm_hw_free (playback ss)
> > > Crash, nothing more in the logs :(
> > >
> > > trigger(stop) wasn't called before hw_free.
> >
> > You have an SMP machine? The hw_free is protected with the 
> > runtime->status->state checking, but the code is not protected with 
> > spinlock, so I suspect trouble here.
> 
> Yes, this is a dual processor, but I booted with maxcpus=1 and preempt is
> not enabled.

Could you try the attached patch, if it helps?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
---1463789468-1244407756-1092129905=:1779
Content-Type: TEXT/plain; charset=US-ASCII; name="out.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0408101125050.1779@pnote.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="out.txt"

SW5kZXg6IHBjbV9uYXRpdmUuYw0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
UkNTIGZpbGU6IC9jdnNyb290L2Fsc2EvYWxzYS1rZXJuZWwvY29yZS9wY21f
bmF0aXZlLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEwMg0KZGlmZiAt
dSAtcjEuMTAyIHBjbV9uYXRpdmUuYw0KLS0tIHBjbV9uYXRpdmUuYwkyNyBK
dWwgMjAwNCAxMjoyODozNiAtMDAwMAkxLjEwMg0KKysrIHBjbV9uYXRpdmUu
YwkxMCBBdWcgMjAwNCAwOToyNzoyMyAtMDAwMA0KQEAgLTMzOSwxNCArMzM5
LDE3IEBADQogCXNuZF9hc3NlcnQoc3Vic3RyZWFtICE9IE5VTEwsIHJldHVy
biAtRU5YSU8pOw0KIAlydW50aW1lID0gc3Vic3RyZWFtLT5ydW50aW1lOw0K
IAlzbmRfYXNzZXJ0KHJ1bnRpbWUgIT0gTlVMTCwgcmV0dXJuIC1FTlhJTyk7
DQorCXNuZF9wY21fc3RyZWFtX2xvY2tfaXJxKHN1YnN0cmVhbSk7DQogCXN3
aXRjaCAocnVudGltZS0+c3RhdHVzLT5zdGF0ZSkgew0KIAljYXNlIFNORFJW
X1BDTV9TVEFURV9PUEVOOg0KIAljYXNlIFNORFJWX1BDTV9TVEFURV9TRVRV
UDoNCiAJY2FzZSBTTkRSVl9QQ01fU1RBVEVfUFJFUEFSRUQ6DQogCQlicmVh
azsNCiAJZGVmYXVsdDoNCisJCXNuZF9wY21fc3RyZWFtX3VubG9ja19pcnEo
c3Vic3RyZWFtKTsNCiAJCXJldHVybiAtRUJBREZEOw0KIAl9DQorCXNuZF9w
Y21fc3RyZWFtX3VubG9ja19pcnEoc3Vic3RyZWFtKTsNCiAjaWYgZGVmaW5l
ZChDT05GSUdfU05EX1BDTV9PU1MpIHx8IGRlZmluZWQoQ09ORklHX1NORF9Q
Q01fT1NTX01PRFVMRSkNCiAJaWYgKCFzdWJzdHJlYW0tPm9zcy5vc3MpDQog
I2VuZGlmDQpAQCAtNDUyLDEzICs0NTUsMTYgQEANCiAJc25kX2Fzc2VydChz
dWJzdHJlYW0gIT0gTlVMTCwgcmV0dXJuIC1FTlhJTyk7DQogCXJ1bnRpbWUg
PSBzdWJzdHJlYW0tPnJ1bnRpbWU7DQogCXNuZF9hc3NlcnQocnVudGltZSAh
PSBOVUxMLCByZXR1cm4gLUVOWElPKTsNCisJc25kX3BjbV9zdHJlYW1fbG9j
a19pcnEoc3Vic3RyZWFtKTsNCiAJc3dpdGNoIChydW50aW1lLT5zdGF0dXMt
PnN0YXRlKSB7DQogCWNhc2UgU05EUlZfUENNX1NUQVRFX1NFVFVQOg0KIAlj
YXNlIFNORFJWX1BDTV9TVEFURV9QUkVQQVJFRDoNCiAJCWJyZWFrOw0KIAlk
ZWZhdWx0Og0KKwkJc25kX3BjbV9zdHJlYW1fdW5sb2NrX2lycShzdWJzdHJl
YW0pOw0KIAkJcmV0dXJuIC1FQkFERkQ7DQogCX0NCisJc25kX3BjbV9zdHJl
YW1fdW5sb2NrX2lycShzdWJzdHJlYW0pOw0KIAlpZiAoYXRvbWljX3JlYWQo
JnJ1bnRpbWUtPm1tYXBfY291bnQpKQ0KIAkJcmV0dXJuIC1FQkFERkQ7DQog
CWlmIChzdWJzdHJlYW0tPm9wcy0+aHdfZnJlZSA9PSBOVUxMKSB7DQpAQCAt
NDczLDExICs0NzksMTYgQEANCiBzdGF0aWMgaW50IHNuZF9wY21fc3dfcGFy
YW1zKHNuZF9wY21fc3Vic3RyZWFtX3QgKiBzdWJzdHJlYW0sIHNuZF9wY21f
c3dfcGFyYW1zX3QgKnBhcmFtcykNCiB7DQogCXNuZF9wY21fcnVudGltZV90
ICpydW50aW1lOw0KKw0KIAlzbmRfYXNzZXJ0KHN1YnN0cmVhbSAhPSBOVUxM
LCByZXR1cm4gLUVOWElPKTsNCiAJcnVudGltZSA9IHN1YnN0cmVhbS0+cnVu
dGltZTsNCiAJc25kX2Fzc2VydChydW50aW1lICE9IE5VTEwsIHJldHVybiAt
RU5YSU8pOw0KLQlpZiAocnVudGltZS0+c3RhdHVzLT5zdGF0ZSA9PSBTTkRS
Vl9QQ01fU1RBVEVfT1BFTikNCisJc25kX3BjbV9zdHJlYW1fdW5sb2NrX2ly
cShzdWJzdHJlYW0pOw0KKwlpZiAocnVudGltZS0+c3RhdHVzLT5zdGF0ZSA9
PSBTTkRSVl9QQ01fU1RBVEVfT1BFTikgew0KKwkJc25kX3BjbV9zdHJlYW1f
dW5sb2NrX2lycShzdWJzdHJlYW0pOw0KIAkJcmV0dXJuIC1FQkFERkQ7DQor
CX0NCisJc25kX3BjbV9zdHJlYW1fdW5sb2NrX2lycShzdWJzdHJlYW0pOw0K
IA0KIAlpZiAocGFyYW1zLT50c3RhbXBfbW9kZSA+IFNORFJWX1BDTV9UU1RB
TVBfTEFTVCkNCiAJCXJldHVybiAtRUlOVkFMOw0KQEAgLTYwNSw4ICs2MTYs
MTIgQEANCiAJCXJldHVybiAtRUZBVUxUOw0KIAljaGFubmVsID0gaW5mby5j
aGFubmVsOw0KIAlydW50aW1lID0gc3Vic3RyZWFtLT5ydW50aW1lOw0KLQlp
ZiAocnVudGltZS0+c3RhdHVzLT5zdGF0ZSA9PSBTTkRSVl9QQ01fU1RBVEVf
T1BFTikNCisJc25kX3BjbV9zdHJlYW1fbG9ja19pcnEoc3Vic3RyZWFtKTsN
CisJaWYgKHJ1bnRpbWUtPnN0YXR1cy0+c3RhdGUgPT0gU05EUlZfUENNX1NU
QVRFX09QRU4pIHsNCisJCXNuZF9wY21fc3RyZWFtX3VubG9ja19pcnEoc3Vi
c3RyZWFtKTsNCiAJCXJldHVybiAtRUJBREZEOw0KKwl9DQorCXNuZF9wY21f
c3RyZWFtX3VubG9ja19pcnEoc3Vic3RyZWFtKTsNCiAJaWYgKGNoYW5uZWwg
Pj0gcnVudGltZS0+Y2hhbm5lbHMpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJ
bWVtc2V0KCZpbmZvLCAwLCBzaXplb2YoaW5mbykpOw0KQEAgLTE0OTYsOCAr
MTUxMSwxMiBAQA0KIAlzbmRfcGNtX2ZpbGVfdCAqcGNtX2ZpbGU7DQogCXNu
ZF9wY21fc3Vic3RyZWFtX3QgKnN1YnN0cmVhbTE7DQogDQotCWlmIChzdWJz
dHJlYW0tPnJ1bnRpbWUtPnN0YXR1cy0+c3RhdGUgPT0gU05EUlZfUENNX1NU
QVRFX09QRU4pDQorCXNuZF9wY21fc3RyZWFtX2xvY2tfaXJxKHN1YnN0cmVh
bSk7DQorCWlmIChzdWJzdHJlYW0tPnJ1bnRpbWUtPnN0YXR1cy0+c3RhdGUg
PT0gU05EUlZfUENNX1NUQVRFX09QRU4pIHsNCisJCXNuZF9wY21fc3RyZWFt
X3VubG9ja19pcnEoc3Vic3RyZWFtKTsNCiAJCXJldHVybiAtRUJBREZEOw0K
Kwl9DQorCXNuZF9wY21fc3RyZWFtX3VubG9ja19pcnEoc3Vic3RyZWFtKTsN
CiAJZmlsZSA9IHNuZF9wY21fZmlsZV9mZChmZCk7DQogCWlmICghZmlsZSkN
CiAJCXJldHVybiAtRUJBREZEOw0K

---1463789468-1244407756-1092129905=:1779--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
