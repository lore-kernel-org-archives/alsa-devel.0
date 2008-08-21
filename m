From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: snd-ad1816a: add different TerraTec
	EWS64 S model.
Date: Thu, 21 Aug 2008 23:10:43 +0200
Message-ID: <48ADD9D3.8090701@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 317EE244D1
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 23:09:28 +0200 (CEST)
Content-Disposition: inline;
	filename*0="0001-ALSA-snd-ad1816a-add-different-TerraTec-EWS64-S-mo.patc";
	filename*1="h"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>From 54bdb84627f9bb4d2d953c7f37553764391c484b Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Thu, 21 Aug 2008 23:07:43 +0200
Subject: [PATCH] ALSA: snd-ad1816a: add different TerraTec EWS64 S model.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/isa/ad1816a/ad1816a.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 68f1260..7752424 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -83,8 +83,10 @@ static struct pnp_card_device_id snd_ad1816a_pnpids[] = {
 	{ .id = "MDK1605", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } } },
 	/* Shark Predator ISA - added by Ken Arromdee */
 	{ .id = "SMM7180", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } } },
-	/* Analog Devices AD1816A - Terratec AudioSystem EWS64S */
+	/* Analog Devices AD1816A - Terratec AudioSystem EWS64 S */
 	{ .id = "TER1112", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } } },
+	/* Analog Devices AD1816A - Terratec AudioSystem EWS64 S */
+	{ .id = "TER1112", .devs = { { .id = "TER1100" }, { .id = "TER1101" } } },
 	/* Analog Devices AD1816A - Terratec Base 64 */
 	{ .id = "TER1411", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } } },
 	/* end */
-- 
1.5.5
