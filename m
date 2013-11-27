From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [TINYCOMPRESS PATCH 1/2] crec: Initial version of
 a compressed capture utility
Date: Wed, 27 Nov 2013 13:38:24 +0530
Message-ID: <20131127080824.GL8834@intel.com>
References: <1384879579-7790-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FBC026260F
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 10:06:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1384879579-7790-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 19, 2013 at 04:46:18PM +0000, Charles Keepax wrote:
> This version only supports capture of PCM streams over a compressed
> device and saves these as WAV files.
Thanks for posting this :) I was about to ping you ad get these done if you were
busy...


> +static void usage(void)
> +{
> +	fprintf(stderr, "usage: crec [OPTIONS] filename\n"
> +		"-c\tcard number\n"
> +		"-d\tdevice node\n"
> +		"-b\tbuffer size\n"
> +		"-f\tfragments\n"
> +		"-v\tverbose mode\n"
> +		"-l\tlength of record in seconds\n"
perhaps it would be more intutive for time. We cant use d here :(

> +		"-h\tPrints this help list\n\n"
> +		"-C\tSpecify the number of channels (default %u)\n"
> +		"-R\tSpecify the sample rate (default %u)\n"
can these be lower case?

> +		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n\n"
> +		"Example:\n"
> +		"\tcrec -c 1 -d 2 test.wav\n"
> +		"\tcrec -f 5 test.wav\n",
> +		DEFAULT_CHANNELS, DEFAULT_RATE);
> +
> +	exit(EXIT_FAILURE);
> +}
> +
> +static int print_time(struct compress *compress)
> +{
> +	unsigned int avail;
> +	struct timespec tstamp;
> +
> +	if (compress_get_hpointer(compress, &avail, &tstamp) != 0) {
> +		fprintf(stderr, "Error querying timestamp\n");
> +		fprintf(stderr, "ERR: %s\n", compress_get_error(compress));
> +		return -1;
> +	} else {
> +		printf("DSP recorded %jd.%jd\n",
> +		       (intmax_t)tstamp.tv_sec, (intmax_t)tstamp.tv_nsec*1000);
> +	}
> +	return 0;
> +}
> +
> +void capture_samples(char *name, unsigned int card, unsigned int device,
> +		     unsigned long buffer_size, unsigned int frag,
> +		     unsigned int length, unsigned int rate,
> +		     unsigned int channels, unsigned int format)
> +{
> +	struct compr_config config;
> +	struct snd_codec codec;
> +	struct compress *compress;
> +	struct wave_header header;
> +	FILE *file;
> +	char *buffer;
> +	size_t written;
> +	int read, ret;
> +	unsigned int size, total_read = 0;
> +	unsigned int samplebits;
> +
> +	switch (format) {
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		samplebits = 32;
> +		break;
> +	default:
> +		samplebits = 16;
> +		break;
> +	}
> +
> +	/* Convert length from seconds to bytes */
> +	length = length * rate * (samplebits / 8) * channels;
> +
> +	if (verbose)
> +		printf("%s: entry, reading %u bytes\n", __func__, length);
> +
> +	file = fopen(name, "w+b");
why w+?

> +	if (!file) {
> +		fprintf(stderr, "Unable to open file '%s'\n", name);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* Write a header, will update with size once record is complete */
> +	init_wave_header(&header, channels, rate, samplebits);
> +	written = fwrite(&header, sizeof(header), 1, file);
> +	if (written != 1) {
> +		fprintf(stderr, "Error writing output file header: %d\n",
> +			ferror(file));
> +		goto file_exit;
> +	}
> +
> +	codec.id = SND_AUDIOCODEC_PCM;
> +	codec.ch_in = channels;
> +	codec.ch_out = channels;
> +	codec.sample_rate = compress_get_alsa_rate(rate);
> +	if (!codec.sample_rate) {
> +		fprintf(stderr, "invalid sample rate %d\n", rate);
> +		goto file_exit;
> +	}
> +	codec.bit_rate = 0;
> +	codec.rate_control = 0;
> +	codec.profile = 0;
> +	codec.level = 0;
> +	codec.ch_mode = 0;
> +	codec.format = format;
why not do memset of the codec and configure only what we need...


rest looks okay to me

--
~Vinod
