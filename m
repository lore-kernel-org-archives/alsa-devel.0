From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Fri, 3 Sep 2010 10:55:32 +0300
Message-ID: <20100903105532.07894824.jhnikula@gmail.com>
References: <20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
	<20100824101032.GA15278@rakim.wolfsonmicro.main>
	<20100825135922.5589ba30.jhnikula@gmail.com>
	<20100826133229.GA3803@opensource.wolfsonmicro.com>
	<20100830141729.75388459.jhnikula@gmail.com>
	<20100902142518.GA5809@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8976C2454F
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 09:55:11 +0200 (CEST)
Received: by ewy21 with SMTP id 21so834244ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2010 00:55:11 -0700 (PDT)
In-Reply-To: <20100902142518.GA5809@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Sep 2010 15:25:18 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Aug 30, 2010 at 02:17:29PM +0300, Jarkko Nikula wrote:
> 
> > I don't see it are there any problems. For me it looks the routes in
> > WM9090 are unique and registered to own codec instance so there should
> > not be route prefixing needed.
> 
> Meh, right.  DAPM isn't coping with things that cross CODECs really.
> This will need to be looked at.
> 
> > How these amplifier drivers are actually meant to be probed? Currently
> > struct snd_soc_codec_driver->probe is called only from
> > soc_probe_dai_link.
> 
> We need to set up a list of anciliary devices which are registered
> without DAIs for this.

So we need to split these into three separate problems:

- Prefixing
- DAPM linking between codecs
- Registering DAIless codecs in machine drivers

What you think: is it better to hold my prefixing patch until DAPM
linking is solved or can it be applied before? I mean if we need to go
some global, not codec based DAPM, then there is need to prefix but not
if DAPM remains per codec.


-- 
Jarkko
