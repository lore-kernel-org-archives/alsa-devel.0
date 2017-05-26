From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: pcm: add local header for
	module-local functions
Date: Fri, 26 May 2017 09:30:45 +0900
Message-ID: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 1D8262673E2
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 02:30:52 +0200 (CEST)
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

This patchset is a supplement for merged patchset[1].

As I suggested[2], an added helper function is useful to some parts of PCM
core module. Although it's better to replace existent code block with it,
there's an issue to share it with several objects, because there is no
header files for external symbols not exported to kernel space.

This patchset adds a header file for the module-local symbols, then
adds calls of the function in several parts of the module.

[1] [alsa-devel] [PATCH 0/7] ALSA: Fix/improve PCM ack callback
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120886.html
[2] [alsa-devel] [PATCH 0/7] ALSA: Fix/improve PCM ack callback
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120910.html

Takashi Sakamoto (2):
  ALSA: pcm: add local header file for snd-pcm module
  ALSA: pcm: add arrangement for applying appl_ptr

 include/sound/pcm.h     | 32 -----------------------------
 sound/core/pcm.c        |  2 ++
 sound/core/pcm_lib.c    | 14 +++++++------
 sound/core/pcm_local.h  | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 sound/core/pcm_misc.c   |  3 +++
 sound/core/pcm_native.c | 13 +++++++-----
 6 files changed, 75 insertions(+), 43 deletions(-)
 create mode 100644 sound/core/pcm_local.h

-- 
2.11.0
