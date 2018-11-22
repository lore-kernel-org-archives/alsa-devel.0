From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] ALSA: control: Race fix and cleanup for
	user ctls
Date: Thu, 22 Nov 2018 17:10:32 +0100
Message-ID: <20181122161034.30212-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46C64267929
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 17:10:41 +0100 (CET)
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

there seems a possible race between addition and removal of a user ctl
element as spotted by syzkaller.  This patchset addresses it and also
provides a cleanup thereafter.  The first one should go to 4.20 while
the second one should go for 4.21.


Takashi

===

Takashi Iwai (2):
  ALSA: control: Fix race between adding and removing a user element
  ALSA: control: Consolidate helpers for adding and replacing ctl
    elements

 sound/core/control.c | 171 ++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 90 deletions(-)

-- 
2.19.1
