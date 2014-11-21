From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 0/1] Fix DSD sample format endianess and add
	big-endian format
Date: Fri, 21 Nov 2014 10:53:43 +0200
Message-ID: <1416560024-3672-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ED31266BC5
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 09:53:52 +0100 (CET)
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

This patch adds big-endian DSD sample format and fixes return value of DSD
formats for snd_pcm_format_little_endian().

Jussi Laako (1):
  Fix DSD sample format endianess and add big-endian format

 include/pcm.h          |  6 +++++-
 include/sound/asound.h |  4 +++-
 src/pcm/pcm.c          |  4 ++++
 src/pcm/pcm_misc.c     | 17 ++++++++++++++---
 4 files changed, 26 insertions(+), 5 deletions(-)

-- 
1.9.1
