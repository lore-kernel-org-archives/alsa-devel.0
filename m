From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: wm5110: Add support for audio
	trace firmware
Date: Fri, 29 Jan 2016 10:14:22 +0000
Message-ID: <20160129101422.GS1490@localhost.localdomain>
References: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1453398782-32198-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160128233422.GI4130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BF68726047B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 11:14:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160128233422.GI4130@sirena.org.uk>
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

On Fri, Jan 29, 2016 at 12:34:22AM +0100, Mark Brown wrote:
> On Thu, Jan 21, 2016 at 05:53:00PM +0000, Charles Keepax wrote:
> 
> > @@ -2163,6 +2187,8 @@ static int wm5110_open(struct snd_compr_stream *stream)
> >  
> >  	if (strcmp(rtd->codec_dai->name, "wm5110-dsp-voicectrl") == 0) {
> >  		n_adsp = 2;
> > +	} else if (strcmp(rtd->codec_dai->name, "wm5110-dsp-trace") == 0) {
> > +		n_adsp = 0;
> >  	} else {
> >  		dev_err(arizona->dev,
> >  			"No suitable compressed stream for DAI '%s'\n",
> 
> I'm a bit unclear on how exactly we're ensuring that the relevant
> firmware is loaded?

So this code is basically just working out which DSP core we
should be opening (at the moment this is fixed a DAI coresponds
to a particular DSP core). At the bottom of the function we call
wm_adsp_compr_open which will check that the firmware supports
compressed operation in the correct direction and will lock out
changes of firmware until compr_free is called.

Thanks,
Charles
