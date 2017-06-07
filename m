From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/8] ALSA: pcm: code refactoring for
	snd_pcm_hw_refine()
Date: Thu,  8 Jun 2017 08:10:18 +0900
Message-ID: <20170607231026.23383-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id EFD2026721A
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 01:10:38 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is an update of part of my RFC, and goes for upstream.

[alsa-devel] [PATCH RFC 00/21] ALSA: pcm: add tracepoints for PCM params operation
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120548.html

In ALSA PCM interface, applications can get hardware capability as
'struct snd_pcm_hw_params' type of data returned by a call of ioctl(2)
with SNDRV_PCM_IOCTL_HW_REFINE/SNDRV_PCM_IOCTL_HW_PARAMS' commands. In
kernel land, the data is prepared in 'snd_pcm_hw_refine()' in
'sound/core/pcm_native.c'. This patchset is a code refactoring to this
function.

When applications execute open(2) to any PCM character device, runtime
of corresponding PCM substream is created in kernel land. Then, the
runtime gets information to configure the parameter data. When
applications execute ioctl(2) with the above commands, the given
parameter data is actually changed according to the information.

The parameter data structure includes several types of information. 
Major part of the parameter data is represented by two kinds of shape;
mask ('struct snd_mask') and interval ('struct snd_interval'). 15
types of data is pre-defined as 'SNDRV_PCM_HW_PARAM_XXX' macros with
the two types.

The runtime has several constraints, which is a kind of information to
configure the parameters. There're two types of constraints; independent
and dependent. The independent constrain is for each of single parameters.
On the other hand, the dependent constrain is for each of combination
between parameters, thus has specific structure, 'snd_pcm_hw_rule'. This
structure describes relationships between several parameters.

In 'sound/core/pcm_native.c', the above constraints and rules are
applied to parameter data for userspace. This processing is done
in 'snd_pcm_hw_refine()'. In this patchset, I attempt to clean up the
processing so that developers easily understand it.

This is a kind of refactoring, thus behaviour of the processing is not
changed. Tracepoints added in my previous patchset is helpful for your
test to check it. I wrote an application as low level program and
it shall satisfies your interests about the above mechanism[1].

[1] refine-pcm-params.c
https://github.com/takaswie/alsa-ioctl-test/

Takashi Sakamoto (8):
  ALSA: pcm: add a helper function to constrain mask-type parameters
  ALSA: pcm: add a helper function to constrain interval-type parameters
  ALSA: pcm: add a helper function to apply parameter rules
  ALSA: pcm: use goto statement instead of while statement to reduce
    indentation
  ALSA: pcm: remove function local variable with alternative evaluation
  ALSA: pcm: adaption of code formatting
  ALSA: pcm: use helper functions to check whether parameters are
    determined
  ALSA: pcm: add comment about application of rule to PCM parameters

 sound/core/pcm_native.c | 253 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 179 insertions(+), 74 deletions(-)

-- 
2.11.0
