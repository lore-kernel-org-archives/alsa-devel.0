From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Audio:suspend to ram issue
Date: Fri, 19 Aug 2011 09:53:58 +0530
Message-ID: <4E4DE55E.5080402@st.com>
References: <4E4CABBC.20901@st.com> <4E4CEEB9.2000604@st.com>
	<20110818162535.GG20208@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id B340824503
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 06:24:52 +0200 (CEST)
In-Reply-To: <20110818162535.GG20208@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Marks
Thanks for your reply

On 8/18/2011 9:55 PM, Mark Brown wrote:
> On Thu, Aug 18, 2011 at 04:21:37PM +0530, Rajeev kumar wrote:
>
>> Is there any difference between these two suspend  ctrl-z and echo
>> mem>  /sys/power/state.
> Yes.  For example in system suspend it is likely that some of the system
> power supplies will be disabled and low power states will be entered
> which cause register contents to be lost.
>
>> While going through the alsa framework I found that suspend and
>> resume functionality is handled by
>> the framework itself.Please correct me if my understanding is not correct.
> DAPM will be taken care of but there is usually some other work
> required, if only restoring the register maps of devices.  There are
> callbacks into the individual drivers in order to allow them to take
> whatever action is required to quiesce and restore the device.
[Rajeev]:
Is it necessary to  implement DAPM?
When I checked the command value (cmd part ) in trigger function it is 1 
(SNDRV_PCM_TRIGGER_START ) , in case system get resumes
  and an 0 (SNDRV_PCM_TRIGGER_STOP) in case system goes in suspend mode.
In trigger start for cpu(i2s) i am enabling all the register value and 
in case of stop just clearing all the bit.
Please find below the code for trigger function for platform and cpu part.

For i2s trigger
============
static int
  dw_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
                  struct snd_soc_dai *dai)
  {
          struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
          int ret = 0;

          switch (cmd) {
          case SNDRV_PCM_TRIGGER_START:
                  dev->active++;
                  if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
                          i2s_start_play(dev, substream);
                  else
                          i2s_start_rec(dev, substream);
          case SNDRV_PCM_TRIGGER_RESUME:
          case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
                  break;

          case SNDRV_PCM_TRIGGER_STOP:
          case SNDRV_PCM_TRIGGER_SUSPEND:
          case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
                  i2s_stop(dev, substream);
                  break;
          default:
                  ret = -EINVAL;
                  break;
          }
          return ret;
  }

For platform trigger
=================
static int spear13xx_pcm_trigger(struct snd_pcm_substream *substream, 
int cmd)
  {
          struct spear13xx_runtime_data *prtd = 
substream->runtime->private_data;
          int ret = 0;

          switch (cmd) {
          case SNDRV_PCM_TRIGGER_START:
                  prtd->frag_count = -1;
                  tasklet_schedule(&prtd->tasklet);
                  break;
          case SNDRV_PCM_TRIGGER_STOP:
          case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
          case SNDRV_PCM_TRIGGER_SUSPEND:
          chan->device->device_control(chan, DMA_TERMINATE_ALL, 0); /* 
terminate all the  DMA transfer */
                  break;
          case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
          case SNDRV_PCM_TRIGGER_RESUME:
                  break;
          default:
                  ret = -EINVAL;
          }
          return ret;
  }

one more point I would like to mention that there is no any 
suspend/resume function I have implemented in the cpu driver
as i thought this is handled by the framework itself.Am I correct?

Best Regards
Rajeev
