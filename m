From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/5] hda-emu: Test all codecs,
	not just the first one
Date: Thu,  4 Sep 2014 14:21:02 +0200
Message-ID: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D92E2658A3
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 14:21:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I've improved my test suite to test all the codecs of an alsa-info file,
instead of just testing the first one.

However, this means that some errors started to show up in my test
suite again, so it also means more work to do...but hopefully it's all
leading better quality HDA driver in the end!

David Henningsson (5):
  hda-emu: Deal with two cards with one codec each
  hda-emu: Quit early if requested codec index is above limit
  hda-emu: Improve error message for modem codecs
  hda-emu/tester: Add codec index parameter to hda-emu-tester
  hda-emu/tester: Test all codecs, not just one

 hda-parse.c              | 29 +++++++++++++++-------
 tester/hda-emu-tester.py |  2 ++
 tester/runner.py         | 14 +++++++++--
 tester/summary.py        | 62 ++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 83 insertions(+), 24 deletions(-)

-- 
1.9.1
