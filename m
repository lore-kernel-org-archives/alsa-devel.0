From: sutar.mounesh@gmail.com
Subject: [PATCH 5/6] pcm:extplug: refinement of masks in extplug
Date: Fri, 17 Feb 2017 12:47:49 +0530
Message-ID: <1487315869-9119-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: Mounesh Sutar <sutar.mounesh@gmail.com>, alsa-devel@alsa-project.org, Awais Belal <awais_belal@mentor.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Awais Belal <awais_belal@mentor.com>

It should be possible to use empty mask format with extplug.
The refinement of mask via extplug is now modified,
to accept empty masks as well to work properly.

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_extplug.c b/src/pcm/pcm_extplug.c
index a04f826..1004f54 100644
--- a/src/pcm/pcm_extplug.c
+++ b/src/pcm/pcm_extplug.c
@@ -172,6 +172,8 @@ int snd_ext_parm_mask_refine(snd_mask_t *mask, struct snd_ext_parm *parm, int ty
 	unsigned int i;
 
 	parm += type;
+	if (!parm->active)
+		return 0;
 	memset(&bits, 0, sizeof(bits));
 	for (i = 0; i < parm->num_list; i++)
 		bits.bits[parm->list[i] / 32] |= 1U << (parm->list[i] % 32);
-- 
2.7.4
