From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Check return value from
 wm_adsp_buffer_init
Date: Tue, 22 Nov 2016 15:28:34 +0000
Message-ID: <20161122152834.GA1867@localhost.localdomain>
References: <1479825975-7219-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <3aa7c6c7-07f8-2463-48d9-a0d5d73f2f82@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A99FC266818
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 16:28:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3aa7c6c7-07f8-2463-48d9-a0d5d73f2f82@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2016 at 05:22:17PM +0200, Takashi Sakamoto wrote:
> Charles,
> 
> On Nov 22 2016 16:46, Charles Keepax wrote:
> > We are not checking the return value from a call to wm_adsp_buffer_init
> > it looks like this used to be returned at the bottom of the function but
> > probably got missed when more error paths were added. This patch adds
> > the appropriate error check.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > ---
> >  sound/soc/codecs/wm_adsp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> > index 6ccb731..7e4f8dd 100644
> > --- a/sound/soc/codecs/wm_adsp.c
> > +++ b/sound/soc/codecs/wm_adsp.c
> > @@ -2580,8 +2580,11 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
> >  
> >  		mutex_lock(&dsp->pwr_lock);
> >  
> > -		if (wm_adsp_fw[dsp->fw].num_caps != 0)
> > +		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
> >  			ret = wm_adsp_buffer_init(dsp);
> > +			if (ret < 0)
> > +				goto err;
> > +		}
> 
> Need to call mutex_unlock() before jumping to err label?
> 

Thanks, will respin.

Thanks,
Charles
