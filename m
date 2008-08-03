From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: snd-cs4236: add Techmakers MF-4236PW PnP
	card ID
Date: Mon, 04 Aug 2008 01:38:21 +0200
Message-ID: <4896416D.8050705@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id C37C82433E
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 01:38:23 +0200 (CEST)
Content-Disposition: inline;
	filename*0="0001-ALSA-snd-cs4236-add-Techmakers-MF-4236PW-PnP-card.patch"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>From a4137cd967830051d51c376a78149f089334158f Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Mon, 4 Aug 2008 01:23:43 +0200
Subject: [PATCH] ALSA: snd-cs4236: add Techmakers MF-4236PW PnP card ID

Add the Techmakers MF-4236PW (Crystal CX4236B-XQ3) PnP card ID.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/isa/cs423x/cs4236.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index dbe63db..860e90d 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -239,6 +239,8 @@ static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 	{ .id = "CSC9836", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
 	/* Gallant SC-70P */
 	{ .id = "CSC9837", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
+	/* Techmakers MF-4236PW */
+	{ .id = "CSCa736", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
 	/* TerraTec AudioSystem EWS64XL - CS4236B */
 	{ .id = "CSCa836", .devs = { { "CSCa800" }, { "CSCa810" }, { "CSCa803" } } },
 	/* TerraTec AudioSystem EWS64XL - CS4236B */
-- 
1.5.5
