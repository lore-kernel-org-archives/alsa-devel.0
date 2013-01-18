From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] You guessed it, it's generic parser patches
Date: Fri, 18 Jan 2013 15:43:00 +0100
Message-ID: <1358520183-2908-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 54F9726510F
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 15:43:03 +0100 (CET)
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

The third one seems to apply to the regular sound tree too.

David Henningsson (3):
  ALSA: hda - make sure there are enough input labels and paths
  ALSA: hda - don't compare with yourself in fill_input_pin_labels
  ALSA: hda - Don't add unnecessary indices on HDMI and SPDIF

 sound/pci/hda/hda_auto_parser.c |   22 ++++++++++++----------
 sound/pci/hda/hda_generic.c     |    4 ++--
 sound/pci/hda/hda_generic.h     |    6 +++---
 3 files changed, 17 insertions(+), 15 deletions(-)

-- 
1.7.9.5
