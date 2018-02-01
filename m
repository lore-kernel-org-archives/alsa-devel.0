From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] cplay: add option to specify codec ID
Date: Thu, 1 Feb 2018 16:22:46 +0530
Message-ID: <20180201105246.GB18649@localhost>
References: <20180123023312.13029-1-suzuki.katsuhiro@socionext.com>
 <20180123023312.13029-2-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 06DDC26782B
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 11:48:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180123023312.13029-2-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 23, 2018 at 11:33:12AM +0900, Katsuhiro Suzuki wrote:
> This patch adds a -I command line option to set the codec ID,
> same as crecord.

But then you are adding iec support too and moving mp3 support around to fir
better, so that part can be separate patches. Otherwise change lgtm

> 
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  src/utils/cplay.c | 174 +++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 139 insertions(+), 35 deletions(-)
> 
> diff --git a/src/utils/cplay.c b/src/utils/cplay.c
> index bc95f0d..a716f5e 100644
> --- a/src/utils/cplay.c
> +++ b/src/utils/cplay.c
> @@ -74,25 +74,75 @@
>  #include "tinycompress/tinymp3.h"
>  
>  static int verbose;
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
> +	{ "AMRWBPLUS", SND_AUDIOCODEC_AMRWBPLUS },
> +	{ "AAC", SND_AUDIOCODEC_AAC },
> +	{ "WMA", SND_AUDIOCODEC_WMA },
> +	{ "REAL", SND_AUDIOCODEC_REAL },
> +	{ "VORBIS", SND_AUDIOCODEC_VORBIS },
> +	{ "FLAC", SND_AUDIOCODEC_FLAC },
> +	{ "IEC61937", SND_AUDIOCODEC_IEC61937 },
> +	{ "G723_1", SND_AUDIOCODEC_G723_1 },
> +	{ "G729", SND_AUDIOCODEC_G729 },
> +/* BESPOKE isn't defined on older kernels */
> +#ifdef SND_AUDIOCODEC_BESPOKE
> +	{ "BESPOKE", SND_AUDIOCODEC_BESPOKE },
> +#endif
> +};
> +#define CPLAY_NUM_CODEC_IDS (sizeof(codec_ids) / sizeof(codec_ids[0]))
> +
> +static const char *codec_name_from_id(unsigned int id)
> +{
> +	static char hexname[12];
> +	int i;
> +
> +	for (i = 0; i < CPLAY_NUM_CODEC_IDS; ++i) {
> +		if (codec_ids[i].id == id)
> +			return codec_ids[i].name;
> +	}
> +
> +	snprintf(hexname, sizeof(hexname), "0x%x", id);
> +	return hexname; /* a static is safe because we're single-threaded */
> +}
>  
>  static void usage(void)
>  {
> +	int i;
> +
>  	fprintf(stderr, "usage: cplay [OPTIONS] filename\n"
>  		"-c\tcard number\n"
>  		"-d\tdevice node\n"
> +		"-I\tspecify codec ID (default is mp3)\n"
>  		"-b\tbuffer size\n"
>  		"-f\tfragments\n\n"
>  		"-v\tverbose mode\n"
>  		"-h\tPrints this help list\n\n"
>  		"Example:\n"
>  		"\tcplay -c 1 -d 2 test.mp3\n"
> -		"\tcplay -f 5 test.mp3\n");
> +		"\tcplay -f 5 test.mp3\n\n"
> +		"Valid codec IDs:\n");
> +
> +	for (i = 0; i < CPLAY_NUM_CODEC_IDS; ++i)
> +		fprintf(stderr, "%s%c", codec_ids[i].name,
> +			((i + 1) % 8) ? ' ' : '\n');
> +
> +	fprintf(stderr, "\nor the value in decimal or hex\n");
>  
>  	exit(EXIT_FAILURE);
>  }
>  
>  void play_samples(char *name, unsigned int card, unsigned int device,
> -		unsigned long buffer_size, unsigned int frag);
> +		unsigned long buffer_size, unsigned int frag,
> +		unsigned long codec_id);
>  
>  struct mp3_header {
>  	uint16_t sync;
> @@ -156,15 +206,15 @@ int main(int argc, char **argv)
>  {
>  	char *file;
>  	unsigned long buffer_size = 0;
> -	int c;
> +	int c, i;
>  	unsigned int card = 0, device = 0, frag = 0;
> -
> +	unsigned int codec_id = SND_AUDIOCODEC_MP3;
>  
>  	if (argc < 2)
>  		usage();
>  
>  	verbose = 0;
> -	while ((c = getopt(argc, argv, "hvb:f:c:d:")) != -1) {
> +	while ((c = getopt(argc, argv, "hvb:f:c:d:I:")) != -1) {
>  		switch (c) {
>  		case 'h':
>  			usage();
> @@ -181,6 +231,25 @@ int main(int argc, char **argv)
>  		case 'd':
>  			device = strtol(optarg, NULL, 10);
>  			break;
> +		case 'I':
> +			if (optarg[0] == '0') {
> +				codec_id = strtol(optarg, NULL, 0);
> +			} else {
> +				for (i = 0; i < CPLAY_NUM_CODEC_IDS; ++i) {
> +					if (strcmp(optarg,
> +						   codec_ids[i].name) == 0) {
> +						codec_id = codec_ids[i].id;
> +						break;
> +					}
> +				}
> +
> +				if (i == CPLAY_NUM_CODEC_IDS) {
> +					fprintf(stderr, "Unrecognised ID: %s\n",
> +						optarg);
> +					usage();
> +				}
> +			}
> +			break;
>  		case 'v':
>  			verbose = 1;
>  			break;
> @@ -193,24 +262,74 @@ int main(int argc, char **argv)
>  
>  	file = argv[optind];
>  
> -	play_samples(file, card, device, buffer_size, frag);
> +	play_samples(file, card, device, buffer_size, frag, codec_id);
>  
>  	fprintf(stderr, "Finish Playing.... Close Normally\n");
>  	exit(EXIT_SUCCESS);
>  }
>  
> +void get_codec_mp3(FILE *file, struct compr_config *config,
> +		struct snd_codec *codec)
> +{
> +	size_t read;
> +	struct mp3_header header;
> +	unsigned int channels, rate, bits;
> +
> +	read = fread(&header, sizeof(header), 1, file);
> +	if (read != 1) {
> +		fprintf(stderr, "Unable to read header \n");
> +		fclose(file);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (parse_mp3_header(&header, &channels, &rate, &bits) == -1) {
> +		fclose(file);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	codec->id = SND_AUDIOCODEC_MP3;
> +	codec->ch_in = channels;
> +	codec->ch_out = channels;
> +	codec->sample_rate = rate;
> +	if (!codec->sample_rate) {
> +		fprintf(stderr, "invalid sample rate %d\n", rate);
> +		fclose(file);
> +		exit(EXIT_FAILURE);
> +	}
> +	codec->bit_rate = bits;
> +	codec->rate_control = 0;
> +	codec->profile = 0;
> +	codec->level = 0;
> +	codec->ch_mode = 0;
> +	codec->format = 0;
> +}
> +
> +int get_codec_iec(FILE *file, struct compr_config *config,
> +		struct snd_codec *codec)
> +{
> +	codec->id = SND_AUDIOCODEC_IEC61937;
> +	/* FIXME: cannot get accurate ch_in, any channels may be accepted */
> +	codec->ch_in = 2;
> +	codec->ch_out = 2;
> +	codec->sample_rate = 0;
> +	codec->bit_rate = 0;
> +	codec->rate_control = 0;
> +	codec->profile = SND_AUDIOPROFILE_IEC61937_SPDIF;
> +	codec->level = 0;
> +	codec->ch_mode = 0;
> +	codec->format = 0;
> +}
> +
>  void play_samples(char *name, unsigned int card, unsigned int device,
> -		unsigned long buffer_size, unsigned int frag)
> +		unsigned long buffer_size, unsigned int frag,
> +		unsigned long codec_id)
>  {
>  	struct compr_config config;
>  	struct snd_codec codec;
>  	struct compress *compress;
> -	struct mp3_header header;
>  	FILE *file;
>  	char *buffer;
>  	int size, num_read, wrote;
> -	unsigned int channels, rate, bits;
> -	size_t read;
>  
>  	if (verbose)
>  		printf("%s: entry\n", __func__);
> @@ -220,33 +339,18 @@ void play_samples(char *name, unsigned int card, unsigned int device,
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	read = fread(&header, 1, sizeof(header), file);
> -	if (read != sizeof(header)) {
> -		fprintf(stderr, "Unable to read header \n");
> -		fclose(file);
> +	switch (codec_id) {
> +	case SND_AUDIOCODEC_MP3:
> +		get_codec_mp3(file, &config, &codec);
> +		break;
> +	case SND_AUDIOCODEC_IEC61937:
> +		get_codec_iec(file, &config, &codec);
> +		break;
> +	default:
> +		fprintf(stderr, "codec ID %d is not supported\n", codec_id);
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	if (parse_mp3_header(&header, &channels, &rate, &bits) == -1) {
> -		fclose(file);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	codec.id = SND_AUDIOCODEC_MP3;
> -	codec.ch_in = channels;
> -	codec.ch_out = channels;
> -	codec.sample_rate = rate;
> -	if (!codec.sample_rate) {
> -		fprintf(stderr, "invalid sample rate %d\n", rate);
> -		fclose(file);
> -		exit(EXIT_FAILURE);
> -	}
> -	codec.bit_rate = bits;
> -	codec.rate_control = 0;
> -	codec.profile = 0;
> -	codec.level = 0;
> -	codec.ch_mode = 0;
> -	codec.format = 0;
>  	if ((buffer_size != 0) && (frag != 0)) {
>  		config.fragment_size = buffer_size/frag;
>  		config.fragments = frag;
> @@ -292,7 +396,7 @@ void play_samples(char *name, unsigned int card, unsigned int device,
>  	printf("Playing file %s On Card %u device %u, with buffer of %lu bytes\n",
>  			name, card, device, buffer_size);
>  	printf("Format %u Channels %u, %u Hz, Bit Rate %d\n",
> -			SND_AUDIOCODEC_MP3, channels, rate, bits);
> +			codec.id, codec.ch_in, codec.sample_rate, codec.bit_rate);
>  
>  	compress_start(compress);
>  	if (verbose)
> -- 
> 2.15.0
> 

-- 
~Vinod
