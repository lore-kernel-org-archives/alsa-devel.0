From: Dan Carpenter <error27@gmail.com>
Subject: [patch -next] sound/asihpi: incorrect range check
Date: Fri, 14 May 2010 16:50:05 +0200
Message-ID: <20100514145005.GD17487@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F1E324576
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 16:50:19 +0200 (CEST)
Received: by wwf26 with SMTP id 26so776302wwf.38
	for <alsa-devel@alsa-project.org>; Fri, 14 May 2010 07:50:19 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The entity_type_to_size[] array has LAST_ENTITY_TYPE (11) number of elements,
not LAST_ENTITY_ROLE (17).  This only affects the debug output.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/pci/asihpi/hpifunc.c b/sound/pci/asihpi/hpifunc.c
index 254c580..eda26b3 100644
--- a/sound/pci/asihpi/hpifunc.c
+++ b/sound/pci/asihpi/hpifunc.c
@@ -3407,7 +3407,7 @@ u16 hpi_entity_alloc_and_pack(const enum e_entity_type type,
 	if (hE)
 		return hE;
 
-	HPI_DEBUG_ASSERT(role > entity_role_null && type < LAST_ENTITY_ROLE);
+	HPI_DEBUG_ASSERT(role > entity_role_null && type < LAST_ENTITY_TYPE);
 
 	bytes_to_copy = entity_type_to_size[type] * item_count;
 	total_size = hpi_entity_header_size(*entity) + bytes_to_copy;
