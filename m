From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 12/16] ALSA: Oxygen: Modify CS4245 register
	dumping function
Date: Fri, 17 Jan 2014 19:08:31 +0400
Message-ID: <1389971315-3215-12-git-send-email-v1ron@mail.ru>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
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
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

Change the function to read the data from the new
shadow buffer.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index 3f3201e..953ef09 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -625,15 +625,16 @@ static int dg_mixer_init(struct oxygen *chip)
 	return 0;
 }
 
-static void dump_cs4245_registers(struct oxygen *chip,
-				  struct snd_info_buffer *buffer)
+void dump_cs4245_registers(struct oxygen *chip,
+				struct snd_info_buffer *buffer)
 {
 	struct dg *data = chip->model_data;
-	unsigned int i;
+	unsigned int addr;
 
 	snd_iprintf(buffer, "\nCS4245:");
-	for (i = 1; i <= 0x10; ++i)
-		snd_iprintf(buffer, " %02x", data->cs4245_regs[i]);
+	cs4245_read_spi(chip, CS4245_INT_STATUS);
+	for (addr = 1; addr < ARRAY_SIZE(data->cs4245_shadow); addr++)
+		snd_iprintf(buffer, " %02x", data->cs4245_shadow[addr]);
 	snd_iprintf(buffer, "\n");
 }
 
-- 
1.7.10.4
