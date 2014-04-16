From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: Using simple-card to replace kirkwood-t5325.c
Date: Wed, 16 Apr 2014 13:13:33 +0200
Message-ID: <20140416111333.GA11310@lunn.ch>
References: <20140415161302.GC1871@lunn.ch>
 <534D7D31.6040802@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 62D3326517B
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 13:15:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <534D7D31.6040802@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, Jean Delvare <khali@linux-fr.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 15, 2014 at 08:40:49PM +0200, Lars-Peter Clausen wrote:
> On 04/15/2014 06:13 PM, Andrew Lunn wrote:
> >Hi Folks
> 
> Adding a few people to Cc.
> 
> >
> >I'm an ALSA newbie, so if i say anything stupid, please let me know.
> >
> >I'm trying to replace sound/soc/kirkwood/kirkwood-t5325.c with DT,
> >using simple-card. I can get near, but i'm missing two things:
> >
> >There does not appear to be a way to represent this in DT:
> >
> >static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
> >{
> >	struct snd_soc_codec *codec = rtd->codec;
> >	struct snd_soc_dapm_context *dapm = &codec->dapm;
> >
> >	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
> >	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
> >	snd_soc_dapm_enable_pin(dapm, "Speaker");
> >
> >	return 0;
> >}
> >
> >It appears that quite a few drivers need to enable pins.
> 
> I'm not sure where this got started, but this mostly seems to be
> cargo-culting. External pins are enabled by default, there is no
> need to call snd_soc_dapm_enable_pin() unless
> snd_soc_dapm_disable_pin() has been called before for the same pin.

Ah, thanks for saying this. I just tested without, and all is good.

Thanks
	Andrew
