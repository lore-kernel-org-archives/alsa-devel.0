From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 4/8] ASoC: wm_adsp: Add support for
 opening a compressed stream
Date: Wed, 23 Dec 2015 10:00:44 +0000
Message-ID: <20151223100044.GZ6058@localhost.localdomain>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151223001456.GH16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 43FC0265705
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 11:00:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151223001456.GH16023@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 23, 2015 at 12:14:56AM +0000, Mark Brown wrote:
> On Tue, Dec 15, 2015 at 11:29:45AM +0000, Charles Keepax wrote:
> 
> > +int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
> > +{
> > +	struct wm_adsp_compr *compr;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&dsp->pwr_lock);
> > +
> > +	if (wm_adsp_fw[dsp->fw].num_caps == 0) {
> > +		adsp_err(dsp, "Firmware does not support compressed API\n");
> > +		ret = -ENXIO;
> > +		goto out;
> > +	}
> > +
> > +	if (wm_adsp_fw[dsp->fw].compr_direction != stream->direction) {
> > +		adsp_err(dsp, "Firmware does not support stream direction\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
> 
> You're doing this under lock but not checking for an attempt to allocate
> on a DSP already in use.

A check does actually get added later in:

ASoC: wm_adsp: Attach buffers and streams together

I think that is really just a bit of a rebasing messup. I will
pull that forward into this patch for the next spin.

Thanks,
Charles
