From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 2/4] Alsa: control: increment index field for
	duplicated control.
Date: Tue, 8 Nov 2016 09:11:13 +0100
Message-ID: <1478592675-23092-3-git-send-email-arnaud.pouliquen@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D91C8266ED4
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 09:13:11 +0100 (CET)
In-Reply-To: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Instead of returning an error when a control is already present, the
index field is incremented and a warning message is printed.
This allows drivers to instanciate same control without
device and sub device number management ( MIXER type controls).

Change-Id: Ifcc60dca9d1cf4c3a424bb9653296678aa7953cb
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/core/control.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index fb096cb..014e3f4 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -365,6 +365,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	struct snd_ctl_elem_id id;
 	unsigned int idx;
 	unsigned int count;
+	struct snd_kcontrol *elem_set;
 	int err = -EINVAL;
 
 	if (! kcontrol)
@@ -376,17 +377,24 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 		goto error;
 
 	down_write(&card->controls_rwsem);
-	if (snd_ctl_find_id(card, &id)) {
-		up_write(&card->controls_rwsem);
-		dev_err(card->dev, "control %i:%i:%i:%s:%i is already present\n",
-					id.iface,
-					id.device,
-					id.subdevice,
-					id.name,
-					id.index);
-		err = -EBUSY;
-		goto error;
+	while (elem_set = snd_ctl_find_id(card, &id)) {
+		id.index++;
+		if (id.index > UINT_MAX - kcontrol->count) {
+			up_write(&card->controls_rwsem);
+			dev_err(card->dev, "no more free index for control %i:%i:%i:%s\n",
+				id.iface, id.device, id.subdevice, id.name);
+			err = -ENOSPC;
+			goto error;
+		}
+	}
+	if (kcontrol->id.index != id.index) {
+		dev_warn(card->dev, "control %i:%i:%i:%s:%i is already present\n",
+			 id.iface, id.device, id.subdevice, id.name, id.index);
+		dev_warn(card->dev, "control index updated from %i to %i\n",
+			 kcontrol->id.index, id.index);
+		kcontrol->id.index = id.index;
 	}
+
 	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
 		up_write(&card->controls_rwsem);
 		err = -ENOMEM;
-- 
1.9.1
