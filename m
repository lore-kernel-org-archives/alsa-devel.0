From: Guillaume Blanc <guillaume.blanc@parrot.com>
Subject: Bad header guard in alsa-lib
Date: Fri, 6 Jul 2018 13:54:07 +0000
Message-ID: <DB5PR10MB0293F65AACE42CF971B1AE2094470@DB5PR10MB0293.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_DB5PR10MB0293F65AACE42CF971B1AE2094470DB5PR10MB0293EURP_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30072.outbound.protection.outlook.com [40.107.3.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 29B072673C7
 for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2018 15:54:10 +0200 (CEST)
Content-Language: fr-FR
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_DB5PR10MB0293F65AACE42CF971B1AE2094470DB5PR10MB0293EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,
While building alsa-lib, I got a redefinition error caused by a bad header =
guard in pcm_plugin.h.
I assume this is a mistake and not a weird include trick, attached is a pat=
ch to fix this.
Best regards,
Guillaume Blanc=

--_002_DB5PR10MB0293F65AACE42CF971B1AE2094470DB5PR10MB0293EURP_
Content-Type: text/x-patch; name="0001-Fix-header-guard-in-pcm_plugin.h.patch"
Content-Description: 0001-Fix-header-guard-in-pcm_plugin.h.patch
Content-Disposition: attachment;
	filename="0001-Fix-header-guard-in-pcm_plugin.h.patch"; size=566;
	creation-date="Fri, 06 Jul 2018 13:39:01 GMT";
	modification-date="Fri, 06 Jul 2018 13:39:01 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4ZTY0M2I3ZTAwNzA3NDgwN2I4M2YyN2Q4OGQwMmVhMzY3ZDJjM2I3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHdWlsbGF1bWUgQmxhbmMgPGd1aWxsYXVtZS5ibGFuY0BwYXJy
b3QuY29tPgpEYXRlOiBGcmksIDYgSnVsIDIwMTggMTU6MjI6MDYgKzAyMDAKU3ViamVjdDogW1BB
VENIIC0gYWxzYS1saWIgMS8xXSBGaXggaGVhZGVyIGd1YXJkIGluIHBjbV9wbHVnaW4uaAoKU2ln
bmVkLW9mZi1ieTogR3VpbGxhdW1lIEJsYW5jIDxndWlsbGF1bWUuYmxhbmNAcGFycm90LmNvbT4K
CmRpZmYgLS1naXQgYS9pbmNsdWRlL3BjbV9wbHVnaW4uaCBiL2luY2x1ZGUvcGNtX3BsdWdpbi5o
CmluZGV4IGFkMTRlN2IuLjMwNjEyMDUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcGNtX3BsdWdpbi5o
CisrKyBiL2luY2x1ZGUvcGNtX3BsdWdpbi5oCkBAIC0zMCw2ICszMCw3IEBACiAgKi8KIAogI2lm
bmRlZiBfX0FMU0FfUENNX1BMVUdJTl9ICisjZGVmaW5lIF9fQUxTQV9QQ01fUExVR0lOX0gKIAog
LyoqCiAgKiBcZGVmZ3JvdXAgUENNX1BsdWdpbnMgUENNIFBsdWdpbnMKLS0gCjEuOS4xCgo=

--_002_DB5PR10MB0293F65AACE42CF971B1AE2094470DB5PR10MB0293EURP_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_DB5PR10MB0293F65AACE42CF971B1AE2094470DB5PR10MB0293EURP_--
