From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/2] Add snd_card_disconnect_sync() helper
Date: Wed, 11 Oct 2017 12:16:16 +0200
Message-ID: <20171011101618.8736-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EAB50266F1D
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 12:16:26 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a refreshed series containing ALSA core changes Morimoto-san
posted.  Basically the code is same but it's split, and more comments
and an error message are added.  I tested lightly with the existing
hot-pluggable device and no regression was seen.

The commits are found in topic/card-disconnect branch of sound git
tree, too.  Mark, please pull it to yours when applying the further
patches relying on this new helper function.


thanks,

Takashi

===

Takashi Iwai (2):
  ALSA: add snd_card_disconnect_sync()
  ALSA: pcm: Forcibly stop at disconnect callback

 include/sound/core.h |  2 ++
 sound/core/init.c    | 32 ++++++++++++++++++++++++++++++++
 sound/core/pcm.c     |  4 ++++
 3 files changed, 38 insertions(+)

-- 
2.14.2
