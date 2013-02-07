From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Thu, 7 Feb 2013 08:51:28 -0800
Message-ID: <20130207165128.GT3143@intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <37A133201056E44A80888420ECA881BF1093DC5F68@EXCMB2.wolfsonmicro.main>
 <20130207011518.GA30348@opensource.wolfsonmicro.com>
 <20130207021807.GM3143@intel.com> <s5ha9rg5x0e.wl%tiwai@suse.de>
 <20130207113738.GA15824@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6289026501D
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 18:16:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130207113738.GA15824@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 07, 2013 at 11:37:38AM +0000, Richard Fitzgerald wrote:
> > > 1) Send SNDRV_COMPRESS_NEXT_TRACK
> > > 2) Send SNDRV_COMPRESS_DRAIN
> > The problem would be in that case the defination of SNDRV_COMPRESS_DRAIN which
> > expects the decoder to completely drain its buffers and come to complete halt.
> > This would also mean the framework will treat a drained stream as stopped and
> > needs a new start. Certainly we dont want that in this case. So we can't use
> > SNDRV_COMPRESS_DRAIN to indicate. Yes we can put conditional check but IMO that
> > would overtly complicate this. If we are not doing proper drian lets not
> > call it that.
> 
> Ok, so let's keep the partial drain but split out the NEXT_TRACK hint so we keep
> the two operations separate. It's clearer to understand. NEXT_TRACK tells DSP to
> prepare for data for new track, PARTIAL_DRAIN asks DSP when it has played all
> data of current track. I don't think that application _must_ drain when doing
> gapless, only if it cares to know when DSP reaches the join between tracks.
If we split this then I dont see why next write/meta_data call should wait. Then
the PARTIAL_DRAIN should be used for knowing in userpsace that switch happened,
right?

> Possible problem - application calls NEXT_TRACK and PARTIAL_DRAIN when DSP has
> already reached end of current track, so what does PARTIAL_DRAIN mean in this
> case? 
It should just return immediately, and if your output is starved you are in
error state, that can happen when you dont give data as well.

> Also can we make metadata a key-pair list as Takashi suggested, with unlimited
> length. Something like
> 
> struct snd_compr_metadata_pair {
> 	enum snd_compr_metadata_key key;
> 	u32 value;
> };
No enums... Thats not how kernel ABI is designed.
I am leaning towards key/value pair, but is this fair assumption that value is
always 32bit, what if we have larger single value, then should we split?

> 
> struct snd_compr_metadata {
> 	int count; /* number of actual entries in following array */
> 	struct snd_compr_metadata_pair *pairs;
> };
> 
> Should we union the u32 value with a u8* buf to allow for any case where the
> value needs to be a buffer of binary data? Is there any known case like this?
Again nope, that aint good from ABI POV.

What I think it should be is:

enum {
	SNDRV_COMPRESS_ENCODER_PADDING = 1,
	SNDRV_COMPRESS_ENCODER_DELAY = 2,
};

struct snd_compr_metadata {
	u32 key;
	u32 value;
};

--
~Vinod
