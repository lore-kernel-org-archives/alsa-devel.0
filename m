From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] ALSA: some race fixes
Date: Tue, 16 Apr 2019 17:21:01 +0200
Message-ID: <20190416152103.6189-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41090F89614
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 17:21:05 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DE7FCAE5D
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 15:21:04 +0000 (UTC)
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

syzkaller hilariously spotted some possible races via its usb
fuzzing.  I thought it were specific to USB-audio stuff, but no it's
in the ALSA core side.  So below is the resultant fixes.


Takashi

===

Takashi Iwai (2):
  ALSA: info: Fix racy addition/deletion of nodes
  ALSA: core: Fix card races between register and disconnect

 sound/core/info.c | 12 ++++++++++--
 sound/core/init.c | 18 +++++++++---------
 2 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.16.4
