From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] control core refactoring
Date: Fri, 10 Apr 2015 08:42:59 +0900
Message-ID: <1428622981-9747-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1428512108-1852-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A4B782605BD
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 01:43:08 +0200 (CEST)
In-Reply-To: <1428512108-1852-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patchset is revised version of my previous one.

[alsa-devel] [PATCH 0/2 RFC] control core refactoring
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-April/090202.html

Changes:
 - 1/2 patch:
  * nothing
 - 2/2 patch:
  * use ssize_t instead of size_t as original code uses.
  * use goto statement to gather unlocking codes in the end of the function.

Takashi Sakamoto (2):
  ALSA: ctl: evaluate macro instead of numerical value
  ALSA: ctl: refactoring for read operation

 sound/core/control.c | 90 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 35 deletions(-)

-- 
2.1.0
