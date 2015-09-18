From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: wm0010: disable regulator on error
Date: Fri, 18 Sep 2015 18:12:05 +0530
Message-ID: <20150918124205.GA28272@sudip-pc>
References: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150918113412.GF7694@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150918113412.GF7694@ck-lbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 12:34:12PM +0100, Charles Keepax wrote:
> On Fri, Sep 18, 2015 at 04:02:19PM +0530, Sudip Mukherjee wrote:
> > We have done regulator_bulk_enable() while booting the DSP but on the
> > error exit path we have not disbled it.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >  sound/soc/codecs/wm0010.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> > index 8434d45..79a7cd3 100644
> > --- a/sound/soc/codecs/wm0010.c
> > +++ b/sound/soc/codecs/wm0010.c
> > @@ -739,8 +739,6 @@ static int wm0010_boot(struct snd_soc_codec *codec)
> >  abort:
> >  	/* Put the chip back into reset */
> >  	wm0010_halt(codec);
> > -	mutex_unlock(&wm0010->lock);
> > -	return ret;
> 
> Does wm0010_halt not disable the regulators?
oops, yes, it does. Sorry I should have seen it before posting.
patch 2/3 and 3/3 will still apply even if this 1/3 is not applied.
Should I send a v2 leaving out this patch or is it ok to discard this
patch while applying?

regards
sudip
