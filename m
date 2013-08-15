From: jiashuo.kang@gmail.com
Subject: [PATCH] Update iatomic.h functions definitions for mips
Date: Thu, 15 Aug 2013 17:17:19 +0800
Message-ID: <1376558239-21720-1-git-send-email-jiashuo.kang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 by alsa0.perex.cz (Postfix) with ESMTP id B4342261281
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 11:17:42 +0200 (CEST)
Received: by mail-pa0-f67.google.com with SMTP id bg4so315949pad.6
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 02:17:40 -0700 (PDT)
Received: from pek-kkang-d1.wrs.com ([1.202.252.122])
 by mx.google.com with ESMTPSA id dg3sm55709282pbc.24.2013.08.15.02.17.37
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 15 Aug 2013 02:17:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Kai Kang <jiashuo.kang at gmail.com>

Functions atomic_add(s) and atomic_sub(s) are defined with 'extern
__inline__' that may cause compile fails when cross compile for mips.
The error message looks like:

| pcm/.libs/libpcm.a(pcm_meter.o): In function `snd_pcm_meter_update_scope':
| .../alsa-lib-1.0.27.2/src/pcm/pcm_meter.c:139: undefined reference to `atomic_sub'

Replace the 'extern __inline__' with 'static __inline__' to fix this
issue.

Signed-off-by: Kai Kang <jiashuo.kang at gmail.com>
---
 include/iatomic.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/iatomic.h b/include/iatomic.h
index 5711fe8..2393297 100644
--- a/include/iatomic.h
+++ b/include/iatomic.h
@@ -720,7 +720,7 @@ typedef struct { volatile int counter; } atomic_t;
  * Atomically adds @i to @v.  Note that the guaranteed useful range
  * of an atomic_t is only 24 bits.
  */
-extern __inline__ void atomic_add(int i, atomic_t * v)
+static __inline__ void atomic_add(int i, atomic_t * v)
 {
 	unsigned long temp;
 
@@ -744,7 +744,7 @@ extern __inline__ void atomic_add(int i, atomic_t * v)
  * Atomically subtracts @i from @v.  Note that the guaranteed
  * useful range of an atomic_t is only 24 bits.
  */
-extern __inline__ void atomic_sub(int i, atomic_t * v)
+static __inline__ void atomic_sub(int i, atomic_t * v)
 {
 	unsigned long temp;
 
@@ -763,7 +763,7 @@ extern __inline__ void atomic_sub(int i, atomic_t * v)
 /*
  * Same as above, but return the result value
  */
-extern __inline__ int atomic_add_return(int i, atomic_t * v)
+static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
 	unsigned long temp, result;
 
@@ -784,7 +784,7 @@ extern __inline__ int atomic_add_return(int i, atomic_t * v)
 	return result;
 }
 
-extern __inline__ int atomic_sub_return(int i, atomic_t * v)
+static __inline__ int atomic_sub_return(int i, atomic_t * v)
 {
 	unsigned long temp, result;
 
-- 
1.8.1.2
