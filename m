From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/4] constify ac97_pcm structures
Date: Wed, 23 Aug 2017 17:39:24 +0530
Message-ID: <1503490168-26501-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F60A2664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 14:09:47 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id k3so1297536pfc.2
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 05:09:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux@armlinux.org.uk, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

ac97_pcm are not supposed to change at runtime. All functions
working with ac97_pcm provided by <sound/ac97_codec.h> work with
const ac97_pcm. So mark the non-const structs as const.

Arvind Yadav (4):
  [PATCH 1/4] ALSA: aaci: constify ac97_pcm structures
  [PATCH 2/4] ALSA: ac97c: constify ac97_pcm structures
  [PATCH 3/4] ALSA: atiixp: constify ac97_pcm structures
  [PATCH 4/4] ALSA: intel8x0: constify ac97_pcm structures

 sound/arm/aaci.c     | 2 +-
 sound/atmel/ac97c.c  | 2 +-
 sound/pci/atiixp.c   | 2 +-
 sound/pci/intel8x0.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
