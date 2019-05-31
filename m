From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: trivial conversions to struct_size()
Date: Fri, 31 May 2019 11:53:18 +0200
Message-ID: <20190531095321.16002-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D537F80C1B
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 11:53:25 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 494FFB01F
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 09:53:25 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

there are a few more places that can be better written with
struct_size() macro.  Let's replace them.


Takashi

===

Takashi Iwai (3):
  ALSA: control: Use struct_size()
  ALSA: hda: Use struct_size()
  ALSA: hda/ca0132: Use struct_size()

 sound/core/control.c         | 6 +-----
 sound/pci/hda/hda_codec.c    | 2 +-
 sound/pci/hda/patch_ca0132.c | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.16.4
