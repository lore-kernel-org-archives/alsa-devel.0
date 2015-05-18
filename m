From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Fixes and cleanups for the recent procfs
	changes
Date: Mon, 18 May 2015 09:57:00 +0200
Message-ID: <1431935824-8670-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 303982604CE
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 09:57:07 +0200 (CEST)
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
Cc: libin.yang@intel.com, han.lu@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

here is a series of patches to fix and clean up the recent changes
for ALSA core procfs support code.


Takashi

===

Takashi Iwai (4):
  ALSA: info: Fix leaks of child entries at snd_info_free_entry()
  ALSA: info: Register proc entries recursively, too
  ALSA: info: Move list addition to snd_info_create_entry()
  ALSA: info: Drop kerneldoc comment from snd_info_create_entry()

 sound/core/info.c | 62 +++++++++++++++++++++++++++++++++++++++++--------------
 sound/core/init.c | 18 ++++++----------
 2 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.3.6
