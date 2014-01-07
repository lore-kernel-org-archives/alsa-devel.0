From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: add num_sample_rates in
	snd_codec_desc
Date: Tue, 7 Jan 2014 22:08:18 +0530
Message-ID: <20140107163818.GB16227@intel.com>
References: <1389111942-20810-1-git-send-email-vinod.koul@intel.com>
 <20140107173510.GD31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FB47264EF3
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:38:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140107173510.GD31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 07, 2014 at 05:35:10PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2014 at 09:55:42PM +0530, Vinod Koul wrote:
> 
> >  struct snd_codec_desc {
> >  	__u32 max_ch;
> >  	__u32 sample_rates[MAX_NUM_SAMPLE_RATES];
> > +	__u32 num_sample_rates;
> >  	__u32 bit_rate[MAX_NUM_BITRATES];
> >  	__u32 num_bitrates;
> >  	__u32 rate_control;
> 
> This is adding a field to the userspace ABI which will break it...  not
> sure if we care or not but it probably ought to be noted in the commit
> log at the very least; people do build things like distros with headers
> from older kernels than the ones they run.
I am not aware is any users of desciptors yet :) so thats why went ahead and
modifed... This is long term plan to query dynamic capablities of device using
this

--
~Vinod
