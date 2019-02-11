From: Peter Seiderer <ps.report@gmx.net>
Subject: Re: [RFC v1] tlv320aic32x4: delay i2c access by 1 ms after hardware
 reset
Date: Mon, 11 Feb 2019 22:02:30 +0100
Message-ID: <20190211220230.7cd7b559@gmx.net>
References: <20190210154519.2506-1-ps.report@gmx.net>
        <20190211150425.GE22391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211150425.GE22391@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, b-ak <anur.bhargav@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On Mon, 11 Feb 2019 15:04:25 +0000, Mark Brown <broonie@kernel.org> wrote:

> On Sun, Feb 10, 2019 at 04:45:19PM +0100, Peter Seiderer wrote:
> 
> > @@ -972,6 +972,8 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
> >  		gpio_set_value(aic32x4->rstn_gpio, 1);
> >  	}
> >  
> > +	mdelay(1);
> > +  
> 
> Perhaps only do this if we toggled the GPIO?  If the device wasn't in
> reset then there's no need to wait.

You are absolutely right with this, will re-spin the patch with
the suggested change, thanks for review...

Regards,
Peter
