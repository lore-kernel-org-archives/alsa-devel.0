From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 2/2] ns558: Add Rockwell WaveArtist gameport ID
Date: Sun,  8 Mar 2015 18:05:14 +0100
Message-ID: <1425834314-11787-2-git-send-email-linux@rainbow-software.org>
References: <1425834314-11787-1-git-send-email-linux@rainbow-software.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425834314-11787-1-git-send-email-linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Kernel development list <linux-kernel@vger.kernel.org>
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
