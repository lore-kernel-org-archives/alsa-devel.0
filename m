From: SunZhibin <zhibins@live.com>
Subject: cross compile errors
Date: Mon, 21 Jul 2008 10:45:36 +0800
Message-ID: <BAY113-W136601538BE1118E16F963CE8A0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_488433A0.6235AFFC"
Return-path: <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------------=_488433A0.6235AFFC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Spam detection software, running on the system "mail1.perex.cz", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or label
similar future email.  If you have any questions, see
internet@perex.cz for details.

Content preview:  Hello, I want to cross compile alsa-driver for my arm9 =
custom
   board , when I build it, I get the following errors: CC [M] /home/zb/a=
lsa/alsa-driver-1.0.17/acore/memory_wrapper.oIn
   file included from /home/zb/alsa/alsa-driver-1.0.17/acore/memory_wrapp=
er.c:25:/home/zb/alsa/alsa-driver-1.0.17/include/adriver.h:828:
   error: static declaration of 'jiffies_to_msecs' follows non-static dec=
larationinclude/linux/jiffies.h:264:
   error: previous declaration of 'jiffies_to_msecs' was here/home/zb/als=
a/alsa-driver-1.0.17/include/adriver.h:847:
   error: static declaration of 'msecs_to_jiffies' follows non-static dec=
larationinclude/linux/jiffies.h:266:
   error: previous declaration of 'msecs_to_jiffies' was hereIn file incl=
uded
   from /home/zb/alsa/alsa-driver-1.0.17/acore/memory_wrapper.c:25:/home/=
zb/alsa/alsa-driver-1.0.17/include/adriver.h:1552:1:
   warning: "page_to_pfn" redefinedIn file included from include/asm/memo=
ry.h:329,
   from include/asm/system.h:6, from include/linux/list.h:9, from include=
/linux/module.h:9,
   from /home/zb/alsa/alsa-driver-1.0.17/include/adriver.h:26, from /home=
/zb/alsa/alsa-driver-1.0.17/acore/memory_wrapper.c:25:include/asm-generic=
/memory_model.h:79:1:
   warning: this is the location of the previous definitionIn file includ=
ed
  from /home/zb/alsa/alsa-driver-1.0.17/acore/memory_wrapper.c:26:include=
/linux/mm.h:
   In function 'lowmem_page_address':include/linux/mm.h:538: error: impli=
cit
   declaration of function 'page_to_pfn'/home/zb/alsa/alsa-driver-1.0.17/=
acore/memory_wrapper.c:
   In function 'snd_compat_vmalloc_to_page':/home/zb/alsa/alsa-driver-1.0=
.17/acore/memory_wrapper.c:44:
   error: implicit declaration of function 'VMALLOC_VMADDR'/home/zb/alsa/=
alsa-driver-1.0.17/acore/memory_wrapper.c:50:
   error: implicit declaration of function 'pte_offset'/home/zb/alsa/alsa=
-driver-1.0.17/acore/memory_wrapper.c:50:
   warning: assignment makes pointer from integer without a cast [...]=20

Content analysis details:   (13.3 points, 5.0 required)

 pts rule name              description
---- ---------------------- ---------------------------------------------=
-----
 0.5 PRX_VIDEO              RAW: Video
 2.8 MIME_BASE64_TEXT       RAW: Message text disguised using base64 enco=
ding
  10 PRX_GB2312_CHARSET     GB2312 charset in Content-Type or Subject



