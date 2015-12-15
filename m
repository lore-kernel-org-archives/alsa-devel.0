From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Yet more noise fixes for Thinkpad
Date: Tue, 15 Dec 2015 15:14:07 +0100
Message-ID: <1450188850-22441-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A5EB261B21
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 15:14:10 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 52BBEADAC
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 14:14:10 +0000 (UTC)
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

here is a series of small patches to reduce still existing crackling
noises on Thinkpad with Realtek codecs.

Takashi Iwai (3):
  ALSA: hda - Apply click noise workaround for Thinkpads generically
  ALSA: hda - Set codec to D3 at reboot/shutdown on Thinkpads
  ALSA: hda - Add a fixup for Thinkpad X1 Carbon 2nd

 sound/pci/hda/patch_realtek.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

-- 
2.6.4
