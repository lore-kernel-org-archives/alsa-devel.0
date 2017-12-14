From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [alsa-lib][PATCH v3 0/4] add SNDRV_PCM_FORMAT_{S, U}20
Date: Thu, 14 Dec 2017 14:50:49 +0100
Message-ID: <4937250f-311b-ab79-dacd-6980ffdb2145@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D78D267AB0
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 14:50:51 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

This format is similar to an existing 20-bit PCM format
SNDRV_PCM_FORMAT_{S,U}20_3, however it occupies 4 bytes instead of 3.

Changes from v1: Split the monolithic submission into separate
commits. (Note that v2 wasn't tagged as such.)

Changes from v2: Add commas at the end of two possible last entries of
the snd_pcm_format_t enum so diffs will be more readable when new PCM
formats are added in the future, remove asserts from
snd_pcm_linear_{get,put}_index().

Maciej S. Szmigiero (4):
  asound.h: add SNDRV_PCM_FORMAT_{S,U}20
  pcm: add and describe SND_PCM_FORMAT_{S,U}20
  pcm: linear, route: handle linear formats with 20-bit sample on 4
    bytes
  pcm: plug: add SND_PCM_FORMAT_{S,U}20 to linear_preferred_formats

 include/pcm.h          | 20 ++++++++++++++++++--
 include/sound/asound.h |  9 +++++++++
 src/pcm/pcm.c          | 10 ++++++++++
 src/pcm/pcm_linear.c   | 14 +++++++++++---
 src/pcm/pcm_local.h    |  4 ++++
 src/pcm/pcm_misc.c     | 41 ++++++++++++++++++++++++++++++++++++++---
 src/pcm/pcm_plug.c     | 11 +++++++++++
 src/pcm/pcm_route.c    |  6 ++++--
 src/pcm/plugin_ops.h   | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 9 files changed, 151 insertions(+), 14 deletions(-)
