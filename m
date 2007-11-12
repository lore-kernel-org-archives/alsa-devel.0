From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: Re: issues with pulse plugin
Date: Mon, 12 Nov 2007 07:03:17 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711120700070.7101@mgorse.dhs.org>
References: <Pine.LNX.4.64.0711081709350.19354@mgorse.dhs.org>
	<s5hzlxjx5hs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-972930165-1194868997=:7101"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA05.westchester.pa.mail.comcast.net
	(qmta05.westchester.pa.mail.comcast.net [76.96.62.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D29424558
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 13:02:25 +0100 (CET)
In-Reply-To: <s5hzlxjx5hs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-972930165-1194868997=:7101
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi Takashi,

> Can't you reopen (as feedback)?

Oh, perhaps I could; I haven't used Mantis before and didn't look that 
carefully :(

>> Also, I'm still encountering bug 2601 (a separate assert failure that
>> happens if period_size == 0) even with the patch to pcm_ioplug.c.  I think
>> that PERIOD_TIME and PERIODS need to be constrained; I added a couple of
>> comments to the bug.
>
> Hm, does it happen with the latest HG tree, too?

Yes (at least with the latest hg tree that was accessible via hg-mirror a 
few minutes ago).  I put a patch on the bug that does make things work. 
Test case attached (adapted from flite mostly)
--8323328-972930165-1194868997=:7101
Content-Type: TEXT/x-csrc; charset=US-ASCII; name=2601.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0711120703170.7101@mgorse.dhs.org>
Content-Description: 
Content-Disposition: attachment; filename=2601.c

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5j
bHVkZSAgPHRpbWUuaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCiNpbmNsdWRl
IDx1bmlzdGQuaD4NCiNpbmNsdWRlIDxhbHNhL2Fzb3VuZGxpYi5oPg0KDQpz
dGF0aWMgaW50IGdldEF2YWlsYWJsZUZyYW1lcyhzbmRfcGNtX3QgKnBjbSwg
aW50ICp4cnVuT2NjdXJyZWQpDQp7DQogICAgc25kX3BjbV9zZnJhbWVzX3Qg
ZnJhbWVzQXZhaWwgPSBzbmRfcGNtX2F2YWlsX3VwZGF0ZSggcGNtICk7DQog
ICAgKnhydW5PY2N1cnJlZCA9IDA7DQoNCiAgICBpZiggLUVQSVBFID09IGZy
YW1lc0F2YWlsICkNCiAgICB7DQogICAgICAgICp4cnVuT2NjdXJyZWQgPSAx
Ow0KICAgICAgICBmcmFtZXNBdmFpbCA9IDA7DQogICAgfQ0KDQogICAgcmV0
dXJuIGZyYW1lc0F2YWlsOw0KfQ0KDQpzdGF0aWMgY2hhciAqYnVmOw0KDQpz
bmRfcGNtX3QgKmF1ZGlvX29wZW5fYWxzYShjb25zdCBjaGFyICpwY21fZGV2
X25hbWUsIGludCBzcHMsIGludCBjaGFubmVscykNCnsNCiAgdW5zaWduZWQg
CWludCByZWFsX3JhdGU7DQogIGludCBlcnI7DQogIHVuc2lnbmVkIGxvbmcg
YnVmU3ogPSAxNDExOw0KDQogIHNuZF9wY21fdCAqcGNtX2hhbmRsZTsgICAg
ICAgICAgDQogIHNuZF9wY21fc3RyZWFtX3Qgc3RyZWFtID0gU05EX1BDTV9T
VFJFQU1fUExBWUJBQ0s7DQogIHNuZF9wY21faHdfcGFyYW1zX3QgKmh3cGFy
YW1zOw0KICBzbmRfcGNtX2Zvcm1hdF90IGZvcm1hdDsNCiAgc25kX3BjbV9h
Y2Nlc3NfdCBhY2Nlc3MgPSBTTkRfUENNX0FDQ0VTU19SV19JTlRFUkxFQVZF
RDsNCg0KICAvKiBBbGxvY2F0ZSB0aGUgc25kX3BjbV9od19wYXJhbXNfdCBz
dHJ1Y3R1cmUgb24gdGhlIHN0YWNrLiAqLw0KICBzbmRfcGNtX2h3X3BhcmFt
c19hbGxvY2EoJmh3cGFyYW1zKTsNCg0KICAvKiBPcGVuIHBjbSBkZXZpY2Ug
Ki8NCiAgZXJyID0gc25kX3BjbV9vcGVuKCZwY21faGFuZGxlLCBwY21fZGV2
X25hbWUsIHN0cmVhbSwgMCk7DQogIGlmIChlcnIgPCAwKSANCiAgew0KCXJl
dHVybiBOVUxMOw0KICB9DQoNCiAgLyogSW5pdCBod3BhcmFtcyB3aXRoIGZ1
bGwgY29uZmlndXJhdGlvbiBzcGFjZSAqLw0KICBlcnIgPSBzbmRfcGNtX2h3
X3BhcmFtc19hbnkocGNtX2hhbmRsZSwgaHdwYXJhbXMpOw0KICBpZiAoZXJy
IDwgMCkgDQogIHsNCglzbmRfcGNtX2Nsb3NlKHBjbV9oYW5kbGUpOw0KCXJl
dHVybiBOVUxMOw0KICB9DQoNCiAgLyogU2V0IGFjY2VzcyBtb2RlICovDQog
IGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9hY2Nlc3MocGNtX2hhbmRs
ZSwgaHdwYXJhbXMsIGFjY2Vzcyk7DQogIGlmIChlcnIgPCAwKSANCiAgew0K
CXNuZF9wY21fY2xvc2UocGNtX2hhbmRsZSk7DQoJcmV0dXJuIE5VTEw7DQog
IH0NCg0KICBmb3JtYXQgPSBTTkRfUENNX0ZPUk1BVF9TMTZfTEU7DQoNCiAg
LyogU2V0IHNhbWJsZSBmb3JtYXQgKi8NCiAgZXJyID0gc25kX3BjbV9od19w
YXJhbXNfc2V0X2Zvcm1hdChwY21faGFuZGxlLCBod3BhcmFtcywgZm9ybWF0
KTsNCiAgaWYgKGVyciA8MCkgDQogIHsNCglzbmRfcGNtX2Nsb3NlKHBjbV9o
YW5kbGUpOw0KCXJldHVybiBOVUxMOw0KICB9DQoNCiAgLyogU2V0IHNhbXBs
ZSByYXRlIG5lYXIgdGhlIGRpc2lyZWQgcmF0ZSAqLw0KICByZWFsX3JhdGUg
PSBzcHM7DQogIGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9yYXRlX25l
YXIocGNtX2hhbmRsZSwgaHdwYXJhbXMsICZyZWFsX3JhdGUsIDApOw0KICBp
ZiAoZXJyIDwgMCkgICANCiAgew0KCXNuZF9wY21fY2xvc2UocGNtX2hhbmRs
ZSk7DQoJcmV0dXJuIE5VTEw7DQogIH0NCg0KICAvKiBTZXQgbnVtYmVyIG9m
IGNoYW5uZWxzICovDQogIGFzc2VydChjaGFubmVscyA+MCk7DQogIGVyciA9
IHNuZF9wY21faHdfcGFyYW1zX3NldF9jaGFubmVscyhwY21faGFuZGxlLCBo
d3BhcmFtcywgY2hhbm5lbHMpOw0KICBpZiAoZXJyIDwgMCkgDQogIHsNCglz
bmRfcGNtX2Nsb3NlKHBjbV9oYW5kbGUpOw0KCXJldHVybiBOVUxMOw0KICB9
DQoNCiAgc25kX3BjbV9od19wYXJhbXNfc2V0X2J1ZmZlcl9zaXplX25lYXIo
cGNtX2hhbmRsZSwgaHdwYXJhbXMsICZidWZTeik7DQoNCiAgLyogQ29tbWl0
IGhhcmR3YXJlIHBhcmFtZXRlcnMgKi8NCiAgZXJyID0gc25kX3BjbV9od19w
YXJhbXMocGNtX2hhbmRsZSwgaHdwYXJhbXMpOw0KICBpZiAoZXJyIDwgMCkg
DQogIHsNCglzbmRfcGNtX2Nsb3NlKHBjbV9oYW5kbGUpOw0KCXJldHVybiBO
VUxMOw0KICB9DQoNCiAgLyogTWFrZSBzdXJlIHRoZSBkZXZpY2UgaXMgcmVh
ZHkgdG8gYWNjZXB0IGRhdGEgKi8NCiAgYXNzZXJ0KHNuZF9wY21fc3RhdGUo
cGNtX2hhbmRsZSkgPT0gU05EX1BDTV9TVEFURV9QUkVQQVJFRCk7DQogIHJl
dHVybiBwY21faGFuZGxlOw0KfQ0KDQptYWluKGludCBhcmdjLCBjb25zdCBj
aGFyICphcmd2W10pDQp7DQogIHNuZF9wY21fdCAqcGNtOw0KICBidWYgPSAo
Y2hhciAqKW1hbGxvYygxMDAwMDAwKTsNCiAgcGNtID0gYXVkaW9fb3Blbl9h
bHNhKCJkZWZhdWx0IiwgMjIwNTAsIDEpOw0KICBpbnQgeHJ1bjsNCiAgaW50
IHJlc3VsdDsNCiAgcHRocmVhZF90IHRoOw0KDQogIGlmICghcGNtKQ0KICB7
DQogICAgZnByaW50ZihzdGRlcnIsICJDb3VsZG4ndCBvcGVuIHBjbVxuIik7
DQogICAgZXhpdCgxKTsNCiAgfQ0KICB1bnNpZ25lZCBsb25nIGF2YWlsID0g
c25kX3BjbV9hdmFpbF91cGRhdGUocGNtKTsNCiAgaWYgKGF2YWlsID4gMTAw
MDAwKSBhdmFpbCA9IDEwMDAwMDsNCiAgcmVzdWx0ID0gc25kX3BjbV93cml0
ZWkocGNtLCBidWYsIGF2YWlsKTsNCn0NCg==

--8323328-972930165-1194868997=:7101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323328-972930165-1194868997=:7101--
