From: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Subject: [PATCH] alsa-utils rpm spec update
Date: Thu, 6 Mar 2003 13:29:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303061326570.24704-200000@bladlus.ii.uib.no>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-198984259-1046953768=:24704"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-198984259-1046953768=:24704
Content-Type: TEXT/PLAIN; charset=US-ASCII

Cleanup the alsa-utils rpm spec:
 * removed wrongly included doc file
 * changed BuildRoot from /var/tmp to %{_tmppath}
 * use standard rpm macros for %build & %install
 * updated dependencies

-- 
Ronny V. Vindenes <sublett@dc-s.com>

--8323328-198984259-1046953768=:24704
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-utils.spec.in.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0303061329280.24704@bladlus.ii.uib.no>
Content-Description: 
Content-Disposition: attachment; filename="alsa-utils.spec.in.patch"

LS0tIC90bXAvYWxzYS11dGlscy5zcGVjLmluCTIwMDMtMDMtMDUgMjM6NTQ6
MzQuMDAwMDAwMDAwICswMTAwDQorKysgYWxzYS11dGlscy5zcGVjLmluCTIw
MDMtMDMtMDYgMDA6MTI6MDkuMDAwMDAwMDAwICswMTAwDQpAQCAtOCwxNSAr
OCwyMiBAQA0KIENvcHlyaWdodDogR1BMDQogR3JvdXA6IFN5c3RlbS9MaWJy
YXJpZXMNCiBTb3VyY2U6IGZ0cDovL2Z0cC5hbHNhLXByb2plY3Qub3JnL3B1
Yi91dGlscy9hbHNhLXV0aWxzLSV7dmVyfS50YXIuYnoyDQotQnVpbGRSb290
OiAvdmFyL3RtcC9hbHNhLXV0aWxzLSV7dmVyfQ0KK0J1aWxkUm9vdDogJXtf
dG1wcGF0aH0vJXtuYW1lfS0le3ZlcnNpb259LXJvb3QNCiBVUkw6IGh0dHA6
Ly93d3cuYWxzYS1wcm9qZWN0Lm9yZw0KLVJlcXVpcmVzOiBhbHNhLWxpYiBh
bHNhLWRyaXZlcg0KK1JlcXVpcmVzOiBhbHNhLWxpYiBuY3Vyc2VzDQorQnVp
bGRSZXF1aXJlczogYWxzYS1saWItZGV2ZWwgbmN1cnNlcy1kZXZlbA0KIA0K
ICVkZXNjcmlwdGlvbg0KIA0KIEFkdmFuY2VkIExpbnV4IFNvdW5kIEFyY2hp
dGVjdHVyZSAoQUxTQSkgLSBVdGlscw0KIA0KICVjaGFuZ2Vsb2cNCisqIFRo
dSBNYXIgIDYgMjAwMyBSb25ueSBWLiBWaW5kZW5lcyA8c3VibGV0dEBkYy1z
LmNvbT4NCisNCistIHJlbW92ZWQgd3JvbmdseSBpbmNsdWRlZCBkb2MgZmls
ZQ0KKy0gY2hhbmdlZCBCdWlsZFJvb3QgZnJvbSAvdmFyL3RtcCB0byAle190
bXBwYXRofQ0KKy0gdXNlIHN0YW5kYXJkIHJwbSBtYWNyb3MgZm9yICVidWls
ZCAmICVpbnN0YWxsDQorLSB1cGRhdGVkIGRlcGVuZGVuY2llcw0KIA0KICog
VHVlIE5vdiAyMCAyMDAxIEphcm9zbGF2IEt5c2VsYSA8cGVyZXhAc3VzZS5j
ej4NCiANCkBAIC0zNiwyNCArNDMsMjAgQEANCiAlcHJlcA0KICVzZXR1cA0K
ICVidWlsZA0KLQ0KLS4vY29uZmlndXJlIC0tcHJlZml4PSVfcHJlZml4IC0t
bWFuZGlyPSVfbWFuZGlyDQorJWNvbmZpZ3VyZQ0KIG1ha2UNCiANCiAlaW5z
dGFsbA0KLVsgLW4gIiRSUE1fQlVJTERfUk9PVCIgLWEgIiRSUE1fQlVJTERf
Uk9PVCIgIT0gLyBdICYmIHJtIC1yZiAkUlBNX0JVSUxEX1JPT1QNCi0NCi1t
a2RpciAtcCAkUlBNX0JVSUxEX1JPT1QvJV9wcmVmaXgvYmluICRSUE1fQlVJ
TERfUk9PVC8lX21hbmRpci9tYW4xDQotDQotbWFrZSBERVNURElSPSIkUlBN
X0JVSUxEX1JPT1QiIGluc3RhbGwNCitbICIkUlBNX0JVSUxEX1JPT1QiICE9
ICIvIiBdICYmIHJtIC1yZiAkUlBNX0JVSUxEX1JPT1QNCislbWFrZWluc3Rh
bGwNCiANCiAlY2xlYW4NCi1bIC1uICIkUlBNX0JVSUxEX1JPT1QiIC1hICIk
UlBNX0JVSUxEX1JPT1QiICE9IC8gXSAmJiBybSAtcmYgJFJQTV9CVUlMRF9S
T09UDQorWyAiJFJQTV9CVUlMRF9ST09UIiAhPSAiLyIgXSAmJiBybSAtcmYg
JFJQTV9CVUlMRF9ST09UDQogDQogJWZpbGVzDQogJWRlZmF0dHIoLSwgcm9v
dCwgcm9vdCkNCiANCi0lZG9jIENoYW5nZUxvZyBDT1BZSU5HIFJFQURNRSBj
b25maWcuc3RhdHVzDQorJWRvYyBDaGFuZ2VMb2cgQ09QWUlORyBSRUFETUUN
CiANCiAle19wcmVmaXh9L3NiaW4vKg0KICV7X3ByZWZpeH0vYmluLyoNCg==
--8323328-198984259-1046953768=:24704--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
