From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH RESEND 00/11] ALSA: vsnd: Add Xen
	para-virtualized frontend driver
Date: Mon,  7 Aug 2017 14:50:34 +0300
Message-ID: <1502106645-6731-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C977A2669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 13:50:53 +0200 (CEST)
Received: by mail-lf0-f47.google.com with SMTP id g25so891731lfh.1
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 04:50:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This patch series adds support for Xen [1] para-virtualized
sound frontend driver. It implements the protocol from
include/xen/interface/io/sndif.h with the following limitations:
- mute/unmute is not supported
- get/set volume is not supported
Volume control is not supported for the reason that most of the
use-cases (at the moment) are based on scenarious where
unprivileged OS (e.g. Android, AGL etc) use software mixers.

Both capture and playback are supported.

Thank you,
Oleksandr

Resending because of rebase onto [2]

[1] https://xenproject.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=for-next

Oleksandr Andrushchenko (11):
  ALSA: vsnd: Implement driver's probe/remove
  ALSA: vsnd: Implement Xen bus state handling
  ALSA: vsnd: Read sound driver configuration from Xen store
  ALSA: vsnd: Implement Xen event channel handling
  ALSA: vsnd: Implement handling of shared buffers
  ALSA: vsnd: Introduce ALSA virtual sound driver
  ALSA: vsnd: Initialize virtul sound card
  ALSA: vsnd: Add timer for period interrupt emulation
  ALSA: vsnd: Implement ALSA PCM operations
  ALSA: vsnd: Implement communication with backend
  ALSA: vsnd: Introduce Kconfig option to enable Xen PV sound

 sound/drivers/Kconfig     |   12 +
 sound/drivers/Makefile    |    2 +
 sound/drivers/xen-front.c | 2029 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 2043 insertions(+)

-- 
2.7.4
