From: ritsch@iem.at
Subject: Questions: hw_param rules in rme9652, hdsp.c, also for hdspm.c ?
Date: Wed, 08 Oct 2003 20:03:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065636181.3f8451558cf65@iem.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello !

I tried to be Luke ;-), and found following rules for the hammerfall cards:

(Maybe I interpret these false)

A) rule_channel which set the limits to channels

->min to double speed channels and channels max to hdsp->singlespeed channels

(in hdsp double speed channels is 13 and ss speed are 26, 
in hdspm they are 32 and 64)

Why ? Is there a reason to let channels min not to be 1 ?

-> In my opninion I would drop these and also set 
   .channels_min = 1; 
   in ..._playback and ..._record_subinfo.


B) Rule set channel according to rate

Here if rate->min is greater than 48000 ( which means double speed rate),  set
 channelslimit max to double speed channel. thats ok.

but why also set channel->min in the interval also to nummer of double speed 
channels and not 1 (or leave it to be as is).

-> So i suggest to set t interval to min=1 (or .channels_min from the subinfo).

C) Rule set rate according to channels:

  if channel->min count is bigger than ss_speed channels (which means more then 
  max channels  of the card), than set rate limits to singlespeed.

first this should never happen (since in subinfo limited) and 
if then should  it be if channel->min is bigger than double speed channels set
rate to single speed which would be

	if (c->min >= hdsp->ds_channels) {
		snd_interval_t t = {
			.min = 32000,
			.max = 48000,
			.integer = 1,
		};
        }

and the else tree (will never be evaluated) says

 if channels max < double speed channels use double speed rate

Why is it not allowed to use single speed wenn less channels than double speed
can handle are needed ?

-> I would suggest to drop the else tree.

In my hdspm driver the changes  works until now (playback only tested) 
but maybe there is a reason i dont know.

  mfg winfried

PS: Here the source for other Lukes ;-)

Rule A)
static int snd_hdsp_hw_rule_channels(snd_pcm_hw_params_t *params,
					snd_pcm_hw_rule_t *rule)
{
	hdsp_t *hdsp = rule->private;
	snd_interval_t *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
	unsigned int list[2] = { hdsp->ds_channels, hdsp->ss_channels };
	return snd_interval_list(c, 2, list, 0);
}


Rule B)
static int snd_hdsp_hw_rule_channels_rate(snd_pcm_hw_params_t *params,
					     snd_pcm_hw_rule_t *rule)
{
	hdsp_t *hdsp = rule->private;
	snd_interval_t *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
	if (r->min > 48000) {
		snd_interval_t t = {
			.min = hdsp->ds_channels,
			.max = hdsp->ds_channels,
			.integer = 1,
		};
		return snd_interval_refine(c, &t);
	} else if (r->max < 64000) {
		snd_interval_t t = {
			.min = hdsp->ss_channels,
			.max = hdsp->ss_channels,
			.integer = 1,
		};
		return snd_interval_refine(c, &t);
	}
	return 0;
}


Rule C)
static int snd_hdsp_hw_rule_rate_channels(snd_pcm_hw_params_t *params,
					     snd_pcm_hw_rule_t *rule)
{
	hdsp_t *hdsp = rule->private;
	snd_interval_t *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
	if (c->min >= hdsp->ss_channels) {
		snd_interval_t t = {
			.min = 32000,
			.max = 48000,
			.integer = 1,
		};
		return snd_interval_refine(r, &t);
	} else if (c->max <= hdsp->ds_channels) {
		snd_interval_t t = {
			.min = 64000,
			.max = 96000,
			.integer = 1,
		};
		return snd_interval_refine(r, &t);
	}
	return 0;
}


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
