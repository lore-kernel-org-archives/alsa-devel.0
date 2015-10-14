From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: soc-compress: add config item for
 soc-compress to make it compiled only when needed
Date: Wed, 14 Oct 2015 13:46:59 +0100
Message-ID: <20151014124659.GN8805@ck-lbox>
References: <1444750860-19355-1-git-send-email-yang.jie@intel.com>
 <20151014092051.GM8805@ck-lbox>
 <E7B1D079BA13FB44A978CC8F69C7D6A9229C6351@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D3012651AC
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 15:06:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A9229C6351@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 14, 2015 at 12:57:38PM +0000, Jie, Yang wrote:
> > >  	int (*suspend)(struct snd_soc_dai *dai);
> > >  	int (*resume)(struct snd_soc_dai *dai);
> > >  	/* compress dai */
> > > -	bool compress_dai;
> > > +	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
> > 
> > This feels a little awkward to be using a function pointer here.
> > It somewhat implies I might want to customise this function but am I every
> > going to want to set this to something other than snd_soc_new_compress?
> 
> Hi Charles, we used compress_dai bool before(in v2), but for that we need
> add empty inline soc_compress_new(), Takashi suggest we use callback
> func pointer here, it can be compress_new or any other creation here.
> This is flexible and can be extended if any new stuff has to be handled.

If everyone else is happy with it, then I don't mind. It
obviously works, just felt a little odd to me.

Thanks,
Charles
