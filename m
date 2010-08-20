From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 1/1] ASoC: clean dead file pxa2xx-pcm.h
Date: Fri, 20 Aug 2010 18:37:23 +0800
Message-ID: <AANLkTimwZUqjROy0POvEgS_XE3V953bzh_+hV8z8=ewz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016367fa53455dab4048e3ee29a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AE875103806
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 12:37:23 +0200 (CEST)
Received: by wyb42 with SMTP id 42so3364295wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 03:37:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0016367fa53455dab4048e3ee29a
Content-Type: text/plain; charset=ISO-8859-1

>From a3d2309c28d502e89997e0cc1ab98f3cacc684df Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Fri, 20 Aug 2010 18:27:41 +0800
Subject: [PATCH 1/1] ASoC: clean dead file pxa2xx-pcm.h

Since pxa2xx-pcm.h is removed from sound/soc/pxa directory, clean it
for passing compilation.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 9c2bafa..ac51c6d 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -24,7 +24,6 @@
 #include <mach/dma.h>
 #include <mach/audio.h>

-#include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"

 static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
-- 
1.5.6.5

--0016367fa53455dab4048e3ee29a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ASoC-clean-dead-file-pxa2xx-pcm.h.patch"
Content-Disposition: attachment;
	filename="0001-ASoC-clean-dead-file-pxa2xx-pcm.h.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd2wgfov0

RnJvbSBhM2QyMzA5YzI4ZDUwMmU4OTk5N2UwY2MxYWI5OGYzY2FjYzY4NGRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjAgQXVnIDIwMTAgMTg6Mjc6NDEgKzA4MDAKU3ViamVjdDogW1BB
VENIIDEvMV0gQVNvQzogY2xlYW4gZGVhZCBmaWxlIHB4YTJ4eC1wY20uaAoKU2luY2UgcHhhMnh4
LXBjbS5oIGlzIHJlbW92ZWQgZnJvbSBzb3VuZC9zb2MvcHhhIGRpcmVjdG9yeSwgY2xlYW4gaXQK
Zm9yIHBhc3NpbmcgY29tcGlsYXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBIYW9qaWFuIFpodWFuZyA8
aGFvamlhbi56aHVhbmdAbWFydmVsbC5jb20+Ci0tLQogc291bmQvc29jL3B4YS9weGEyeHgtYWM5
Ny5jIHwgICAgMSAtCiAxIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvcHhhL3B4YTJ4eC1hYzk3LmMgYi9zb3VuZC9z
b2MvcHhhL3B4YTJ4eC1hYzk3LmMKaW5kZXggOWMyYmFmYS4uYWM1MWM2ZCAxMDA2NDQKLS0tIGEv
c291bmQvc29jL3B4YS9weGEyeHgtYWM5Ny5jCisrKyBiL3NvdW5kL3NvYy9weGEvcHhhMnh4LWFj
OTcuYwpAQCAtMjQsNyArMjQsNiBAQAogI2luY2x1ZGUgPG1hY2gvZG1hLmg+CiAjaW5jbHVkZSA8
bWFjaC9hdWRpby5oPgogCi0jaW5jbHVkZSAicHhhMnh4LXBjbS5oIgogI2luY2x1ZGUgInB4YTJ4
eC1hYzk3LmgiCiAKIHN0YXRpYyB2b2lkIHB4YTJ4eF9hYzk3X3dhcm1fcmVzZXQoc3RydWN0IHNu
ZF9hYzk3ICphYzk3KQotLSAKMS41LjYuNQoK
--0016367fa53455dab4048e3ee29a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016367fa53455dab4048e3ee29a--
