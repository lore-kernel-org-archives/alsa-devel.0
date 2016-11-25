From: sutar.mounesh@gmail.com
Subject: [PATCH] alsa-lib: update linked hw_ptr and appl_ptr
Date: Fri, 25 Nov 2016 15:55:05 +0530
Message-ID: <1480069505-16668-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

Plugin file provides no private hw_ptr and appl_ptr but instead links them to the slave pcm.
If the slave pcm itself changes its hw_ptr or app_prt this needs to be done in file plugin, too.
Plugin 'plug' is such a candidate changing the hw_ptr and app_ptr in hw_params call dependent on the automatically inserted plugins.
ALSA unfortunately has no support for automatically updating chained pointers.
A notification on pointer change seems to be prepared inside the snd_pcm_set_ptr() routine via
rbptr->changed(), but it is not (yet) implemented so that we need to care for it manually.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
---
 src/pcm/pcm_file.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index fec76eb..1e3d35b 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -634,6 +634,14 @@ static int snd_pcm_file_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 			return err;
 		}
 	}
+
+	/* pointer may have changed - e.g if plug is used. */
+	snd_pcm_unlink_hw_ptr(pcm, file->gen.slave);
+	snd_pcm_unlink_appl_ptr(pcm, file->gen.slave);
+
+	snd_pcm_link_hw_ptr(pcm, file->gen.slave);
+	snd_pcm_link_appl_ptr(pcm, file->gen.slave);
+
 	return 0;
 }
 
-- 
1.7.9.5
