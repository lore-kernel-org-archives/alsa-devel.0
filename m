From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 17/19] ALSA: ymu831: add codec driver
Date: Wed, 16 Jan 2013 14:16:01 +0000
Message-ID: <20130116141601.GI16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116174328.5b309b4f4d15c08fe6e8548a@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116174328.5b309b4f4d15c08fe6e8548a@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 16, 2013 at 05:43:28PM +0900, Yoichi Yuasa wrote:
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  sound/soc/codecs/ymu831/Makefile      |    2 +-
>  sound/soc/codecs/ymu831/ymu831.c      | 5235 +++++++++++++++++++++++++++++++++
>  sound/soc/codecs/ymu831/ymu831.h      |   48 +
>  sound/soc/codecs/ymu831/ymu831_priv.h |  278 ++
>  4 files changed, 5562 insertions(+), 1 deletion(-)
>  create mode 100644 sound/soc/codecs/ymu831/ymu831.c
>  create mode 100644 sound/soc/codecs/ymu831/ymu831.h
>  create mode 100644 sound/soc/codecs/ymu831/ymu831_priv.h

> +#define MC_ASOC_DRIVER_VERSION	"1.0.1"

The kernel verison numbers are perfectly good, don't add your own.

> +static const struct mc_asoc_info_store info_store_tbl[] = {
> +	{
> +	 .get = MCDRV_GET_CLOCKSW,
> +	 .set = MCDRV_SET_CLOCKSW,
> +	 .offset = offsetof(struct mc_asoc_data, clocksw_store),
> +	 },

You're essentially doing ioctl() calls to the non-Linux code earlier...
this looks like you've done some kind of HAL which is basically never
going to fly in mainline.  You need to rewrite this stuff to get rid of
the HAL.

> +struct mixer_path_ctl_info {
> +	int audio_mode_play;
> +	int audio_mode_cap;
> +	int output_path;
> +	int input_path;
> +	int incall_mic;
> +	int mainmic_play;
> +	int submic_play;
> +	int msmic_play;
> +	int hsmic_play;
> +	int btmic_play;
> +	int lin1_play;
> +	int dtmf_control;
> +	int dtmf_output;
> +};
> +
> +static int get_mixer_path_ctl_info(struct snd_soc_codec *codec,
> +				   struct mixer_path_ctl_info *info)
> +{

Use DAPM.

> +static inline int is_incall(int preset_idx)
> +{
> +	if ((preset_idx >= 12 && preset_idx <= 23)
> +	    || (preset_idx >= 50 && preset_idx <= 61))
> +		return 1;
> +
> +	return 0;
> +}

This is really not legible.  What do these numbers mean?

> +		if (mc_asoc_sub_mic == MIC_4) {
> +			if (info->submic_play == 1)
> +				if (preset_idx < 4 || preset_idx >= 38
> +				    || input_path == MC_ASOC_INPUT_PATH_BT
> +				    || input_path ==
> +				    MC_ASOC_INPUT_PATH_SUBMIC) {
> +					*db = aplay_db;
> +					return 0;
> +				}

All this open coded stuff for individual controls is really bloating the
code.

I've stopped reading here.  It's really hard to see this as a serious
attempt to produce a Linux driver - even at a simple visual level the
code doesn't look like normal ASoC code and I'd be surprised seeing it
anywhere within the kernel.   

I strongly recommend just throwing this code away and starting from
scratch, working from the datasheet to produce something within the ASoC
frameworks.  Probably the simplest thing is going to be to start with a
basic driver that just supports a limited subset of the functionality
(eg, skip the DSPs - perhaps even just make something that supports a
single audio path) and then build up from there incrementally.  I
suspect that if you do this your driver will get very much smaller and
simpler, there's an awful lot of stuff the frameworks do for you on
Linux.
