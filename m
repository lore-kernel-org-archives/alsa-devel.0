From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: timer: fix another ioctl compatibility
	bug
Date: Sat, 19 Mar 2016 22:58:20 +0900
Message-ID: <1458395901-2223-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id DB6AC2614BB
 for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2016 14:58:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In ALSA timer interface, I found another compatibility bug to different
ABIs. This patch is to fix it. I note that the bug is in really,
really-minor functionality and no drivers use it, therefore it has little
impact to this subsystem. This patch is just for manners between
kernel/userspace interfaces.


To check the compatibility, I wrote a series of easy and small programs for
each ALSA interface. It's available in my repository on github.
https://github.com/takaswie/alsa-ioctl-test

As long as I tested with these programs, this patch is the last fix for
the compatibility issues which comes from differences of data model. On
the other hand, I confirmed that each compatibility layer is not fully
compatible to core implementation. For example, ioctl() with
SNDRV_PCM_IOCTL_WRITEI_FRAMES and argument filled by zero for PCM capture
character device (not for playback device) returns different error codes
for each of x86/x86_64 binary. I think this should be fixed, but don't
start to work for it yet.


Regards

Takashi Sakamoto (1):
  ALSA: timer: fix ioctl compatibility for different data models

 sound/core/timer_compat.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.7.3
