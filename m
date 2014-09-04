From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/4] Fixup hda-emu so David's test suite does
	not fail
Date: Thu,  4 Sep 2014 16:21:22 +0200
Message-ID: <1409840486-14961-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 541C026561A
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 16:21:23 +0200 (CEST)
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

So; from what I can see, all newly discovered errors looked like errors
in hda-emu rather than errors in the codec. But I don't mind having a
second confirmation on that, because I'm not totally sure.

With these patches, my test suite is again back to 0 errors. :-)

David Henningsson (4):
  hda-emu: Enable CONFIG_SND_DYNAMIC_MINORS
  hda-emu: Add verbs for old Nvidia HDMI 8ch 7x
  hda-emu: Allow some more codec IDs to use ATI HDMI special verbs
  hda-emu/tester: Fix calculation of machines

 hda-spec.c             | 17 +++++++++++++++++
 include/codec_config.h |  2 ++
 tester/summary.py      |  4 +++-
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
1.9.1
