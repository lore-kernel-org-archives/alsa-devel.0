From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/4] ALSA: Mark expected switch fall-throughs
Date: Thu, 2 Aug 2018 15:40:08 -0500
Message-ID: <cover.1533242152.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to add some annotations in order to mark switch cases where we are
expecting to fall through.

Thanks

Gustavo A. R. Silva (4):
  ALSA: galaxy: Mark expected switch fall-through
  ALSA: opti92x: mark expected switch fall-through
  ALSA: opti9xx: mark expected switch fall-through
  ALSA: es18xx: mark expected switch fall-through

 sound/isa/es18xx.c                 | 1 +
 sound/isa/galaxy/galaxy.c          | 3 +++
 sound/isa/opti9xx/miro.c           | 5 +++++
 sound/isa/opti9xx/opti92x-ad1848.c | 3 +++
 4 files changed, 12 insertions(+)

-- 
2.7.4
