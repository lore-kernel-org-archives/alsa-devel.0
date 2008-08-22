From: linux@audioscience.com
Subject: [PATCH - asihpi 5/6] Avoid null pointer dereference.
Date: Fri, 22 Aug 2008 17:26:32 +1200
Message-ID: <1219382793-21272-2-git-send-email-linux@audioscience.com>
References: <1219382793-21272-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1219382793-21272-1-git-send-email-linux@audioscience.com>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index daa359d..1654070 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -2126,6 +2126,9 @@ static short Hpi6205_TransferData(
 	u32 dwTimeOut, dwTemp2;
 	struct bus_master_interface *interface = pHw6205->pInterfaceBuffer;
 
+	if (!pData)
+		return HPI_ERROR_INVALID_DATA_TRANSFER;
+
 	dwDataSize &= ~3L;	/* round dwDataSize down to nearest 4 bytes */
 
 	/* make sure state is IDLE */
-- 
1.5.4.3
