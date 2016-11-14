From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Trivial kernel-doc fixes
Date: Mon, 14 Nov 2016 22:30:02 +0100
Message-ID: <20161114213005.22443-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D5FA266F05
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 22:30:10 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 83ABBABF9
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 21:30:10 +0000 (UTC)
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

this is a short series of patches to fix trivial kernel-doc warnings
and errors.


Takashi

===

Takashi Iwai (3):
  ALSA: ac97: Fix kernel-doc error with sphinx formatter
  ALSA: compress: Fix kernel-doc warnings
  ALSA: core: Fix kernel-doc warnings

 include/sound/compress_driver.h |  1 +
 include/sound/core.h            | 20 ++++++++++----------
 sound/pci/ac97/ac97_codec.c     |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.10.2
