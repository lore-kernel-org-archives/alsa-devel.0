From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 00/12] pcm: hw: optimization for
	v2.0.14 of PCM protocol/interface
Date: Fri, 30 Jun 2017 08:58:16 +0900
Message-ID: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 1A6242673F6
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:32 +0200 (CEST)
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

This patchset is an optimization for version 2.0.14 of ALSA PCM
protocol/interface.

In this version, for some devices/drivers, applications are disallowed
to map control data of runtime of PCM substream. On the other hand,
mapping status data is still available.

In current implementation of alsa-lib, execution of ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR is still done without enough care of the
change. For example, even if status data is successfully mapped,
the ioctl is executed to query the status data. This is inefficient.

This patchset is to arrange the execution.

Takashi Sakamoto (12):
  pcm: hw: fix to initialize function local variable
  pcm: hw: add a helper function just to query status/control data of
    PCM substream
  pcm: hw: use heler function to query status/control data after
    reading/writing PCM frames
  pcm: hw: use helper function to query status/control data after
    HW_PARAMS call
  pcm: hw: use helper function to query status/control data after
    PREPARE/RESET call
  pcm: hw: use helper function to query status/control data after
    REWIND/FORWARD call
  pcm: hw: use helper function to query status/control data for
    calculation of available space on PCM buffer
  pcm: hw: add a helper function to request hwsync without side-effects
  pcm: hw: add a helper function to issue appl_ptr without sub-effects
  pcm: hw: add a helper function to issue avail_min without sub-effects
  pcm: hw: remove superfluous code to call of SNDRV_PCM_IOCTL_SYNC_PTR
    in snd_pcm_hw_forward()
  pcm: hw: minor refactoring for initialization of control data

 src/pcm/pcm_hw.c | 109 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 34 deletions(-)

-- 
2.11.0
