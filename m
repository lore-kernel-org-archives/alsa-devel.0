From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] Headphone Mic patches
Date: Thu, 11 Apr 2013 11:30:27 +0200
Message-ID: <1365672630-15411-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B32266016
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 11:30:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I'm preparing upstreaming of some new hardware, which has headphone mic support,
i e, you can use the headphone jack to plug in a TRS/TS mic instead of plugging in
a headphone in that jack.

For this hardware, the existing hp_mic functionality won't work as the headphone and
mic are on different pins.

David Henningsson (3):
  ALSA: hda - allow "Headphone Mic" parser flag
  ALSA: hda - add some small convenience functions to auto parser
  ALSA: hda - Handle Headphone Mic jack more generic

 sound/pci/hda/hda_auto_parser.c |   68 ++++++++++++++++++++++++++++++++-------
 sound/pci/hda/hda_auto_parser.h |   29 +++++++++++++++--
 sound/pci/hda/hda_generic.c     |   12 +------
 sound/pci/hda/hda_jack.c        |   43 +++++++++++++++++--------
 4 files changed, 113 insertions(+), 39 deletions(-)

-- 
1.7.9.5
