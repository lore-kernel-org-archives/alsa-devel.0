From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ALSA: pcm: add IEC958 channel status
	update
Date: Wed, 2 Dec 2015 19:00:36 +0000
Message-ID: <20151202190036.GD8644@n2100.arm.linux.org.uk>
References: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
 <1449066126-19431-2-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 9AF762650D4
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 20:00:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1449066126-19431-2-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 02, 2015 at 03:22:04PM +0100, Moise Gergaud wrote:
> Add a helper to update only the IEC958 channel status sampling freq and
> word length parameters from an ALSA snd_pcm_runtime structure, taking
> account of the sample rate and sample size.
> 
> Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

NAK.

> diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
> index 0eed397..0c84c69 100644
> --- a/include/sound/pcm_iec958.h
> +++ b/include/sound/pcm_iec958.h
> @@ -3,7 +3,24 @@
>  
>  #include <linux/types.h>
>  
> +#ifdef CONFIG_SND_PCM_IEC958
>  int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> -	size_t len);
> +				   size_t len);
> +
> +int snd_pcm_update_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> +				   size_t len);
> +#else
> +int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> +				   size_t len)
> +{
> +	return len;
> +}
> +
> +int snd_pcm_update_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> +				   size_t len)
> +{
> +	return len;
> +}

Firstly, this is dangerous.  If you don't have anything defined here,
then the channel status ends up being undefined.

The intention here is that if you're a user of this, then select the
config symbol.  That makes providing stubs totally unnecessary and
removes this problem.

> +#endif
>  
>  #endif
> diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
> index 36b2d7a..abe3967 100644
> --- a/sound/core/pcm_iec958.c
> +++ b/sound/core/pcm_iec958.c
> @@ -11,67 +11,72 @@
>  #include <sound/pcm.h>
>  #include <sound/pcm_iec958.h>
>  
> -/**
> - * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
> +/*
> + * snd_pcm_update_iec958_consumer - update consumer format IEC958 channel status
>   * @runtime: pcm runtime structure with ->rate filled in
>   * @cs: channel status buffer, at least four bytes
>   * @len: length of channel status buffer
>   *
> - * Create the consumer format channel status data in @cs of maximum size
> - * @len corresponding to the parameters of the PCM runtime @runtime.
> - *
> - * Drivers may wish to tweak the contents of the buffer after creation.
> + * Update sampling frequency and word length parameters of the consumer format
> + * channel status data in @cs of maximum size @len.
> + * Values correspond to the rate and format parameters of the PCM runtime
> + * @runtime.
>   *
>   * Returns: length of buffer, or negative error code if something failed.
>   */
> -int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> -	size_t len)
> +int snd_pcm_update_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
> +				   size_t len)
>  {
> -	unsigned int fs, ws;
> -
>  	if (len < 4)
>  		return -EINVAL;
>  
> +	cs[3] &= ~IEC958_AES3_CON_FS;
> +
>  	switch (runtime->rate) {
> +	case 22050:
> +		cs[3] |= IEC958_AES3_CON_FS_22050;
> +		break;
>  	case 32000:
> -		fs = IEC958_AES3_CON_FS_32000;
> +		cs[3] |= IEC958_AES3_CON_FS_32000;
>  		break;
>  	case 44100:
> -		fs = IEC958_AES3_CON_FS_44100;
> +		cs[3] |= IEC958_AES3_CON_FS_44100;
>  		break;
>  	case 48000:
> -		fs = IEC958_AES3_CON_FS_48000;
> +		cs[3] |= IEC958_AES3_CON_FS_48000;
>  		break;
>  	case 88200:
> -		fs = IEC958_AES3_CON_FS_88200;
> +		cs[3] |= IEC958_AES3_CON_FS_88200;
>  		break;
>  	case 96000:
> -		fs = IEC958_AES3_CON_FS_96000;
> +		cs[3] |= IEC958_AES3_CON_FS_96000;
>  		break;
>  	case 176400:
> -		fs = IEC958_AES3_CON_FS_176400;
> +		cs[3] |= IEC958_AES3_CON_FS_176400;
>  		break;
>  	case 192000:
> -		fs = IEC958_AES3_CON_FS_192000;
> +		cs[3] |= IEC958_AES3_CON_FS_192000;
>  		break;

Again, I'm not happy with this change.  The intention here is that we
validate all arguments before we change anything.  This breaks that
principle.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
