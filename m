From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: possible fix for buffer underruns on msm7k alsa driver
Date: Sat, 14 Aug 2010 20:29:44 +0200
Message-ID: <1281810584.15120.13.camel@gnutoo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 3212E2452A
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Aug 2010 20:29:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi, I'm still rebasing the codeaurora alsa driver for msm soc like the
htcdream on the android msm 2.6.32 kernel.
I looked the commits for the other socs like msm7kv2 and
qsd8k(snapdragon)

and I found that commit:
commit ac97ef246a754b9a2b4236ca08c6ade389dc206f
Author: Pradeep Jilagam <pjilagam@qualcomm.com>
Date:   Wed Apr 7 17:38:20 2010 +0530

    alsa: 8k: Limit period size for sample rates greater than 8KHz
    
    The DSP interrupts are non-periodic. ALSA expects periodic
    acknowledgement for the buffers sent. Hence, the alsa driver uses
    timer as alternate interrupt source. The min resolution is 10ms
    which results in distorted audio for some sample rates. Hence
    restricting the minimum period size for sample rates greater
    than 8KHz to 512 frames.
    
    Change-Id: Ic8c4180fbee7242fa3139230ddcf6a9f98e4c7ab
    CRs-fixed: 231784
    Signed-off-by: Pradeep Jilagam <pjilagam@qualcomm.com>

I tried a big buck bunny at 44100 Hz: lots(too much) of buffer underrun
=> too bad to be usable.
Then I tried it with 8000 Hz and found nearly no buffer underruns =>
usable.

So I've great expectations for that fix.

here's the source code involved in the fix:

static int hw_rule_periodsize_by_rate(struct snd_pcm_hw_params *params,
struct snd_pcm_hw_rule *rule)
{
struct snd_interval *ps = hw_param_interval(params,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
struct snd_interval *r = hw_param_interval(params,
SNDRV_PCM_HW_PARAM_RATE);
struct snd_interval ch;

if (!ps || !r){
pr_debug("REMOVE_THAT: exiting from !ps||!r\n");
return 0;
}else{
pr_debug("REMOVE_THAT: not exiting\n");
}
snd_interval_any(&ch);

if (r->min > 8000) {
ch.min = 512;
pr_debug("Minimum period size is adjusted to 512\n");
return snd_interval_refine(ps, &ch);
}
return 0;
}


static int msm_pcm_open(struct snd_pcm_substream *substream)
{
struct snd_pcm_runtime *runtime = substream->runtime;
struct msm_audio *prtd;
int ret = 0;

prtd = kzalloc(sizeof(struct msm_audio), GFP_KERNEL);
if (prtd == NULL) {
ret = -ENOMEM;
return ret;
}
if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
msm_vol_ctl.update = 1; /* Update Volume, with Cached value */
runtime->hw = msm_pcm_playback_hardware;
prtd->dir = SNDRV_PCM_STREAM_PLAYBACK;
prtd->playback_substream = substream;
prtd->eos_ack = 0;
} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
runtime->hw = msm_pcm_capture_hardware;
prtd->dir = SNDRV_PCM_STREAM_CAPTURE;
prtd->capture_substream = substream;
}
ret = snd_pcm_hw_constraint_list(runtime, 0,
SNDRV_PCM_HW_PARAM_RATE,
&constraints_sample_rates);
if (ret < 0)
goto out;
/* Ensure that buffer size is a multiple of period size */
ret = snd_pcm_hw_constraint_integer(runtime,
    SNDRV_PCM_HW_PARAM_PERIODS);
if (ret < 0)
goto out;


ret = snd_pcm_hw_rule_add(substream->runtime, 0,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
hw_rule_periodsize_by_rate, substream,
SNDRV_PCM_HW_PARAM_RATE, -1);

if (ret < 0)
goto out;

prtd->ops = &snd_msm_audio_ops;
prtd->out[0].used = BUF_INVALID_LEN;
prtd->out_head = 1; /* point to second buffer on startup */
runtime->private_data = prtd;

ret = alsa_adsp_configure(prtd);
if (ret)
goto out;
copy_count = 0;
return 0;

out:
kfree(prtd);
return ret;
}

Unfortunately it doesn't seem to print the REMOVE_THAT debug messages in
dmesg,after playing something with mplayer, like a 44100 Hz song in mp3
format with mplayer.

I wonder why the hw_rule_periodsize_by_rate function is not executed.

Background:
The htcdream is the first android smartphone and has by default a dsp
interface that is not alsa nor oss nor something that was created
before.
Codeaurora(qualcomm) had some alsa driver,I rebased it  but it was
buggy,so I tried to debug it and succedded at making mplayer run,but it
had many buffer underruns...

Denis.
