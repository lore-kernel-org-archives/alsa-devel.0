From: linux@audioscience.com
Subject: [[PATCH] snd-asihpi: 1/8] Control naming
Date: Tue, 05 Apr 2011 20:55:41 +1200
Message-ID: <1301993748-21113-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Clock source is neither capture nor playback,
so change 'Capture Clock' to 'Clock'.
Add spaces to control name string for consistency,
always 'PCM 0' , never 'PCM0'

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index f53a31e..edcbe39 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -1413,14 +1413,16 @@ static void asihpi_ctl_init(struct snd_kcontrol_new *snd_control,
 				struct hpi_control *hpi_ctl,
 				char *name)
 {
-	char *dir = "";
+	char *dir;
 	memset(snd_control, 0, sizeof(*snd_control));
 	snd_control->name = hpi_ctl->name;
 	snd_control->private_value = hpi_ctl->h_control;
 	snd_control->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	snd_control->index = 0;
 
-	if (hpi_ctl->dst_node_type + HPI_DESTNODE_NONE == HPI_DESTNODE_ISTREAM)
+	if (hpi_ctl->src_node_type + HPI_SOURCENODE_NONE == HPI_SOURCENODE_CLOCK_SOURCE)
+		dir = ""; /* clock is neither capture nor playback */
+	else if (hpi_ctl->dst_node_type + HPI_DESTNODE_NONE == HPI_DESTNODE_ISTREAM)
 		dir = "Capture ";  /* On or towards a PCM capture destination*/
 	else if ((hpi_ctl->src_node_type + HPI_SOURCENODE_NONE != HPI_SOURCENODE_OSTREAM) &&
 		(!hpi_ctl->dst_node_type))
@@ -1433,7 +1435,7 @@ static void asihpi_ctl_init(struct snd_kcontrol_new *snd_control,
 		dir = "Playback "; /* PCM Playback source, or  output node */
 
 	if (hpi_ctl->src_node_type && hpi_ctl->dst_node_type)
-		sprintf(hpi_ctl->name, "%s%d %s%d %s%s",
+		sprintf(hpi_ctl->name, "%s %d %s %d %s%s",
 			asihpi_src_names[hpi_ctl->src_node_type],
 			hpi_ctl->src_node_index,
 			asihpi_dst_names[hpi_ctl->dst_node_type],
-- 
1.7.0.4
