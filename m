From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: xine with dmix
Date: Wed, 21 Jan 2004 20:19:37 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401212012430.2010@pnote.perex-int.cz>
References: <1074607760.9700.453.camel@thor.asgaard.local>
 <Pine.LNX.4.58.0401201628140.2010@pnote.perex-int.cz>
 <1074614789.9699.464.camel@thor.asgaard.local> <1074620372.9697.480.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463789468-99636637-1074712777=:2010"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074620372.9697.480.camel@thor.asgaard.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463789468-99636637-1074712777=:2010
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 20 Jan 2004, Michel D=E4nzer wrote:

> On Tue, 2004-01-20 at 17:06, Michel D=E4nzer wrote:
> > On Tue, 2004-01-20 at 16:29, Jaroslav Kysela wrote:
> > > On Tue, 20 Jan 2004, Michel D=E4nzer wrote:
> > >=20
> > > Could you try the attached patch? If you add a line 'slowptr yes' to =
your=20
> > > dmix pcm definition, the snd_pcm_delay() function should be more prec=
ise.
> >=20
> > It seems to work perfectly, thank you very much!
>=20
> I have to take that back. :(
>=20
> I had put the slowptr in the wrong place (in the dmixer slave pcm
> block), and xine silently fell back to using /dev/dsp (alsa-oss doesn't
> seem to work with it). With the slowptr in the right place, I have now
> verified that xine uses ALSA with it enabled, but it doesn't seem to
> enhance sound quality much if at all.
>=20
> Sorry for the false confirmation. Any other ideas?

Yes, I've tested xine with dmix today and I figured after several hours of=
=20
looking for totaly another problem, that it was 'snd_pcm_wait()' function=
=20
which causes trouble in conjunction with the xine ALSA code algorithm.

The result patch (attached to this mail and available also in CVS) is that
xine works with dmix even without the slowptr option! So there is no=20
reason to make this option as default.

I'm happy that the next direct plugin related bug is solved.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
---1463789468-99636637-1074712777=:2010
Content-Type: TEXT/plain; charset=US-ASCII; name="out.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0401212019370.2010@pnote.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="out.txt"

PyBhDQo/IG91dC50eHQNCj8gcGNtLmMuZW5naW5lDQpJbmRleDogcGNtX2Rp
cmVjdC5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2
c3Jvb3QvYWxzYS9hbHNhLWxpYi9zcmMvcGNtL3BjbV9kaXJlY3QuYyx2DQpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMTENCmRpZmYgLXUgLXIxLjExIHBjbV9k
aXJlY3QuYw0KLS0tIHBjbV9kaXJlY3QuYwk5IEphbiAyMDA0IDE4OjMyOjA1
IC0wMDAwCTEuMTENCisrKyBwY21fZGlyZWN0LmMJMjEgSmFuIDIwMDQgMTk6
MTg6MDYgLTAwMDANCkBAIC00MTAsMTUgKzQxMCwyMyBAQA0KIHsNCiAJc25k
X3BjbV9kaXJlY3RfdCAqZG1peCA9IHBjbS0+cHJpdmF0ZV9kYXRhOw0KIAl1
bnNpZ25lZCBzaG9ydCBldmVudHM7DQotCXN0YXRpYyBzbmRfdGltZXJfcmVh
ZF90IHJidWZbNV07CS8qIGNhbiBiZSBvdmVyd3JpdGVuIGJ5IG11bHRpcGxl
IHBsdWdpbnMsIHdlIGRvbid0IG5lZWQgdGhlIHZhbHVlICovDQorCS8qIHJi
dWYgbWlnaHQgYmUgb3ZlcndyaXRlbiBieSBtdWx0aXBsZSBwbHVnaW5zICov
DQorCS8qIHdlIGRvbid0IG5lZWQgdGhlIHZhbHVlICovDQorCXN0YXRpYyBz
bmRfdGltZXJfcmVhZF90IHJidWZbNV07DQogDQogCWFzc2VydChwZmRzICYm
IG5mZHMgPT0gMSAmJiByZXZlbnRzKTsNCiAJZXZlbnRzID0gcGZkc1swXS5y
ZXZlbnRzOw0KIAlpZiAoZXZlbnRzICYgUE9MTElOKSB7DQotCQlldmVudHMg
fD0gUE9MTE9VVDsNCi0JCWV2ZW50cyAmPSB+UE9MTElOOw0KKwkJaW50IGVt
cHR5ID0gMDsNCisJCWlmIChwY20tPnN0cmVhbSA9PSBTTkRfUENNX1NUUkVB
TV9QTEFZQkFDSykgew0KKwkJCWV2ZW50cyB8PSBQT0xMT1VUOw0KKwkJCWV2
ZW50cyAmPSB+UE9MTElOOw0KKwkJCWVtcHR5ID0gc25kX3BjbV9tbWFwX3Bs
YXliYWNrX2F2YWlsKHBjbSkgPCBwY20tPmF2YWlsX21pbjsNCisJCX0gZWxz
ZSB7DQorCQkJZW1wdHkgPSBzbmRfcGNtX21tYXBfY2FwdHVyZV9hdmFpbChw
Y20pIDwgcGNtLT5hdmFpbF9taW47DQorCQl9DQogCQkvKiBlbXB0eSB0aGUg
dGltZXIgcmVhZCBxdWV1ZSAqLw0KLQkJd2hpbGUgKHNuZF90aW1lcl9yZWFk
KGRtaXgtPnRpbWVyLCAmcmJ1Ziwgc2l6ZW9mKHJidWYpKSA9PSBzaXplb2Yo
cmJ1ZikpIDsNCisJCXdoaWxlIChlbXB0eSAmJiBzbmRfdGltZXJfcmVhZChk
bWl4LT50aW1lciwgJnJidWYsIHNpemVvZihyYnVmKSkgPT0gc2l6ZW9mKHJi
dWYpKSA7DQogCX0NCiAJKnJldmVudHMgPSBldmVudHM7DQogCXJldHVybiAw
Ow0KSW5kZXg6IHBjbV9kbWl4LmMNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvY3Zzcm9vdC9hbHNhL2Fsc2EtbGliL3NyYy9wY20vcGNt
X2RtaXguYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNDcNCmRpZmYgLXUg
LXIxLjQ3IHBjbV9kbWl4LmMNCi0tLSBwY21fZG1peC5jCTIwIEphbiAyMDA0
IDE1OjI5OjM5IC0wMDAwCTEuNDcNCisrKyBwY21fZG1peC5jCTIxIEphbiAy
MDA0IDE5OjE4OjA3IC0wMDAwDQpAQCAtNDA3LDcgKzQwNyw2IEBADQogCX0N
CiAJZG1peC0+aHdfcHRyICs9IGRpZmY7DQogCWRtaXgtPmh3X3B0ciAlPSBw
Y20tPmJvdW5kYXJ5Ow0KLQkvLyBwcmludGYoInN5bmMgcHRyIGRpZmYgPSAl
bGlcbiIsIGRpZmYpOw0KIAlpZiAocGNtLT5zdG9wX3RocmVzaG9sZCA+PSBw
Y20tPmJvdW5kYXJ5KQkvKiBkb24ndCBjYXJlICovDQogCQlyZXR1cm4gMDsN
CiAJaWYgKChhdmFpbCA9IHNuZF9wY21fbW1hcF9wbGF5YmFja19hdmFpbChw
Y20pKSA+PSBwY20tPnN0b3BfdGhyZXNob2xkKSB7DQpAQCAtNTQ1LDYgKzU0
NCw3IEBADQogCWlmIChlcnIgPCAwKQ0KIAkJcmV0dXJuIGVycjsNCiAJZG1p
eC0+c3RhdGUgPSBTTkRfUENNX1NUQVRFX1JVTk5JTkc7DQorCXNuZF9wY21f
aHdzeW5jKGRtaXgtPnNwY20pOw0KIAlkbWl4LT5zbGF2ZV9hcHBsX3B0ciA9
IGRtaXgtPnNsYXZlX2h3X3B0ciA9ICpkbWl4LT5zcGNtLT5ody5wdHI7DQog
CWF2YWlsID0gc25kX3BjbV9tbWFwX3BsYXliYWNrX2h3X2F2YWlsKHBjbSk7
DQogCWlmIChhdmFpbCA8IDApDQpJbmRleDogcGNtX2RzaGFyZS5jDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3QvYWxzYS9h
bHNhLWxpYi9zcmMvcGNtL3BjbV9kc2hhcmUuYyx2DQpyZXRyaWV2aW5nIHJl
dmlzaW9uIDEuMTMNCmRpZmYgLXUgLXIxLjEzIHBjbV9kc2hhcmUuYw0KLS0t
IHBjbV9kc2hhcmUuYwkyMCBKYW4gMjAwNCAxNToyOTozOSAtMDAwMAkxLjEz
DQorKysgcGNtX2RzaGFyZS5jCTIxIEphbiAyMDA0IDE5OjE4OjA3IC0wMDAw
DQpAQCAtMjkyLDYgKzI5Miw3IEBADQogCWlmIChlcnIgPCAwKQ0KIAkJcmV0
dXJuIGVycjsNCiAJZHNoYXJlLT5zdGF0ZSA9IFNORF9QQ01fU1RBVEVfUlVO
TklORzsNCisJc25kX3BjbV9od3N5bmMoZHNoYXJlLT5zcGNtKTsNCiAJZHNo
YXJlLT5zbGF2ZV9hcHBsX3B0ciA9IGRzaGFyZS0+c2xhdmVfaHdfcHRyID0g
KmRzaGFyZS0+c3BjbS0+aHcucHRyOw0KIAlhdmFpbCA9IHNuZF9wY21fbW1h
cF9wbGF5YmFja19od19hdmFpbChwY20pOw0KIAlpZiAoYXZhaWwgPCAwKQ0K
SW5kZXg6IHBjbV9kc25vb3AuYw0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
UkNTIGZpbGU6IC9jdnNyb290L2Fsc2EvYWxzYS1saWIvc3JjL3BjbS9wY21f
ZHNub29wLmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEzDQpkaWZmIC11
IC1yMS4xMyBwY21fZHNub29wLmMNCi0tLSBwY21fZHNub29wLmMJMjAgSmFu
IDIwMDQgMTU6Mjk6MzkgLTAwMDAJMS4xMw0KKysrIHBjbV9kc25vb3AuYwky
MSBKYW4gMjAwNCAxOToxODowNyAtMDAwMA0KQEAgLTI3NCw2ICsyNzQsNyBA
QA0KIAlpZiAoZXJyIDwgMCkNCiAJCXJldHVybiBlcnI7DQogCWRzbm9vcC0+
c3RhdGUgPSBTTkRfUENNX1NUQVRFX1JVTk5JTkc7DQorCXNuZF9wY21faHdz
eW5jKGRzbm9vcC0+c3BjbSk7DQogCWRzbm9vcC0+c2xhdmVfYXBwbF9wdHIg
PSBkc25vb3AtPnNsYXZlX2h3X3B0ciA9ICpkc25vb3AtPnNwY20tPmh3LnB0
cjsNCiAJZ2V0dGltZW9mZGF5KCZ0diwgMCk7DQogCWRzbm9vcC0+dHJpZ2dl
cl90c3RhbXAudHZfc2VjID0gdHYudHZfc2VjOw0K

---1463789468-99636637-1074712777=:2010--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
