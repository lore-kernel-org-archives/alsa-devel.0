From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 0/2] Sony vaio pro 13 (haswell)
Date: Fri, 11 Oct 2013 10:18:44 +0200
Message-ID: <1381479526-3766-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8756F265652
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 10:18:48 +0200 (CEST)
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

Changes since v1:

 - Mic patch now applies to linux-stable branch linux-3.11.y cleanly
 - The two patches are now not connected to each other. I'll send a patch
   that connects them if/when we get some confirmation that this actually is
   a working headset mic pin.

David Henningsson (2):
  ALSA: hda - Fix microphone for Sony VAIO Pro 13 (Haswell model)
  ALSA: hda - Add a headset mic model for ALC269 and friends

 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_realtek.c                |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
1.7.9.5