------------=_488433A0.6235AFFC
Content-Type: message/rfc822; x-spam-type=original
Content-Description: original message before SpamAssassin
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from alsa0.perex.cz (localhost [127.0.0.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 88A1910385A;
	Mon, 21 Jul 2008 08:58:37 +0200 (CEST)
X-Original-To: alsa-devel@alsa-project.org
Delivered-To: alsa-devel@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 154E9103835; Mon, 21 Jul 2008 04:45:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on mail1.perex.cz
X-Spam-Level: **
X-Spam-Status: No, score=3.0 required=5.0 tests=HTML_MESSAGE,PRX_VIDEO,
	SPF_PASS autolearn=disabled version=3.2.4
Received: from bay0-omc2-s8.bay0.hotmail.com (bay0-omc2-s8.bay0.hotmail.com
	[65.54.246.144]) by alsa0.perex.cz (Postfix) with ESMTP id A1E9D2457A
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 04:45:38 +0200 (CEST)
Received: from BAY113-W13 ([65.54.168.113]) by bay0-omc2-s8.bay0.hotmail.com
	with Microsoft SMTPSVC(6.0.3790.3959);
	Sun, 20 Jul 2008 19:45:37 -0700
Message-ID: <BAY113-W136601538BE1118E16F963CE8A0@phx.gbl>
X-Originating-IP: [221.218.43.175]
From: SunZhibin <zhibins@live.com>
To: <alsa-devel@alsa-project.org>
Date: Mon, 21 Jul 2008 10:45:36 +0800
Importance: Normal
MIME-Version: 1.0
X-OriginalArrivalTime: 21 Jul 2008 02:45:37.0332 (UTC)
	FILETIME=[DB04C740:01C8EADB]
X-Mailman-Approved-At: Mon, 21 Jul 2008 08:58:32 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.9
Subject: [alsa-devel] cross compile errors
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
	http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org

CkhlbGxvLAogCkkgd2FudCB0byBjcm9zcyBjb21waWxlIGFsc2EtZHJpdmVyIGZvciBteSBhcm05
IGN1c3RvbSBib2FyZCAsIHdoZW4gSSBidWlsZCBpdCwgSSBnZXQgdGhlIGZvbGxvd2luZyBlcnJv
cnM6CiAKQ0MgW01dICAvaG9tZS96Yi9hbHNhL2Fsc2EtZHJpdmVyLTEuMC4xNy9hY29yZS9tZW1v
cnlfd3JhcHBlci5vSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC9ob21lL3piL2Fsc2EvYWxzYS1kcml2
ZXItMS4wLjE3L2Fjb3JlL21lbW9yeV93cmFwcGVyLmM6MjU6L2hvbWUvemIvYWxzYS9hbHNhLWRy
aXZlci0xLjAuMTcvaW5jbHVkZS9hZHJpdmVyLmg6ODI4OiBlcnJvcjogc3RhdGljIGRlY2xhcmF0
aW9uIG9mICdqaWZmaWVzX3RvX21zZWNzJyBmb2xsb3dzIG5vbi1zdGF0aWMgZGVjbGFyYXRpb25p
bmNsdWRlL2xpbnV4L2ppZmZpZXMuaDoyNjQ6IGVycm9yOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBv
ZiAnamlmZmllc190b19tc2Vjcycgd2FzIGhlcmUvaG9tZS96Yi9hbHNhL2Fsc2EtZHJpdmVyLTEu
MC4xNy9pbmNsdWRlL2Fkcml2ZXIuaDo4NDc6IGVycm9yOiBzdGF0aWMgZGVjbGFyYXRpb24gb2Yg
J21zZWNzX3RvX2ppZmZpZXMnIGZvbGxvd3Mgbm9uLXN0YXRpYyBkZWNsYXJhdGlvbmluY2x1ZGUv
bGludXgvamlmZmllcy5oOjI2NjogZXJyb3I6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mICdtc2Vj
c190b19qaWZmaWVzJyB3YXMgaGVyZUluIGZpbGUgaW5jbHVkZWQgZnJvbSAvaG9tZS96Yi9hbHNh
L2Fsc2EtZHJpdmVyLTEuMC4xNy9hY29yZS9tZW1vcnlfd3JhcHBlci5jOjI1Oi9ob21lL3piL2Fs
c2EvYWxzYS1kcml2ZXItMS4wLjE3L2luY2x1ZGUvYWRyaXZlci5oOjE1NTI6MTogd2FybmluZzog
InBhZ2VfdG9fcGZuIiByZWRlZmluZWRJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVkZS9hc20v
bWVtb3J5Lmg6MzI5LCAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2FzbS9zeXN0ZW0uaDo2
LCAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L2xpc3QuaDo5LCAgICAgICAgICAg
ICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L21vZHVsZS5oOjksICAgICAgICAgICAgICAgICBmcm9t
IC9ob21lL3piL2Fsc2EvYWxzYS1kcml2ZXItMS4wLjE3L2luY2x1ZGUvYWRyaXZlci5oOjI2LCAg
ICAgICAgICAgICAgICAgZnJvbSAvaG9tZS96Yi9hbHNhL2Fsc2EtZHJpdmVyLTEuMC4xNy9hY29y
ZS9tZW1vcnlfd3JhcHBlci5jOjI1OmluY2x1ZGUvYXNtLWdlbmVyaWMvbWVtb3J5X21vZGVsLmg6
Nzk6MTogd2FybmluZzogdGhpcyBpcyB0aGUgbG9jYXRpb24gb2YgdGhlIHByZXZpb3VzIGRlZmlu
aXRpb25JbiBmaWxlIGluY2x1ZGVkIGZyb20gL2hvbWUvemIvYWxzYS9hbHNhLWRyaXZlci0xLjAu
MTcvYWNvcmUvbWVtb3J5X3dyYXBwZXIuYzoyNjppbmNsdWRlL2xpbnV4L21tLmg6IEluIGZ1bmN0
aW9uICdsb3dtZW1fcGFnZV9hZGRyZXNzJzppbmNsdWRlL2xpbnV4L21tLmg6NTM4OiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3BhZ2VfdG9fcGZuJy9ob21lL3piL2Fs
c2EvYWxzYS1kcml2ZXItMS4wLjE3L2Fjb3JlL21lbW9yeV93cmFwcGVyLmM6IEluIGZ1bmN0aW9u
ICdzbmRfY29tcGF0X3ZtYWxsb2NfdG9fcGFnZSc6L2hvbWUvemIvYWxzYS9hbHNhLWRyaXZlci0x
LjAuMTcvYWNvcmUvbWVtb3J5X3dyYXBwZXIuYzo0NDogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0
aW9uIG9mIGZ1bmN0aW9uICdWTUFMTE9DX1ZNQUREUicvaG9tZS96Yi9hbHNhL2Fsc2EtZHJpdmVy
LTEuMC4xNy9hY29yZS9tZW1vcnlfd3JhcHBlci5jOjUwOiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24gJ3B0ZV9vZmZzZXQnL2hvbWUvemIvYWxzYS9hbHNhLWRyaXZlci0x
LjAuMTcvYWNvcmUvbWVtb3J5X3dyYXBwZXIuYzo1MDogd2FybmluZzogYXNzaWdubWVudCBtYWtl
cyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdAogCiAKIApJIHVzZSB0aGUgZm9s
bG93aW5nIGNvbmZpZ3VyZSBvcHRpb25zOgogCmV4cG9ydCAkUFJFRklYPS9vcHQvYWxzYWV4cG9y
dCBBUkNIPWFybWV4cG9ydCBDUk9TU19DT01QSUxFPS9vcHQvYXJtLWxpbnV4L2Jpbi9hcm0tbGlu
dXgtCi4vY29uZmlndXJlIC0tcHJlZml4PSRQUkVGSVggLS1ob3N0PWFybS1saW51eCAtLWVuYWJs
ZS1zaGFyZWQgLS1lbmFibGUtc3RhdGljIFwgIC0td2l0aC1jcm9zcz0kQ1JPU1NfQ09NUElMRSBc
ICAtLXdpdGgta2VybmVsPS9ob21lL3piL2VtYmVkZGVkL2xpbnV4LTIuNi4yNC43IFwgIC0td2l0
aC1kZWJ1Zz12ZXJib3NlIFwgIC0td2l0aC1pc2FwbnA9bm8gXCAgLS13aXRoLWNhcmRzPXMzYzI0
MTAsc29jLHMzYzI0eHgtc29jLHMzYzI0eHgtc29jLW5lbzE5NzMtd204NzUzLHMzYzI0eHgtc29j
LXNtZGsyNDQzLXdtOTcxMCxzM2MyNHh4LXNvYy1sbjI0NDBzYmMtYWxjNjUwCiAKIApob3cgY2Fu
IGlzIHNvbHZlIHRoaXMgcHJvYmxlbSA/CiAKIApUaGFua3MKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K1eLA77rDtuC6w83m
tcTK08a1o6zTw8rzseq147W9ytPGtb+0v7SjrNPQvqrPsqOhCmh0dHA6Ly9jbndlYi5zZWFyY2gu
bGl2ZS5jb20vdmlkZW8vcmVzdWx0cy5hc3B4P3E9JUU1JUE1JUE1JUU4JUJGJTkwJUU1JTlDJUEz
JUU3JTgxJUFCJm1rdD16aC1jbiZGT1JNPVdMTVRXQwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK

------------=_488433A0.6235AFFC--
