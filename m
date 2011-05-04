From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
 codec driver
Date: Wed, 4 May 2011 17:11:21 +0100
Message-ID: <20110504161121.GB10912@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504144600.GA7366@opensource.wolfsonmicro.com>
	<20110504151250.GC1671@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17B93103928
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 18:12:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504151250.GC1671@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Wang, Xingchao" <xingchao.wang@intel.com>, "Koul,
	Vinod" <vinod.koul@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 11:12:50PM +0800, Lu Guanqun wrote:
> On Wed, May 04, 2011 at 10:46:00PM +0800, Dimitris Papastamos wrote:
> > On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:

> > > +	case SND_SOC_BIAS_OFF:
> > > +		snd_soc_write(codec, UPD9976_VREFPLL, 0);
> > > +		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x24);
> > > +		break;
> > > +	}

> > Why not snd_soc_update_bits()?  These should normally be DAPM widgets.

> There's no DAPM widgets bound to these two registers. So I'm afraid it's
> OK to use snd_soc_write when it's been powered off totally.

That's an orthogonal thing, the usual reason for pushing back on this
stuff is that people have open coded a read/modify/write cycle which
only updates a subset of bits.  In this case I think the writes are fine
as you're setting the full register to a specific value.

> > > +static int upd9976_codec_probe(struct snd_soc_codec *codec)
> > > +{
> > > +	upd9976_set_bias_level(codec, SND_SOC_BIAS_OFF);
> > > +
> > > +	return 0;
> > > +}

> > Why SND_SOC_BIAS_OFF and not SND_SOC_BIAS_STANDBY?

> Try to use as little power as possible.

You should set idle_bias_off in the CODEC driver if you're doing this
otherwise DAPM will just bring the CODEC up to _STANDBY at runtime.
