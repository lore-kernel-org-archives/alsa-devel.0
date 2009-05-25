From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: 2.6.30: xruns caused by "ALSA: pcm - Safer
 boundary checks"
Date: Mon, 25 May 2009 12:19:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905251212130.4067@eeebox2.perex-int.cz>
References: <20090522162709.2e04b688@dhcp-100-2-144.bos.redhat.com>
	<s5hmy94x0sy.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0905231430400.4067@eeebox2.perex-int.cz>
	<s5hk547el2j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 980BB103839
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 12:19:20 +0200 (CEST)
In-Reply-To: <s5hk547el2j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Chuck Ebbert <cebbert@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 23 May 2009, Takashi Iwai wrote:

> At Sat, 23 May 2009 14:31:57 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Fri, 22 May 2009, Takashi Iwai wrote:
>>
>>> At Fri, 22 May 2009 16:27:09 -0400,
>>> Chuck Ebbert wrote:
>>>>
>>>> Bug report: https://bugzilla.redhat.com/show_bug.cgi?id=498858
>>>>
>>>> To reproduce, pause a video in mplayer and then hit play:
>>>>
>>>> ALSA sound/core/pcm_lib.c:263: hda_codec: hw_ptr skipping! [Q] (pos=11263,
>>>> delta=17400, period=1024, jdelta=21/362/0)
>>>
>>> Does the patch fix the problem?
>>
>> This patch does not look as a proper fix.
>
> Hm, at which point?
> It just skips the first unreliable jiffies check.
> At least, it's interesting whether it works around the problem.

I meant that it is not necessary to introduce a next variable. This patch 
is more elegant:

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a2a792c..3eea98a 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1478,7 +1478,6 @@ static int snd_pcm_lib_ioctl_reset(struct snd_pcm_substream *substream,
  		runtime->status->hw_ptr %= runtime->buffer_size;
  	else
  		runtime->status->hw_ptr = 0;
-	runtime->hw_ptr_jiffies = jiffies;
  	snd_pcm_stream_unlock_irqrestore(substream, flags);
  	return 0;
  }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index fc6f98e..7faec82 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -848,6 +848,7 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream, int state)
  {
  	struct snd_pcm_runtime *runtime = substream->runtime;
  	snd_pcm_trigger_tstamp(substream);
+	runtime->hw_ptr_jiffies = jiffies;
  	runtime->status->state = state;
  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
  	    runtime->silence_size > 0)
@@ -961,6 +962,8 @@ static int snd_pcm_do_pause(struct snd_pcm_substream *substream, int push)
  {
  	if (substream->runtime->trigger_master != substream)
  		return 0;
+	/* skip one jiffies check */
+	runtime->hw_ptr_jiffies = jiffies - HZ * 1000;
  	return substream->ops->trigger(substream,
  				       push ? SNDRV_PCM_TRIGGER_PAUSE_PUSH :
  					      SNDRV_PCM_TRIGGER_PAUSE_RELEASE);


 				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
