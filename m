From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: Update ABI with
 improvements for TLV, operations and private data.
Date: Wed, 05 Aug 2015 12:43:02 +0100
Message-ID: <1438774982.16660.32.camel@loki>
References: <1438769467-18729-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150805112907.GI20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C1A40265D97
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 13:43:09 +0200 (CEST)
In-Reply-To: <20150805112907.GI20873@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-08-05 at 12:29 +0100, Mark Brown wrote:
> On Wed, Aug 05, 2015 at 11:11:07AM +0100, Liam Girdwood wrote:
> > From: Mengdong Lin <mengdong.lin@intel.com>
> > 
> > This is the kernel patch - a corresponding alsa-lib patch has also been sent.
> 
> This patch introduces multiple changes and should really have been sent
> separately.  Please also try to keep your commit messages and especially
> subject lines under 80 colummns so that they are legible.
> 

The concern with multiple patches is that it's more likely to break
runtime bisection/alignment with userspace (but I guess we have that
anyway now), hence the squashing into a single patch for userspace and
kernel.

I'll rework into six patches (three kernel and three userspace).


> > Removed the following fields from topology TLV struct:
> > - size/count: type can decide the size.
> 
> >  struct snd_soc_tplg_ctl_tlv {
> > -	__le32 size;	/* in bytes aligned to 4 */
> > -	__le32 numid;	/* control element numeric identification */
> > -	__le32 count;	/* number of elem in data array */
> > -	__le32 data[SND_SOC_TPLG_TLV_SIZE];
> > +	__le32 size;	/* in bytes of this structure */
> > +	__le32 type;	/* SNDRV_CTL_TLVT_*, type of TLV */
> > +	union {
> > +		struct snd_soc_tplg_tlv_dbscale scale;
> > +	};
> 
> The combination of removing size fromm the struct and not having data
> means that we can't in the future add a new type which has a larger size
> than the current one without confusing older systems (Rather than just
> having them drop the TLV information).  I'm not sure how likely that
> really is but it's a consideration.

Oh, data should have still been in there. Size just had it's comment
fixed to match the other size usage in the other structures.

Liam
