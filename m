From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 2/2] [resend #2] ns558: Add Rockwell WaveArtist
	gameport ID
Date: Mon, 24 Aug 2015 21:50:16 +0200
Message-ID: <1440445816-28593-2-git-send-email-linux@rainbow-software.org>
References: <1440445816-28593-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gsystem.sk (ns.gsystem.sk [62.176.172.50])
 by alsa0.perex.cz (Postfix) with ESMTP id DEDC426145A
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 21:50:26 +0200 (CEST)
In-Reply-To: <1440445816-28593-1-git-send-email-linux@rainbow-software.org>
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
Cc: Takashi Iwai <tiwai@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Add support for gameport on Rockwell WaveArtist based sound cards.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/input/gameport/ns558.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
index 7c21784..b86c4c8 100644
--- a/drivers/input/gameport/ns558.c
+++ b/drivers/input/gameport/ns558.c
@@ -189,6 +189,7 @@ static const struct pnp_device_id pnp_devids[] = {
 	{ .id = "YMH0006", .driver_data = 0 }, /* Opl3-SA */
 	{ .id = "YMH0022", .driver_data = 0 }, /* Opl3-SAx */
 	{ .id = "PNPb02f", .driver_data = 0 }, /* Generic */
+	{ .id = "RSS5004", .driver_data = 0 }, /* Rockwell WaveArtist */
 	{ .id = "", },
 };
 
-- 
Ondrej Zary
