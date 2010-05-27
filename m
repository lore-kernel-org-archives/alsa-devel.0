From: linux@audioscience.com
Subject: [PATCH 4/5] Fix bug preventing outstream_write preload
 from happening. Add support for new ASI8800 family.
Date: Thu, 27 May 2010 17:53:54 +1200
Message-ID: <1274939635-1370-4-git-send-email-linux@audioscience.com>
References: <1274939635-1370-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1274939635-1370-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6205.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 5e88c1f..e89991e 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -966,23 +966,16 @@ static void outstream_write(struct hpi_adapter_obj *pao,
 	status = &interface->outstream_host_buffer_status[phm->obj_index];
 
 	if (phw->flag_outstream_just_reset[phm->obj_index]) {
-		/* Format can only change after reset. Must tell DSP. */
-		u16 function = phm->function;
-		phw->flag_outstream_just_reset[phm->obj_index] = 0;
-		phm->function = HPI_OSTREAM_SET_FORMAT;
-		hw_message(pao, phm, phr);	/* send the format to the DSP */
-		phm->function = function;
-		if (phr->error)
-			return;
-	}
-#if 1
-	if (phw->flag_outstream_just_reset[phm->obj_index]) {
 		/* First OutStremWrite() call following reset will write data to the
-		   adapter's buffers, reducing delay before stream can start
+		   adapter's buffers, reducing delay before stream can start. The DSP
+		   takes care of setting the stream data format using format information
+		   embedded in phm.
 		 */
 		int partial_write = 0;
 		unsigned int original_size = 0;
 
+		phw->flag_outstream_just_reset[phm->obj_index] = 0;
+
 		/* Send the first buffer to the DSP the old way. */
 		/* Limit size of first transfer - */
 		/* expect that this will not usually be triggered. */
@@ -1012,7 +1005,6 @@ static void outstream_write(struct hpi_adapter_obj *pao,
 			original_size - HPI6205_SIZEOF_DATA;
 		phm->u.d.u.data.pb_data += HPI6205_SIZEOF_DATA;
 	}
-#endif
 
 	space_available = outstream_get_space_available(status);
 	if (space_available < (long)phm->u.d.u.data.data_size) {
@@ -1369,6 +1361,9 @@ static u16 adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 	case HPI_ADAPTER_FAMILY_ASI(0x6500):
 		firmware_id = HPI_ADAPTER_FAMILY_ASI(0x6600);
 		break;
+	case HPI_ADAPTER_FAMILY_ASI(0x8800):
+		firmware_id = HPI_ADAPTER_FAMILY_ASI(0x8900);
+		break;
 	}
 	boot_code_id[1] = firmware_id;
 
-- 
1.7.0.4
