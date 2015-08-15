From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 09/10] ASoC: topology: Change stream
 formats to bitwise flag
Date: Sat, 15 Aug 2015 13:49:42 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D04D0@SHSMSX101.ccr.corp.intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <b9a7ab97e4b4f96cced9faa2e2bce2b533d25a10.1439217448.git.mengdong.lin@intel.com>
 <20150814203428.GR10748@sirena.org.uk> <s5ha8ttypc1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F3129261522
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 15:49:47 +0200 (CEST)
In-Reply-To: <s5ha8ttypc1.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Saturday, August 15, 2015 3:38 PM

> On Fri, 14 Aug 2015 22:34:28 +0200,
> Mark Brown wrote:
> >
> > On Mon, Aug 10, 2015 at 10:48:37PM +0800, mengdong.lin@intel.com
> wrote:
> >
> > >  struct snd_soc_tplg_stream_caps {
> > >  	__le32 size;		/* in bytes of this structure */
> > >  	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> > > -	__le64 formats[SND_SOC_TPLG_MAX_FORMATS];	/* supported
> formats SNDRV_PCM_FMTBIT_* */
> > > +	__le64 formats;	/* supported formats SNDRV_PCM_FORMAT_* */
> >
> > Argh, this is *another* ABI change which you've buried in the middle
> > of a series you're sending right at the end of the release cycle (this
> > was sent after -rc6, we may not even get a -rc7...).  Given how close
> > we are to the release and the invasiveness of the changes in this
> > series it's very lucky I even saw it before release, I'm reading this
> > on my flight to Plumbers which means my bandwidth next week will be
> limited.
> 
> Thanks for checking this.  Mengdong, if there is a change in uapi/*, this
> means touching ABI.  So, this change isn't acceptable once when the kernel
> is released.  At least, the backward compatibility *must* be kept no matter
> which version is.

Thanks for your review, Mark and Takashi. 
This series including the ABI change, is not for v4.2, but is an RFC to adding DAI/DAI links support in topology.
I'm sorry that I should have explicitly said this in my comments.

Is there some topic branch which can accept topology patches for next kernel release?
Can we change topology ABI in v4.3?

Now only Intel SKL driver is using topology code, so the affect should be limited.
And I feel using bitwise flag is simpler in both user space and in kernel coding.
We can increase the topology ABI number when there is ABI change, and the topology driver always checks this version.

> Also, the patch (and even the current code) looks wrong.  The current
> formats[] would receive SNDRV_PCM_FORMAT_* while the comment shows
> SNDRV_PCM_FMT_BIT_*.  And your patch changes it again wrongly in the
> comment.  Quite confusing.

Sorry. I will change the comments.
I hope to change "formats" to a bitwise flag of _SNDRV_PCM_FMTBIT_*.
Current upstreamed topology driver does not really handle DAIs (streams caps) so the error is not discovered.

> > This should have at the very least been sent at the start of the
> > series, and really should have been sent separately.  It is also
> > worrying that there is nothing in the subject or changelog talking
> > about the fact that this is an ABI change or explaining why it is
> > required.  The changelog was simply a statement of the content of the diff,
> not a rationale:
> >
> > | The toplogy user space tool will generate this bitwise flag by using
> > | SNDRV_PCM_FORMAT_* exposed by asound.h, and the topology core will
> > | copy this flag when generating DAI streams.
> >
> > Once the release goes out this sort of incompatible change will be
> > unacceptable.  Given the number of changes that are going into the ABI
> > (we also had some others went in last week) I'm now giving some
> > serious thought to the idea that we should ask Linus to revert the
> > topology code for v4.2 and waiting for v4.3 so we've got more chance
> > to make sure the ABI is one we actually want to stick with.  Liam,
> > Takashi I don't know what you think?
> 
> We can make the topology stuff disabled in Makefile (and the only call in
> soc-core.c) instead of the whole revert.  This will be the minimal impact and
> safe enough.
> 
> BTW, I wonder why there is no Kconfig for topology stuff.  If we had it, it
> would have been easy to disable.

We'll add Kconfig for topology. 

Thanks
Mengdong
