From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: pcm:
Date: Fri,  9 Jun 2017 09:34:37 +0900
Message-ID: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E75532674BA
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 02:34:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is a revised version of my former RFC.


[alsa-devel] [PATCH RFC 00/21] ALSA: pcm: add tracepoints for PCM params operation
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120548.html

In ALSA PCM interface, applications can get hardware capability as
'struct snd_pcm_hw_params' type of data returned by a call of ioctl(2)
with SNDRV_PCM_IOCTL_HW_REFINE/SNDRV_PCM_IOCTL_HW_PARAMS' commands.
Results of these commands should be the same in a certain conditions but
actually it's not.

This is a part of layout of the structure.

struct snd_pcm_hw_params {
    ...
    unsigned int info;
    unsigned int msbits;
    unsigned int rate_num;
    unsigned int rate_den;
    snd_pcm_uframes_t fifo_size;
    ...
};

For example, although the 'msbits', 'rate_num' and 'rate_den' fields are
filled in a result of HW_REFINE command conditionally, they're never
filled in a result of HW_PARAMS command. This seems a bug.

This patchset attempts to fix the bug. This affects userspace applications
in cotents of the result, but it's acceptrable with a merit for the
applications to get enough parameters.

Takashi Sakamoto (3):
  ALSA: pcm: use helper functions to refer parameters as constants
  ALSA: pcm: calculate non-mask/non-interval parameters always when
    possible
  ALSA: pcm: move fixup of info flag after selecting single parameters

 sound/core/pcm_native.c | 88 +++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 35 deletions(-)

-- 
2.11.0
