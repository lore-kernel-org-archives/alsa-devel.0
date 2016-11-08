From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Harden proc interface
Date: Tue,  8 Nov 2016 15:18:54 +0100
Message-ID: <20161108141856.12283-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 08BAC2667CC
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 15:18:59 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9A033ABCD
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 14:18:58 +0000 (UTC)
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

here is a small patch series to harden the accesses to ALSA proc
files.  Both are marked with v4.2+ stable, just because they are
cleanly applicable since that version due to the code rewrite at 4.2.


Takashi

===

Takashi Iwai (2):
  ALSA: info: Limit the proc text input size
  ALSA: info: Return error for invalid read/write

 sound/core/info.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.10.2
