From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: take cmd_mutex in probe_codec()
Date: Sat, 1 Aug 2009 18:46:46 +0800
Message-ID: <20090801104646.GA3978@localhost>
References: <20090801104516.GA3741@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id E34EC24397
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 12:46:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090801104516.GA3741@localhost>
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
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <jkysela@redhat.com>
List-Id: alsa-devel@alsa-project.org

Now that each codec will have its own module, it is possible
for the user to load one codec while another one is running.

So cmd_mutex would be a safe addition to probe_codec().

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_intel.c |    2 ++
 1 file changed, 2 insertions(+)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -1282,10 +1282,12 @@ static int probe_codec(struct azx *chip,
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res;
 
+	mutex_lock(&chip->bus->cmd_mutex);
 	chip->probing = 1;
 	azx_send_cmd(chip->bus, cmd);
 	res = azx_get_response(chip->bus, addr);
 	chip->probing = 0;
+	mutex_unlock(&chip->bus->cmd_mutex);
 	if (res == -1)
 		return -EIO;
 	snd_printdd(SFX "codec #%d probed OK\n", addr);
