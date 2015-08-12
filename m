From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Wed, 12 Aug 2015 02:03:52 -0700
Message-ID: <20150812090351.GA6916@Asurada>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
 <20150812034257.GA2980@Asurada-CZ80>
 <20150812044505.GA21786@shlinux2>
 <20150812064053.GA2807@Asurada-CZ80>
 <20150812073859.GB21786@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA37260438
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 11:04:02 +0200 (CEST)
Received: by pdrh1 with SMTP id h1so5344434pdr.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 02:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150812073859.GB21786@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2015 at 03:39:00PM +0800, Zidan Wang wrote:

> > > > > -	priv->dai_link[0].codec_dai_name = codec_dev->name;
> > > > > +	if (strstr(codec_dev->name, "wm8960"))
> > > > > +		priv->dai_link[0].codec_dai_name = "wm8960-hifi";
> > > > > +	else
> > > > > +		priv->dai_link[0].codec_dai_name = codec_dev->name;
> > 
> > > > What happens to the codec_dev->name over here so that you need to
> > > > specify the name?
> > > In wm8960 codec driver, codec dai name is "wm8960-hifi".
> > > Using codec_dev->name will cauce register card failed.
> > 
> > When we meet a problem, the first response should be to find out
> > the route cause instead of fixing it with a work around directly.
> > If the codec_dev->name caused a card registration failure, you
> > need to find out why. There must be something wrong with its codec
> > driver or this sound card driver.
> > 
> The root cause is that the codec dai name is not always be codec_dev->name.
> It will cause the sound card can't find such codec dai. You can refer to
> function snd_soc_find_dai().
> For wm8962 the codec dai name and codec_dev->name are "wm8962". But some
> other codec like wm8960, it may have different codec dai name.

Then we should fix this by finding out a better way to get the dai
name. I will look into it tomorrow.
