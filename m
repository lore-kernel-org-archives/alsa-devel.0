From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [patch] ALSA: asihpi: fix an information leak in asihpi_hpi_ioctl()
Date: Wed, 31 Dec 2014 19:26:51 +1300
Message-ID: <54A3972B.5010703@blennerhassett.gen.nz>
References: <20141222074946.GA9737@mwanda> <s5hmw6ais9g.wl-tiwai@suse.de> <54A25D49.4000502@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <54A25D49.4000502@blennerhassett.gen.nz>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add missing limits to keep copied data within allocated buffer.

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/hpi6000.c | 6 +++++-
 sound/pci/asihpi/hpioctl.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index e0c6715..794df30 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -46,6 +46,7 @@
 
 /* operational/messaging errors */
 #define HPI6000_ERROR_MSG_RESP_IDLE_TIMEOUT		901
+#define HPI6000_ERROR_RESP_GET_LEN			902
 #define HPI6000_ERROR_MSG_RESP_GET_RESP_ACK		903
 #define HPI6000_ERROR_MSG_GET_ADR			904
 #define HPI6000_ERROR_RESP_GET_ADR			905
@@ -1363,7 +1364,10 @@ static short hpi6000_message_response_sequence(struct hpi_adapter_obj *pao,
 		length = hpi_read_word(pdo, HPI_HIF_ADDR(length));
 	} while (hpi6000_check_PCI2040_error_flag(pao, H6READ) && --timeout);
 	if (!timeout)
-		length = sizeof(struct hpi_response);
+		return HPI6000_ERROR_RESP_GET_LEN;
+
+	if (length > phr->size)
+		return HPI_ERROR_RESPONSE_BUFFER_TOO_SMALL;
 
 	/* get the response */
 	p_data = (u32 *)phr;
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 6aa677e..72af66b 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -153,6 +153,8 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		goto out;
 	}
 
+	res_max_size = min_t(size_t, res_max_size, sizeof(*hr));
+
 	switch (hm->h.function) {
 	case HPI_SUBSYS_CREATE_ADAPTER:
 	case HPI_ADAPTER_DELETE:
-- 
1.9.1


