From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/5] compress: add compress parameter
 definations
Date: Fri, 2 Sep 2011 15:19:03 +0100
Message-ID: <20110902141859.GB10175@sirena.org.uk>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-3-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E586D243C8
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 16:19:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314943585-11670-3-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 11:36:22AM +0530, Vinod Koul wrote:

> +/* AUDIO CODECS SUPPORTED */
> +#define MAX_NUM_CODECS 32
> +#define MAX_NUM_CODEC_DESCRIPTORS 32
> +#define MAX_NUM_RATES 32
> +#define MAX_NUM_BITRATES 32

Can we avoid these limitations?  The limit on the number of CODECs in
particular strikes me as not sufficiently high for me to be confident
we'd never run into it.  Consider a server side telephony system...

> +/* Codecs are listed linearly to allow for extensibility */
> +#define SND_AUDIOCODEC_PCM                   ((__u32) 0x00000001)
> +#define SND_AUDIOCODEC_MP3                   ((__u32) 0x00000002)
> +#define SND_AUDIOCODEC_AMR                   ((__u32) 0x00000003)
> +#define SND_AUDIOCODEC_AMRWB                 ((__u32) 0x00000004)
> +#define SND_AUDIOCODEC_AMRWBPLUS             ((__u32) 0x00000005)
> +#define SND_AUDIOCODEC_AAC                   ((__u32) 0x00000006)
> +#define SND_AUDIOCODEC_WMA                   ((__u32) 0x00000007)
> +#define SND_AUDIOCODEC_REAL                  ((__u32) 0x00000008)
> +#define SND_AUDIOCODEC_VORBIS                ((__u32) 0x00000009)
> +#define SND_AUDIOCODEC_FLAC                  ((__u32) 0x0000000A)
> +#define SND_AUDIOCODEC_IEC61937              ((__u32) 0x0000000B)

I'd be inclined to add:

+#define SND_AUDIOCODEC_G723_1                  ((__u32) 0x0000000C)
+#define SND_AUDIOCODEC_G729                    ((__u32) 0x0000000D)

for VoIP usage as part of the default set but obviously it doesn't
really matter as it's trivial to add new numbers.

> +	__u32 sampleRatesSupported[MAX_NUM_RATES];
> +	__u32 numSampleRatesSupported;
> +	__u32 minBitRate;
> +	__u32 maxBitRate;
> +	__u32 isBitrateRangeContinuous;

Should we use the existing ALSA rate constants and whatnot for the
sample rate here?
