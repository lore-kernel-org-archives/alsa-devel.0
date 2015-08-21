From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hdsp: silence and underflow warning
Date: Fri, 21 Aug 2015 14:25:34 +0300
Message-ID: <20150821112534.GA983@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I believe this probably cannot happen, as the code suggests.  There
would have to be an kcontrol->index.id which was zero, otherwise this
would be prevented in snd_ctl_find_id().  But snd_BUG_ON() is just a
WARN() or a no-op so static checkers complain that we keep on going with
a negative offset.  Let's just handle the error as well as printing
a warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index c19e021..468a95c 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -2806,7 +2806,8 @@ static int snd_hdsp_get_adat_sync_check(struct snd_kcontrol *kcontrol, struct sn
 	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
 
 	offset = ucontrol->id.index - 1;
-	snd_BUG_ON(offset < 0);
+	if (snd_BUG_ON(offset < 0))
+		return -EINVAL;
 
 	switch (hdsp->io_type) {
 	case Digiface:
