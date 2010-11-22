From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] [RFC]intel_hdmi_audio:include header
Date: Mon, 22 Nov 2010 13:48:59 +0000
Message-ID: <20101122134859.GC15156@sirena.org.uk>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C64451039E9
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:49:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramesh.babu@intel.com
Cc: alsa-devel@alsa-project.org, Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 07:09:42PM +0530, ramesh.babu@intel.com wrote:

> +#define AUD_SAMPLE_RATE_32	HAD_MIN_RATE
> +#define AUD_SAMPLE_RATE_44_1	44100
> +#define AUD_SAMPLE_RATE_48	48000
> +#define AUD_SAMPLE_RATE_88_2	88200
> +#define AUD_SAMPLE_RATE_96	96000
> +#define AUD_SAMPLE_RATE_176_4	176400
> +#define AUD_SAMPLE_RATE_192	HAD_MAX_RATE

The defines for the individual rates don't seem to serve any purpose
here - they're just defined to the sample rate as an integer, and the
one place they're used looks to be a switch statement where I found
myself wondering why either standard ALSA defines or the raw numbers
weren't being used.

> +#define DRIVER_NAME		"intelmid_hdmi_audio"
> +#define DIS_SAMPLE_RATE_25_2	25200
> +#define DIS_SAMPLE_RATE_27	27000
> +#define DIS_SAMPLE_RATE_54	54000
> +#define DIS_SAMPLE_RATE_74_25	74250
> +#define DIS_SAMPLE_RATE_148_5	148500

Ditto here.

> +#define REG_BIT_0		0x1
> +#define REG_BIT_1		0x2
> +#define REG_BIT_2		0x4
> +#define REG_BIT_3		0x8
> +#define REG_BIT_20		0x100000

There's a standard BIT() macro IIRC.

> +#define SET_BIT0		1
> +#define CLEAR_BIT0		0

These macros don't do anything like what one would expect...

> +/**
> + * enum intel_had_aud_buf_type - HDMI controller ring buffer types
> + *
> + * @HAD_BUF_TYPE_A: ring buffer A
> + * @HAD_BUF_TYPE_B: ring buffer B
> + * @HAD_BUF_TYPE_C: ring buffer C
> + * @HAD_BUF_TYPE_D: ring buffer D
> + */
> +enum intel_had_aud_buf_type {
> +	HAD_BUF_TYPE_A = 0,
> +	HAD_BUF_TYPE_B = 1,
> +	HAD_BUF_TYPE_C = 2,
> +	HAD_BUF_TYPE_D = 3,
> +};

These could use a little more explanation.

> +extern struct snd_intelhad *intelhaddata;
> +extern struct snd_pcm_ops snd_intelhad_playback_ops;
> +extern int hdmi_card_index;
> +extern char *hdmi_card_id;

These global variables look very suspicous - they look like they should
be local to some file?
