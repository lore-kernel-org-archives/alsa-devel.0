From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH] ASoC: codecs/sgtl5000.c: specify correct
 reg_stride in regmap_config.
Date: Mon, 26 Aug 2013 08:18:01 +0200
Message-ID: <20130826081801.6d0dc734@archvile>
References: <1377152584-28317-1-git-send-email-david@protonic.nl>
 <20130825084426.GA10708@zzm-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B412615B9
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 08:17:59 +0200 (CEST)
In-Reply-To: <20130825084426.GA10708@zzm-ubuntu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zengzhaoming <zengzm.kernel@gmail.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, David Jander <david@protonic.nl>
List-Id: alsa-devel@alsa-project.org

On Sun, 25 Aug 2013 16:44:26 +0800
zengzhaoming <zengzm.kernel@gmail.com> wrote:

> On 08-22/08:23, David Jander wrote:
> > This makes the RB-Tree more compact and efficient.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  sound/soc/codecs/sgtl5000.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> > index 760e8bf..ba5ca67 100644
> > --- a/sound/soc/codecs/sgtl5000.c
> > +++ b/sound/soc/codecs/sgtl5000.c
> > @@ -1480,6 +1480,7 @@ static struct snd_soc_codec_driver sgtl5000_driver =
> > { static const struct regmap_config sgtl5000_regmap = {
> >  	.reg_bits = 16,
> >  	.val_bits = 16,
> > +	.reg_stride = 2,
> >  
> >  	.max_register = SGTL5000_MAX_REG_OFFSET,
> >  	.volatile_reg = sgtl5000_volatile,
> > -- 
> > 1.8.1.2
> 
> Fabio has post same patch for this.
> http://comments.gmane.org/gmane.linux.alsa.devel/109903

Oh. I didn't see that one, sorry.
Fabio's patch is from July, 5th. It takes quite some time for this to hit
mainline then....

Best regards,

-- 
David Jander
Protonic Holland.
