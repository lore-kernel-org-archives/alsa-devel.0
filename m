From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: pcm: add tracepoints for PCM params
	refinement
Date: Wed,  7 Jun 2017 08:46:42 +0900
Message-ID: <20170606234645.13775-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id F0FE3267059
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 01:46:50 +0200 (CEST)
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

This patchset is a part of my previous RFC and go for upstream.
[alsa-devel] [PATCH RFC 00/21] ALSA: pcm: add tracepoints for PCM params operation
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120548.html

In ALSA PCM interface, applications can get hardware capability by ioctl(2)
with SNDRV_PCM_IOCTL_HW_REFINE/SNDRV_PCM_IOCT_HW_PARAMS in a shape of
'struct snd_pcm_hw_params'. In kernel side, relevant processing is somewhat
complicated and developers sometimes have hard time to debug drivers for PCM
constraints and rules. This patchset adds tracepoints to assist their work.

Changes:
 - change print format
 - rename events
 - refactoring in the RFC will be done in my later work.


This patchset adds two events; 'hw_interval_param' and 'hw_mask_param' in
'snd_pcm' subsystem. When these events are probed, tracer outputs below
lines:

hw_interval_param: 0,0,0,0 000/023 BUFFER_SIZE 0 0 [0 4294967295] 0 1 [0 4294967295]
hw_interval_param: 0,0,0,0 000/023 BUFFER_BYTES 0 0 [0 4294967295] 0 1 [128 65536]
hw_interval_param: 0,0,0,0 000/023 TICK_TIME 0 0 [0 4294967295] 0 0 [0 4294967295]
hw_mask_param:     0,0,0,0 001/023 FORMAT 00000000000000000000001000000044 00000000000000000000001000000044
hw_interval_param: 0,0,0,0 002/023 SAMPLE_BITS 0 1 [0 4294967295] 0 1 [16 32]
hw_interval_param: 0,0,0,0 003/023 SAMPLE_BITS 0 1 [16 32] 0 1 [16 32]

The first field represents PCM character device and subdevice for probed
runtime of PCM substream. In the above case, '/dev/snd/pcmC0D0p' and
first subdevice are used for runtime of PCM substream.

The second field represents id of each rule applied to the runtime, and
the total number of rules added to the runtime. Basically, when the rule
is applied to the runtime, these events are probed, but lines with id 0
are exceptions. They're application of constraints to the runtime.

The third field is name of parameter in the runtime. The rest fields
depends on type of the parameter (mask/interval).


In ALSA PCM core, runtimes get 22 (or 21) rules as a default. In a below
sample, the 21st rule is added by driver (snd-soc-imx-ssi.ko). The rest is
added by snd-pcm.ko. In detail, please see 'snd_pcm_hw_constraints_init()'
and 'snd_pcm_hw_constraints_complete()' in 'sound/core/pcm_native.c'.

hw_interval_param: 0,0,0,0 019/023 PERIOD_TIME 0 0 [0 4294967295] 0 0 (166 4095875]
hw_interval_param: 0,0,0,0 020/023 BUFFER_TIME 0 0 [0 4294967295] 0 0 (333 4096000]
hw_interval_param: 0,0,0,0 021/023 PERIOD_SIZE 0 1 [16 32767] 0 1 [16 32766]
hw_interval_param: 0,0,0,0 022/023 BUFFER_BYTES 0 1 [128 65536] 0 1 [128 65536]
hw_interval_param: 0,0,0,0 023/023 RATE 0 0 [8000 96000] 0 0 [8000 96000]
hw_mask_param:     0,0,0,0 001/023 FORMAT 00000000000000000000001000000044 00000000000000000000001000000044


As I noted in second patch, this patchset increases size of relocatable
object. In general, kernel configuration for tracepoints should govern
whether the features are enbled/disabled. However, for convenience to
distributor, this patchset utilizes CONFIG_SND_DEBUG to switch the
feature is enabled/disabled.

$ size sound/core/pcm_native.o.before
   text	   data	    bss	    dec	    hex	filename
  28951	     40	      8	  28999	   7147	sound/core/pcm_native.o.before
$ size sound/core/pcm_native.o.after
   text	   data	    bss	    dec	    hex	filename
  34942	   2264	      8	  37214	   915e	sound/core/pcm_native.o.after

Takashi Sakamoto (3):
  ALSA: pcm: tracepoints for refining PCM parameters
  ALSA: pcm: enable parameter tracepoints only when CONFIG_SND_DEBUG is
    enabled
  ALSA: pcm: obsolete RULES_DEBUG local macro

 sound/core/Makefile          |   1 +
 sound/core/pcm_native.c      | 125 ++++++++++++++-----------------------
 sound/core/pcm_param_trace.h | 142 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 80 deletions(-)
 create mode 100644 sound/core/pcm_param_trace.h

-- 
2.11.0
