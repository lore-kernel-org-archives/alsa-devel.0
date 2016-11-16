From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] crec: Add option to specify codec ID
Date: Wed, 16 Nov 2016 18:35:08 +0530
Message-ID: <20161116130508.GZ3000@localhost>
References: <1479296649-18278-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 60C5F2659AA
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 13:55:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1479296649-18278-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2016 at 11:44:09AM +0000, Richard Fitzgerald wrote:
> This patch adds a -I command line option to set the codec ID,
> either from a defined set of string values or as a number.

Can you explain why you want to add this? The utility cant really record a
mp3 file!


> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  src/utils/crec.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 7 deletions(-)
> 
> diff --git a/src/utils/crec.c b/src/utils/crec.c
> index 8d5b7b0..a586fc4 100644
> --- a/src/utils/crec.c
> +++ b/src/utils/crec.c
> @@ -83,6 +83,27 @@ static bool streamed;
>  static const unsigned int DEFAULT_CHANNELS = 1;
>  static const unsigned int DEFAULT_RATE = 44100;
>  static const unsigned int DEFAULT_FORMAT = SNDRV_PCM_FORMAT_S16_LE;
> +static const unsigned int DEFAULT_CODEC_ID = SND_AUDIOCODEC_PCM;
> +
> +static const struct {
> +	const char *name;
> +	unsigned int id;
> +} codec_ids[] = {
> +	{ "PCM", SND_AUDIOCODEC_PCM },
> +	{ "MP3", SND_AUDIOCODEC_MP3 },
> +	{ "AMR", SND_AUDIOCODEC_AMR },
> +	{ "AMRWB", SND_AUDIOCODEC_AMRWB },
> +	{ "ARMWBPLUS", SND_AUDIOCODEC_AMRWBPLUS },
> +	{ "AAC", SND_AUDIOCODEC_AAC },
> +	{ "WMA", SND_AUDIOCODEC_WMA },
> +	{ "REAL", SND_AUDIOCODEC_REAL },
> +	{ "VORBIS", SND_AUDIOCODEC_VORBIS },
> +	{ "FLAC", SND_AUDIOCODEC_FLAC },
> +	{ "IEC61937", SND_AUDIOCODEC_IEC61937 },
> +	{ "G723_1", SND_AUDIOCODEC_G723_1 },
> +	{ "G729", SND_AUDIOCODEC_G729 },
> +};
> +#define CREC_NUM_CODEC_IDS (sizeof(codec_ids) / sizeof(codec_ids[0]))
>  
>  struct riff_chunk {
>  	char desc[4];
> @@ -153,6 +174,8 @@ static void size_wave_header(struct wave_header *header, uint32_t size)
>  
>  static void usage(void)
>  {
> +	int i;
> +
>  	fprintf(stderr, "usage: crec [OPTIONS] [filename]\n"
>  		"-c\tcard number\n"
>  		"-d\tdevice node\n"
> @@ -163,14 +186,22 @@ static void usage(void)
>  		"-h\tPrints this help list\n\n"
>  		"-C\tSpecify the number of channels (default %u)\n"
>  		"-R\tSpecify the sample rate (default %u)\n"
> -		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n\n"
> +		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n"
> +		"-I\tSpecify codec ID (default PCM)\n\n"
>  		"If filename is not given the output is\n"
>  		"written to stdout\n\n"
>  		"Example:\n"
>  		"\tcrec -c 1 -d 2 test.wav\n"
> -		"\tcrec -f 5 test.wav\n",
> +		"\tcrec -f 5 test.wav\n\n"
> +		"Valid codec IDs:\n",
>  		DEFAULT_CHANNELS, DEFAULT_RATE);
>  
> +	for (i = 0; i < CREC_NUM_CODEC_IDS; ++i)
> +		fprintf(stderr, "%s%c", codec_ids[i].name,
> +			(i % 8) ? ' ' : '\n');
> +
> +	fprintf(stderr, "\nor the value in decimal or hex\n");
> +
>  	exit(EXIT_FAILURE);
>  }
>  
> @@ -239,7 +270,8 @@ static int finish_record(void)
>  static void capture_samples(char *name, unsigned int card, unsigned int device,
>  		     unsigned long buffer_size, unsigned int frag,
>  		     unsigned int length, unsigned int rate,
> -		     unsigned int channels, unsigned int format)
> +		     unsigned int channels, unsigned int format,
> +		     unsigned int codec_id)
>  {
>  	struct compr_config config;
>  	struct snd_codec codec;
> @@ -288,7 +320,7 @@ static void capture_samples(char *name, unsigned int card, unsigned int device,
>  
>  	memset(&codec, 0, sizeof(codec));
>  	memset(&config, 0, sizeof(config));
> -	codec.id = SND_AUDIOCODEC_PCM;
> +	codec.id = codec_id;


So we are going to dump raw encoded data. I am not sure thats a smart
choice.. We should really support format headers and save proper files


-- 
~Vinod
