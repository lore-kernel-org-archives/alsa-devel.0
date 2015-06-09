From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Add basic debugfs entries
Date: Tue, 9 Jun 2015 15:57:07 +0100
Message-ID: <20150609145707.GA27675@opensource.wolfsonmicro.com>
References: <1433774222-25103-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150608174041.GK14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E05CE2606D7
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 16:57:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150608174041.GK14071@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2015 at 06:40:41PM +0100, Mark Brown wrote:
> On Mon, Jun 08, 2015 at 03:37:02PM +0100, Richard Fitzgerald wrote:
> 
> > +++ b/sound/soc/codecs/wm5102.c
> > @@ -1875,6 +1875,8 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
> >  	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
> >  	int ret;
> >  
> > +	wm_adsp_init_debugfs(&priv->core.adsp[0], codec);
> > +
> 
> Why are we adding this init to every individual CODEC rather than doing
> it when we initialize the DSP (which there are calls for already)?
> 
> > +#ifdef CONFIG_DEBUG_FS
> > +static void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp, const char *s);
> > +static void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp, const char *s);
> > +static void wm_adsp_debugfs_clear(struct wm_adsp *dsp);
> > +#else
> > +static inline void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp,
> > +						 const char *s)
> > +{
> > +}
> > +
> > +static inline void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp,
> > +						const char *s)
> > +{
> > +}
> > +
> > +static inline void wm_adsp_debugfs_clear(struct wm_adsp *dsp)
> > +{
> > +}
> > +#endif
> > +
> 
> Why not just put the functions here rather than prototypes?
> 
> > +static ssize_t wm_adsp_debugfs_string_read(struct wm_adsp *dsp,
> > +					  char __user *user_buf,
> > +					  size_t count, loff_t *ppos,
> > +					  const char *string)
> > +{
> > +	char *temp;
> > +	int len;
> > +	ssize_t ret;
> > +
> > +	if (!string || !dsp->running)
> > +		return 0;
> 
> Does debugfs ensure that the right thing happens and this gets treated
> as EOF rather than a "zero length read, please retry" (which something
> might decide to busy wait trying)?  I'd have expected either an error or
> substituting in an empty/informative string here.
> 

If simple_read_from_buffer() is off the end of the buffer or count is 0
it returns 0 not EOF.
Also I checked procfs for cases where things aren't always valid and it returns 0.
So this seems to be accepted behaviour.

> > +	temp = kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!temp)
> > +		return -ENOMEM;
> > +
> > +	len = snprintf(temp, PAGE_SIZE, "%s\n", string);
> 
> Given that we already have the string I don't understand why we're
> allocating the temporary buffer - if it's just the length we're looking
> for then strlen() should be enough?
> 
> > +} wm_adsp_debugfs_fops[] = {
> > +	{
> > +		.name = "wmfw_file",
> 
> > +		.name = "bin_file",
> 
> Bikeshedding but _name not _file perhaps?  It's not going to give you a
> copy of the firmware/coefficients.
