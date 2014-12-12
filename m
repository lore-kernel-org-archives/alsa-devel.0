From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] ALSA: oxfw: fix detect_loud_models()
	return value
Date: Fri, 12 Dec 2014 22:28:10 +0300
Message-ID: <20141212192810.GB22234@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id ED9BD261489
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 20:28:10 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

This code causes a static checker warning:

	sound/firewire/oxfw/oxfw.c:46 detect_loud_models()
	warn: signedness bug returning '(-2)'

The detect_loud_models() function should return false on falure, so that
we don't try to set up the loud code for hardware that doesn't support
it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index cf1d0b5..60e5cad 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -43,7 +43,7 @@ static bool detect_loud_models(struct fw_unit *unit)
 	err = fw_csr_string(unit->directory, CSR_MODEL,
 			    model, sizeof(model));
 	if (err < 0)
-		return err;
+		return false;
 
 	for (i = 0; i < ARRAY_SIZE(models); i++) {
 		if (strcmp(models[i], model) == 0)
