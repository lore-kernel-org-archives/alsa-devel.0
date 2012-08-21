From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/5] hda-emu: Add playback/capture test to test
	suite
Date: Tue, 21 Aug 2012 10:53:58 +0200
Message-ID: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BAD5265B66
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 10:54:10 +0200 (CEST)
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

When I added those tests, I did not discover anything that needed
to be fixed in the driver code, but there were some additional things in
hda-emu to fix up.

David Henningsson (5):
  hda-emu: Store pointers to pcm streams instead of their content
  hda-emu: Add support for get/set converter channel count
  hda-emu: Add CX20585 to modem whitelist
  hda-emu: Add playback/capture test to test suite
  hda-emu: improve test suite summary script

 hda-emu.c           |   24 ++++++++++++------------
 hda-int.c           |   15 +++++++++++++++
 hda-parse.c         |    1 +
 include/hda-types.h |    1 +
 tester/runall.sh    |    3 ---
 tester/runner.py    |   25 ++++++++++++++++++++++---
 tester/summary.py   |    9 +++++++++
 7 files changed, 60 insertions(+), 18 deletions(-)
 delete mode 100755 tester/runall.sh

-- 
1.7.9.5
