From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/13] ASoC: wm_adsp: Add support for DSP
	control flags
Date: Mon, 20 Apr 2015 09:30:06 +0100
Message-ID: <20150420083006.GG3480@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1428928085-20250-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150418172306.GA26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 495B126548B
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 10:30:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150418172306.GA26185@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 18, 2015 at 06:23:06PM +0100, Mark Brown wrote:
> On Mon, Apr 13, 2015 at 01:28:03PM +0100, Charles Keepax wrote:
> > The DSP control information contains various hints about the usage of
> > the controls use these when handling the control.
> 
> > @@ -418,6 +419,9 @@ static int wm_coeff_put(struct snd_kcontrol *kcontrol,
> >  	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
> >  	char *p = ucontrol->value.bytes.data;
> >  
> > +	if (ctl->flags && !(ctl->flags & WMFW_CTL_FLAG_WRITEABLE))
> > +		return -EPERM;
> > +
> >  	memcpy(ctl->cache, p, ctl->len);
> >  
> >  	ctl->set = 1;
> 
> What would be even better for these would be to apply these at control
> creation time so that controls that lack read or write support just
> don't have the relevant operations in the first place.  That would not
> be simpler and would allow the rest of the stack to do the right thing,
> for example setting SNDRV_CTL_ELEM_ACCESS_READ and _WRITE properly.

That is indeed much more sensible I will respin this patch.

Thanks,
Charles
