From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 0/2] Mic fixes for Acer AO756 and C7
Date: Sun, 18 Nov 2012 22:56:38 -0800
Message-ID: <1353308200-18944-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f73.google.com (mail-la0-f73.google.com
 [209.85.215.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E13EB2650E3
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 07:56:46 +0100 (CET)
Received: by mail-la0-f73.google.com with SMTP id d3so286308lah.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 22:56:46 -0800 (PST)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The mic sense pin on these systems always indicates mic present if the
combo jack is empty.  The Mic presence must be ignored unless the
Headphone jack is plugged.  To handle this, introduce the concept of a
jack that is gated by the state of another jack.  Does this method seem
reasonable?  Am I missing a better way to handle it?

The second patch also fixes up the pin configs for the A0756 netbook,
the C7 ChromeOS variant doesn't need these but they don't hurt either.

Dylan Reid (2):
  ALSA: hda - Allow jack state to depend on another jack.
  ALSA: hda - Fix Acer Aspire models with analog mics.

 sound/pci/hda/hda_jack.c      | 46 +++++++++++++++++++++++++++++++++++++++++--
 sound/pci/hda/hda_jack.h      |  4 ++++
 sound/pci/hda/patch_realtek.c | 29 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

-- 
1.8.0
