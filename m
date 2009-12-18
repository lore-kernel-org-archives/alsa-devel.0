From: Zerg Cannibal <cnb_zerg@yahoo.com>
Subject: [PATCH 1/1] alsa-lib softvol S24_3LE distrotion fix
Date: Fri, 18 Dec 2009 09:03:33 -0800 (PST)
Message-ID: <896914.42199.qm@web56103.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n6.bullet.mail.ac4.yahoo.com (n6.bullet.mail.ac4.yahoo.com
	[76.13.13.234]) by alsa0.perex.cz (Postfix) with SMTP id 091972438E
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 18:03:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Summary: Fix the sound distortions for S24_3LE stream in alsa-lib softvol.

This patch fixes sound distortions in alsa-lib "softvol" for S24_3LE sound stream, when softvol slider isn't at 0.0dB position.



Signed-off-by: CannibalZerg <cnb_zerg@yahoo.com>
---
src/pcm/pcm_softvol.c | 22 ++++++++++++++++++++--
1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 637e5cb..2c7c006 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -107,7 +107,8 @@ static inline int MULTI_DIV_32x16(int a, unsigned short b)
v.i = a;
y.i = 0;
#if __BYTE_ORDER == __LITTLE_ENDIAN
- x.i = (unsigned int)v.s[0] * b;
+ x.i = (unsigned short)v.s[0];
+ x.i *= b;
y.s[0] = x.s[1];
y.i += (int)v.s[1] * b;
#else
@@ -135,6 +136,23 @@ static inline int MULTI_DIV_int(int a, unsigned int b, int swap)
return swap ? (int)bswap_32(fraction) : fraction;
}

+/* always little endian */
+static inline int MULTI_DIV_24(int a, unsigned int b)
+{
+ unsigned int gain = b >> VOL_SCALE_SHIFT;
+ int fraction;
+ fraction = MULTI_DIV_32x16(a, b & VOL_SCALE_MASK);
+ if (gain) {
+ long long amp = (long long)a * gain + fraction;
+ if (amp > (int)0x7fffff)
+ amp = (int)0x7fffff;
+ else if (amp < (int)0x800000)
+ amp = (int)0x800000;
+ return (int)amp;
+ }
+ return fraction;
+}
+
static inline short MULTI_DIV_short(short a, unsigned int b, int swap)
{
unsigned int gain = b >> VOL_SCALE_SHIFT;
@@ -223,7 +241,7 @@ static inline short MULTI_DIV_short(short a, unsigned int b, int swap)
tmp = src[0] | \
(src[1] << 8) | \
(((signed char *) src)[2] << 16); \
- tmp = MULTI_DIV_int(tmp, vol_scale, 0); \
+ tmp = MULTI_DIV_24(tmp, vol_scale); \
dst[0] = tmp; \
dst[1] = tmp >> 8; \
dst[2] = tmp >> 16; \
-- 1.6.5.6 
