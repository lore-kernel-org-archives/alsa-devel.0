From: eliot@blennerhassett.gen.nz
Subject: [PATCH 00/10] ALSA: asihpi: updates
Date: Thu, 20 Nov 2014 16:22:47 +1300
Message-ID: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id F3ED5265849
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:23:24 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp4.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB00JRJIPPDX50@smtp4.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:23:22 +1300 (NZDT)
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Major change - Add support for interrupt driven 'low latency' mode
PCM streams on some AudioScience adapters.

Various other minor updates from AudioScience

Eliot Blennerhassett (10):
  ALSA: asihpi: Minor string and dead code cleanup
  ALSA: asihpi: New I/O types - AVB & BLUlink, DAB Rf receiver
  ALSA: asihpi: Logging format improvements
  ALSA: asihpi: Use CONFIG_64BIT directly
  ALSA: asihpi: Refactor control cache code.
  ALSA: asihpi: Add support for stream interrupt.
  ALSA: asihpi: Turn off msg/resp logging after DSP has crashed.
  ALSA: asihpi: Use standard printk helpers
  ALSA: asihpi: don't fail probe if adapter mode read fails
  ALSA: asihpi: used parts of message/response are zeroed before use

 sound/pci/asihpi/asihpi.c       | 326 +++++++++++++++++++++++++++-------------
 sound/pci/asihpi/hpi.h          |  16 +-
 sound/pci/asihpi/hpi6205.c      |  43 +++++-
 sound/pci/asihpi/hpi_internal.h |  20 ++-
 sound/pci/asihpi/hpicmn.c       | 107 +++++++------
 sound/pci/asihpi/hpicmn.h       |  19 ++-
 sound/pci/asihpi/hpimsginit.c   |  30 ++--
 sound/pci/asihpi/hpimsgx.c      |  15 +-
 sound/pci/asihpi/hpioctl.c      | 123 +++++++++++++--
 sound/pci/asihpi/hpios.h        |   8 +-
 10 files changed, 508 insertions(+), 199 deletions(-)

-- 
1.9.1
