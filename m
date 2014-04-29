From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCHv2 0/2] fm801: small clean up series
Date: Tue, 29 Apr 2014 10:56:02 +0300
Message-ID: <1398758165-15671-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
 [195.197.172.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 608DF261B18
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 09:55:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org

Two patches in the series are targeting to clean up a bit fm801 driver.

Changes since v1:
 - remove inline from helper function definitions
 - fix rebase issue that led to wrong logic
 - rename helper function to be more particular
 - reorder parameters in the hw accessor macros

Andy Shevchenko (2):
  fm801: introduce macros to access the hardware
  fm801: introduce fm801_ac97_is_ready()/fm801_ac97_is_valid() helpers

 sound/pci/fm801.c | 200 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 105 insertions(+), 95 deletions(-)

-- 
1.8.3.101.g727a46b
