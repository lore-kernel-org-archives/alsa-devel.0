From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 0/5] Add devres support to card resources
Date: Thu, 13 Sep 2018 08:05:22 +0200
Message-ID: <20180913060527.24694-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F2C292676EB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 08:05:31 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D7A2DAFE2
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 06:05:30 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

the devres or device-managed resource allocation is a popular method
among many drivers but we didn't have such a mechanism for the core
sound card objects.  Here is an attempt to implement that.

The first patch gives the devm-version of page allocator helper, and
the second patch provides the devm-version of snd_card_new().
The rest patches are examples of the new API usages.

As of now, this patch series is still an RFC.  The usefulness of this
is still unclear, but I believe this can be used in all legacy ALSA
drivers pretty well.  For ASoC, this would help very little,
supposedly, though.

The latest patches are found in topic/devres branch of my sound.git
tree, too.


thanks,

Takashi

===

Takashi Iwai (5):
  ALSA: core: Add device-managed page allocator helper
  ALSA: core: Add managed card creation
  ALSA: intel8x0: Allocate resources with device-managed APIs
  ALSA: atiixp: Allocate resources with device-managed APIs
  ALSA: hda: Allocate resources with device-managed APIs

 include/sound/core.h           |   5 ++
 include/sound/memalloc.h       |   4 +
 sound/core/init.c              |  95 +++++++++++++++++++++-
 sound/core/memalloc.c          |  88 +++++++++++++++-----
 sound/pci/atiixp.c             | 104 +++++++-----------------
 sound/pci/atiixp_modem.c       | 104 +++++++-----------------
 sound/pci/hda/hda_controller.h |   1 -
 sound/pci/hda/hda_intel.c      |  43 +++-------
 sound/pci/intel8x0.c           | 143 +++++++++++----------------------
 sound/pci/intel8x0m.c          | 143 +++++++++++----------------------
 10 files changed, 332 insertions(+), 398 deletions(-)

-- 
2.18.0
