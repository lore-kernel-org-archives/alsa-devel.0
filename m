From: Dan Carpenter <error27@gmail.com>
Subject: [patch -next] asihpi: testing the wrong variable
Date: Fri, 14 May 2010 16:49:20 +0200
Message-ID: <20100514144920.GC17487@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BC3224575
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 16:49:36 +0200 (CEST)
Received: by wwf26 with SMTP id 26so775743wwf.38
	for <alsa-devel@alsa-project.org>; Fri, 14 May 2010 07:49:35 -0700 (PDT)
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

There is a typo here.  We want to test "*dst" not "dst".

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/pci/asihpi/hpifunc.c b/sound/pci/asihpi/hpifunc.c
index 254c580..15f0c7e 100644
--- a/sound/pci/asihpi/hpifunc.c
+++ b/sound/pci/asihpi/hpifunc.c
@@ -3279,7 +3279,7 @@ static u16 hpi_entity_alloc_and_copy(struct hpi_entity *src,
 
 	buf_size = hpi_entity_size(src);
 	*dst = kmalloc(buf_size, GFP_KERNEL);
-	if (dst == NULL)
+	if (*dst == NULL)
 		return HPI_ERROR_MEMORY_ALLOC;
 	memcpy(*dst, src, buf_size);
 	return 0;
