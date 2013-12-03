From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [TINYCOMPRESS PATCH 1/2] crec: Initial version
	of	a compressed capture utility
Date: Tue, 3 Dec 2013 16:09:00 +0000
Message-ID: <20131203160900.GC23979@opensource.wolfsonmicro.com>
References: <1384879579-7790-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131127080824.GL8834@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65EF5265200
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 17:09:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131127080824.GL8834@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 27, 2013 at 01:38:24PM +0530, Vinod Koul wrote:
> On Tue, Nov 19, 2013 at 04:46:18PM +0000, Charles Keepax wrote:
> > This version only supports capture of PCM streams over a compressed
> > device and saves these as WAV files.
> Thanks for posting this :) I was about to ping you ad get these done if you were
> busy...

Sorry about the delay on looking at this again, I keep getting
pulled off in other directions :-)

> > +static void usage(void)
> > +{
> > +	fprintf(stderr, "usage: crec [OPTIONS] filename\n"
> > +		"-c\tcard number\n"
> > +		"-d\tdevice node\n"
> > +		"-b\tbuffer size\n"
> > +		"-f\tfragments\n"
> > +		"-v\tverbose mode\n"
> > +		"-l\tlength of record in seconds\n"
> perhaps it would be more intutive for time. We cant use d here :(

Yeah can't use 'd', I guess I could use 't' if preferred?


> 
> > +		"-h\tPrints this help list\n\n"
> > +		"-C\tSpecify the number of channels (default %u)\n"
> > +		"-R\tSpecify the sample rate (default %u)\n"
> can these be lower case?

Unfortunately, 'c', card and 'f', fragments are both used so I
opted to use capitals for the stream parameters (channels, rate,
format). I am open to changing these to something else but you
end up using weird letters for things and caps felt most clear.

> 
> > +		"-F\tSpecify the format: S16_LE, S32_LE (default S16_LE)\n\n"
> > +		"Example:\n"
> > +		"\tcrec -c 1 -d 2 test.wav\n"
> > +		"\tcrec -f 5 test.wav\n",
> > +		DEFAULT_CHANNELS, DEFAULT_RATE);
> > +
> > +	exit(EXIT_FAILURE);
> > +}

<snip>

> > +	if (verbose)
> > +		printf("%s: entry, reading %u bytes\n", __func__, length);
> > +
> > +	file = fopen(name, "w+b");
> why w+?

Oops, yeah that should be changed.

> > +	if (!file) {
> > +		fprintf(stderr, "Unable to open file '%s'\n", name);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	/* Write a header, will update with size once record is complete */
> > +	init_wave_header(&header, channels, rate, samplebits);
> > +	written = fwrite(&header, sizeof(header), 1, file);
> > +	if (written != 1) {
> > +		fprintf(stderr, "Error writing output file header: %d\n",
> > +			ferror(file));
> > +		goto file_exit;
> > +	}
> > +
> > +	codec.id = SND_AUDIOCODEC_PCM;
> > +	codec.ch_in = channels;
> > +	codec.ch_out = channels;
> > +	codec.sample_rate = compress_get_alsa_rate(rate);
> > +	if (!codec.sample_rate) {
> > +		fprintf(stderr, "invalid sample rate %d\n", rate);
> > +		goto file_exit;
> > +	}
> > +	codec.bit_rate = 0;
> > +	codec.rate_control = 0;
> > +	codec.profile = 0;
> > +	codec.level = 0;
> > +	codec.ch_mode = 0;
> > +	codec.format = format;
> why not do memset of the codec and configure only what we need...

Yeah, that is a good point I will update this as well.

Thanks,
Charles
