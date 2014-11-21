From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 0/1] Add big-endian DSD sample formats and fix
	XMOS DSD sample format
Date: Fri, 21 Nov 2014 10:57:18 +0200
Message-ID: <1416560239-3859-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id C38B6266D19
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 09:57:29 +0100 (CET)
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
Cc: Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Resend, previous had non matching subject for cover letter vs patch.

This patch fixes XMOS DSD sample format to DSD_U32_BE and also adds
DSD_U16_BE and DSD_U32_BE sample formats.

Jussi Laako (1):
  Add big-endian DSD sample formats and fix XMOS DSD sample format

 include/sound/pcm.h         | 2 ++
 include/uapi/sound/asound.h | 4 +++-
 sound/core/pcm.c            | 2 ++
 sound/core/pcm_misc.c       | 8 ++++++++
 sound/usb/quirks.c          | 4 ++--
 5 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.9.1
