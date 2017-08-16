From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/3] ALSA: make snd_kcontrol_new const
Date: Wed, 16 Aug 2017 14:14:08 +0530
Message-ID: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E2A1266B2C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 10:44:24 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 83so4744315pgb.4
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 01:44:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, johannes@sipsolutions.net, perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these structures const. Done using Coccinelle.

Bhumika Goyal (3):
  ALSA: aoa: make snd_kcontrol_new const
  ALSA: pcxhr: make snd_kcontrol_new const
  ALSA: hda: make snd_kcontrol_new const

 sound/aoa/codecs/onyx.c        | 12 ++++++------
 sound/pci/hda/patch_analog.c   |  4 ++--
 sound/pci/hda/patch_sigmatel.c |  2 +-
 sound/pci/pcxhr/pcxhr_mixer.c  |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.9.1
