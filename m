From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da7218: Fix incorrect usage of
 bitwise '&' operator for SRM check
Date: Wed, 3 May 2017 14:19:51 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142AAE96A@SW-EX-MBX01.diasemi.com>
References: <20170503135406.5EA1E3FB6C@swsrvapps-01.diasemi.com>
 <e03173b7-3ec5-7971-c996-7b9803cd0936@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 798A82667FE
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 16:19:55 +0200 (CEST)
In-Reply-To: <e03173b7-3ec5-7971-c996-7b9803cd0936@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03 May 2017 15:10, Takashi Sakamoto wrote:

> On May 3 2017 22:54, Adam Thomson wrote:
> > In the SRM lock check section of code the '&' bitwise operator is
> > used as part of checking lock status. Functionally the code works
> > as intended, but the conditional statement is a boolean comparison
> > so should really use '&&' logical operator instead. This commit
> > rectifies this discrepancy.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  sound/soc/codecs/da7218.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thanks :)

> > diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> > index d256ebf..6e1940e 100644
> > --- a/sound/soc/codecs/da7218.c
> > +++ b/sound/soc/codecs/da7218.c
> > @@ -1457,7 +1457,7 @@ static int da7218_dai_event(struct
> snd_soc_dapm_widget *w,
> >  				++i;
> >  				msleep(DA7218_SRM_CHECK_DELAY);
> >  			}
> > -		} while ((i < DA7218_SRM_CHECK_TRIES) & (!success));
> > +		} while ((i < DA7218_SRM_CHECK_TRIES) && (!success));
> >
> >  		if (!success)
> >  			dev_warn(codec->dev, "SRM failed to lock\n");
> 
> Would you please fix codes for da7213, too?

Thought you may be re-spinning your patch, but that's fine. I'll send an update
for da7213 as well.
