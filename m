From: vanyacpp@gmail.com
Subject: [PATCH - my module 1/1] control_hw: fix potential
	memory leak
Date: Wed, 22 Jan 2014 00:12:50 +0400
Message-ID: <52ded2de.463f700a.68c2.ffffb186@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Ivan Sorokin <vanyacpp@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Ivan Sorokin <vanyacpp@gmail.com>


Signed-off-by: Ivan Sorokin <vanyacpp@gmail.com>

diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index 148097f..dfc9dcd 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -240,8 +240,10 @@ static int snd_ctl_hw_elem_tlv(snd_ctl_t *handle, int op_flag,
 		return -errno;
 	}
 	if (op_flag == 0) {
-		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size)
+		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size) {
+			free(xtlv);
 			return -EFAULT;
+		}
 		memcpy(tlv, xtlv->tlv, xtlv->tlv[1] + 2 * sizeof(unsigned int));
 	}
 	free(xtlv);
-- 
1.8.1.2
