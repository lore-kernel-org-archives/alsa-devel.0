From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 00/21] ALSA: pcm: add tracepoints for PCM
	params operation
Date: Sun, 14 May 2017 17:57:35 +0900
Message-ID: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 17E32266851
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In the last Audio Mini Conference held with Linux Plumber conference 2016[1], I mentioned about tracepoints for PCM params operation. This patchset is for the idea.

In ALSA PCM interface, applications can get hardware capability by ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE/SNDRV_PCM_IOCT_HW_PARAMS in a shape of 'struct snd_pcm_hw_params'. In kernel side, relevant processing is somewhat complicated and developers sometimes have hard time to debug drivers for PCM constraints and rules.

This patchset adds tracepoints for hw_params operations. When CONFIG_SND_DEBUG is enabled, you can see 'trace_hw_params_mask/trace_hw_params_interval' events of 'snd_pcm' subsystem. When applications execute ioctl(2) with SNDRV_PCM_IOCTL_HW_REFINE/SNDRV_PCM_IOCTL_HW_PARAMS, these events are probed. Developers can get how many PCM rules are added into runtime of PCM substream and which rule changed which parameters.

This patchset also includes some improvements. The last three commits brings small changes to kernel/userspace interface for error handling.

I'm happy to receive your comment for this patchset. For your information, low level application of SNDRV_PCM_IOCTL_HW_REFINE operation is available in my github repository[2].


[1] You can see minutes.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/114279.html
[2] refine-pcm-param.c
https://github.com/takaswie/alsa-ioctl-test

Takashi Sakamoto (21):
  ALSA: pcm: add a helper function to constrain mask-type parameters
  ALSA: pcm: add a helper function to constrain interval-type parameters
  ALSA: pcm: add a helper function to apply parameter rules
  ALSA: pcm: tracepoints for refining PCM parameters
  ALSA: pcm: enable parameter tracepoints at CONFIG_SND_DEBUG only
  ALSA: pcm: use goto statement instead of while statement to reduce
    indentation
  ALSA: pcm: remove function local variable with alternative evaluation
  ALSA: pcm: adaption of code formatting
  ALSA: pcm: add comment about application of rule to PCM parameters
  ALSA: pcm: constify function local and read-only table
  ALSA: pcm: localize snd_pcm_hw_params_choose()
  ALSA: pcm: add tracepoints for selection process of hardware
    parameters at SNDRV_PCM_IOCTL_HW_PARAMS
  ALSA: pcm: use helper functions to check whether parameters are
    determined
  ALSA: pcm: use helper function to refer parameter as read-only
  ALSA: pcm: add const qualifier for read-only table for sampling rate
  ALSA: pcm/oss: refer to parameters instead of copying to reduce usage
    of kernel stack
  ALSA: pcm: check type of parameter in added rule
  ALSA: pcm: calculate non-mask/non-interval parameters always when
    possible
  ALSA: pcm: move fixup of info flag after selecting single parameters
  ALSA: pcm: return error immediately for parameters refinement
  ALSA: pcm: return error immediately at refine ioctl

 include/sound/pcm.h           |   1 -
 sound/core/Makefile           |   1 +
 sound/core/oss/pcm_oss.c      |  20 +-
 sound/core/oss/pcm_plugin.c   |   5 +-
 sound/core/oss/pcm_plugin.h   |   2 +-
 sound/core/pcm_drm_eld.c      |   8 +-
 sound/core/pcm_lib.c          |  55 +----
 sound/core/pcm_native.c       | 485 ++++++++++++++++++++++++++++--------------
 sound/core/pcm_params_trace.h | 142 +++++++++++++
 9 files changed, 494 insertions(+), 225 deletions(-)
 create mode 100644 sound/core/pcm_params_trace.h

-- 
2.9.3
