From: Tanu Kaskinen <tanuk@iki.fi>
Subject: [PATCH alsa-plugins] pph: include config.h from
	rate_speexrate.c
Date: Wed, 27 Jan 2016 13:45:51 +0200
Message-ID: <1453895151-15293-1-git-send-email-tanuk@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 5A935260439
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 12:45:59 +0100 (CET)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 955392CE9C
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 06:45:58 -0500 (EST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fixes compilation against libspeexdsp 1.2rc3.

rate_speexrate.c includes speex_resampler.h, which depends on config.h
by referencing the HAVE_SPEEX_SPEEXDSP_TYPES_H macro. AFAIK it's not
a good idea to include config.h from headers (I don't know/remember
why, though), which is why I include config.h from rate_speexrate.c
instead of speex_resampler.h.

Signed-off-by: Tanu Kaskinen <tanuk@iki.fi>
---
 pph/rate_speexrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pph/rate_speexrate.c b/pph/rate_speexrate.c
index 0a1325c..8fc4cef 100644
--- a/pph/rate_speexrate.c
+++ b/pph/rate_speexrate.c
@@ -28,6 +28,7 @@
    POSSIBILITY OF SUCH DAMAGE.
 */
 
+#include "config.h"
 #include <stdio.h>
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_rate.h>
-- 
2.7.0.rc3
