From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH] ASoC: core: Convert single bit wide
 bitfields into bools
Date: Wed, 8 Feb 2012 14:08:05 -0500
Message-ID: <CA+7tXihEOP0a-JwEw7LGEhtj3WFR30M0t9PJZ1Ykwq+G5PLE1Q@mail.gmail.com>
References: <1328727486-923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7228D103EA2
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 20:08:07 +0100 (CET)
Received: by wera1 with SMTP id a1so682554wer.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 11:08:05 -0800 (PST)
In-Reply-To: <1328727486-923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Aren't you increasing the size of some of these structs considerably?

On Wed, Feb 8, 2012 at 1:58 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> It's what they are, we've just been using these for historical reasons.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0include/sound/soc-dai.h =A0| =A0 12 ++++++------
> =A0include/sound/soc-dapm.h | =A0 26 +++++++++++++-------------
> =A0include/sound/soc.h =A0 =A0 =A0| =A0 32 ++++++++++++++++--------------=
--
> =A03 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 1a2b08c..53f9a1f 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -208,7 +208,7 @@ struct snd_soc_dai_driver {
> =A0 =A0 =A0 =A0/* DAI capabilities */
> =A0 =A0 =A0 =A0struct snd_soc_pcm_stream capture;
> =A0 =A0 =A0 =A0struct snd_soc_pcm_stream playback;
> - =A0 =A0 =A0 unsigned int symmetric_rates:1;
> + =A0 =A0 =A0 bool symmetric_rates;
>
> =A0 =A0 =A0 =A0/* probe ordering - for components with runtime dependenci=
es */
> =A0 =A0 =A0 =A0int probe_order;
> @@ -230,13 +230,13 @@ struct snd_soc_dai {
> =A0 =A0 =A0 =A0struct snd_soc_dai_driver *driver;
>
> =A0 =A0 =A0 =A0/* DAI runtime info */
> - =A0 =A0 =A0 unsigned int capture_active:1; =A0 =A0 =A0 =A0 =A0/* stream=
 is in use */
> - =A0 =A0 =A0 unsigned int playback_active:1; =A0 =A0 =A0 =A0 /* stream i=
s in use */
> - =A0 =A0 =A0 unsigned int symmetric_rates:1;
> + =A0 =A0 =A0 bool capture_active; =A0 =A0 =A0 =A0 =A0 =A0/* stream is in=
 use */
> + =A0 =A0 =A0 bool playback_active; =A0 =A0 =A0 =A0 =A0 /* stream is in u=
se */
> + =A0 =A0 =A0 bool symmetric_rates;
> =A0 =A0 =A0 =A0struct snd_pcm_runtime *runtime;
> =A0 =A0 =A0 =A0unsigned int active;
> - =A0 =A0 =A0 unsigned char pop_wait:1;
> - =A0 =A0 =A0 unsigned char probed:1;
> + =A0 =A0 =A0 bool pop_wait;
> + =A0 =A0 =A0 bool probed;
>
> =A0 =A0 =A0 =A0/* DAI DMA data */
> =A0 =A0 =A0 =A0void *playback_dma_data;
> diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
> index db8435a..99661c0 100644
> --- a/include/sound/soc-dapm.h
> +++ b/include/sound/soc-dapm.h
> @@ -456,9 +456,9 @@ struct snd_soc_dapm_path {
> =A0 =A0 =A0 =A0struct snd_kcontrol *kcontrol;
>
> =A0 =A0 =A0 =A0/* status */
> - =A0 =A0 =A0 u32 connect:1; =A0/* source and sink widgets are connected =
*/
> - =A0 =A0 =A0 u32 walked:1; =A0 /* path has been walked */
> - =A0 =A0 =A0 u32 weak:1; =A0 =A0 /* path ignored for power management */
> + =A0 =A0 =A0 bool connect; =A0 /* source and sink widgets are connected =
*/
> + =A0 =A0 =A0 bool walked; =A0 =A0/* path has been walked */
> + =A0 =A0 =A0 bool weak; =A0 =A0 =A0/* path ignored for power management =
*/
>
> =A0 =A0 =A0 =A0int (*connected)(struct snd_soc_dapm_widget *source,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc_dapm_widge=
t *sink);
> @@ -488,16 +488,16 @@ struct snd_soc_dapm_widget {
> =A0 =A0 =A0 =A0unsigned int mask; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* non-shifted mask */
> =A0 =A0 =A0 =A0unsigned int on_val; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* on state value */
> =A0 =A0 =A0 =A0unsigned int off_val; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
/* off state value */
> - =A0 =A0 =A0 unsigned char power:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* block power status */
> - =A0 =A0 =A0 unsigned char invert:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
invert the power bit */
> - =A0 =A0 =A0 unsigned char active:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =
active stream on DAC, ADC's */
> - =A0 =A0 =A0 unsigned char connected:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* co=
nnected codec pin */
> - =A0 =A0 =A0 unsigned char new:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* cnew complete */
> - =A0 =A0 =A0 unsigned char ext:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* has external widgets */
> - =A0 =A0 =A0 unsigned char force:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* force state */
> - =A0 =A0 =A0 unsigned char ignore_suspend:1; =A0 =A0 =A0 =A0 /* kept ena=
bled over suspend */
> - =A0 =A0 =A0 unsigned char new_power:1; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* po=
wer from this run */
> - =A0 =A0 =A0 unsigned char power_checked:1; =A0 =A0 =A0 =A0 =A0/* power =
checked this run */
> + =A0 =A0 =A0 bool power; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* block power status */
> + =A0 =A0 =A0 bool invert; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0/* invert the power bit */
> + =A0 =A0 =A0 bool active; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0/* active stream on DAC, ADC's */
> + =A0 =A0 =A0 bool connected; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* connected codec pin */
> + =A0 =A0 =A0 bool new; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 /* cnew complete */
> + =A0 =A0 =A0 bool ext; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 /* has external widgets */
> + =A0 =A0 =A0 bool force; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* force state */
> + =A0 =A0 =A0 bool ignore_suspend; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* kept enabled over suspend */
> + =A0 =A0 =A0 bool new_power; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* power from this run */
> + =A0 =A0 =A0 bool power_checked; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* power checked this run */
> =A0 =A0 =A0 =A0int subseq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 /* sort within widget type */
>
> =A0 =A0 =A0 =A0int (*power_check)(struct snd_soc_dapm_widget *w);
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index d1e7a6a..466b1f3 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -571,14 +571,14 @@ struct snd_soc_codec {
> =A0 =A0 =A0 =A0/* runtime */
> =A0 =A0 =A0 =A0struct snd_ac97 *ac97; =A0/* for ad-hoc ac97 devices */
> =A0 =A0 =A0 =A0unsigned int active;
> - =A0 =A0 =A0 unsigned int cache_bypass:1; /* Suppress access to the cach=
e */
> - =A0 =A0 =A0 unsigned int suspended:1; /* Codec is in suspend PM state */
> - =A0 =A0 =A0 unsigned int probed:1; /* Codec has been probed */
> - =A0 =A0 =A0 unsigned int ac97_registered:1; /* Codec has been AC97 regi=
stered */
> - =A0 =A0 =A0 unsigned int ac97_created:1; /* Codec has been created by S=
oC */
> - =A0 =A0 =A0 unsigned int sysfs_registered:1; /* codec has been sysfs re=
gistered */
> - =A0 =A0 =A0 unsigned int cache_init:1; /* codec cache has been initiali=
zed */
> - =A0 =A0 =A0 unsigned int using_regmap:1; /* using regmap access */
> + =A0 =A0 =A0 bool cache_bypass; /* Suppress access to the cache */
> + =A0 =A0 =A0 bool suspended; /* Codec is in suspend PM state */
> + =A0 =A0 =A0 bool probed; /* Codec has been probed */
> + =A0 =A0 =A0 bool ac97_registered; /* Codec has been AC97 registered */
> + =A0 =A0 =A0 bool ac97_created; /* Codec has been created by SoC */
> + =A0 =A0 =A0 bool sysfs_registered; /* codec has been sysfs registered */
> + =A0 =A0 =A0 bool cache_init; /* codec cache has been initialized */
> + =A0 =A0 =A0 bool using_regmap; /* using regmap access */
> =A0 =A0 =A0 =A0u32 cache_only; =A0/* Suppress writes to hardware */
> =A0 =A0 =A0 =A0u32 cache_sync; /* Cache needs to be synced to hardware */
>
> @@ -598,7 +598,7 @@ struct snd_soc_codec {
>
> =A0 =A0 =A0 =A0/* dapm */
> =A0 =A0 =A0 =A0struct snd_soc_dapm_context dapm;
> - =A0 =A0 =A0 unsigned int ignore_pmdown_time:1; /* pmdown_time is ignore=
d at stop */
> + =A0 =A0 =A0 bool ignore_pmdown_time; /* pmdown_time is ignored at stop =
*/
>
> =A0#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0struct dentry *debugfs_codec_root;
> @@ -712,8 +712,8 @@ struct snd_soc_platform {
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0struct snd_soc_platform_driver *driver;
>
> - =A0 =A0 =A0 unsigned int suspended:1; /* platform is suspended */
> - =A0 =A0 =A0 unsigned int probed:1;
> + =A0 =A0 =A0 bool suspended; /* platform is suspended */
> + =A0 =A0 =A0 bool probed;
>
> =A0 =A0 =A0 =A0struct snd_soc_card *card;
> =A0 =A0 =A0 =A0struct list_head list;
> @@ -737,13 +737,13 @@ struct snd_soc_dai_link {
> =A0 =A0 =A0 =A0unsigned int dai_fmt; =A0 =A0 =A0 =A0 =A0 /* format to set=
 on init */
>
> =A0 =A0 =A0 =A0/* Keep DAI active over suspend */
> - =A0 =A0 =A0 unsigned int ignore_suspend:1;
> + =A0 =A0 =A0 bool ignore_suspend;
>
> =A0 =A0 =A0 =A0/* Symmetry requirements */
> - =A0 =A0 =A0 unsigned int symmetric_rates:1;
> + =A0 =A0 =A0 bool symmetric_rates;
>
> =A0 =A0 =A0 =A0/* pmdown_time is ignored at stop */
> - =A0 =A0 =A0 unsigned int ignore_pmdown_time:1;
> + =A0 =A0 =A0 bool ignore_pmdown_time;
>
> =A0 =A0 =A0 =A0/* codec/machine specific init - e.g. add machine controls=
 */
> =A0 =A0 =A0 =A0int (*init)(struct snd_soc_pcm_runtime *rtd);
> @@ -876,8 +876,8 @@ struct snd_soc_pcm_runtime {
> =A0 =A0 =A0 =A0enum snd_soc_pcm_subclass pcm_subclass;
> =A0 =A0 =A0 =A0struct snd_pcm_ops ops;
>
> - =A0 =A0 =A0 unsigned int complete:1;
> - =A0 =A0 =A0 unsigned int dev_registered:1;
> + =A0 =A0 =A0 bool complete;
> + =A0 =A0 =A0 bool dev_registered;
>
> =A0 =A0 =A0 =A0long pmdown_time;
>
> --
> 1.7.9.rc1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
