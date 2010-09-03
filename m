From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Fri, 03 Sep 2010 11:00:57 +0100
Message-ID: <1283508057.3069.46.camel@odin>
References: <20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
	<20100824101032.GA15278@rakim.wolfsonmicro.main>
	<20100825135922.5589ba30.jhnikula@gmail.com>
	<20100826133229.GA3803@opensource.wolfsonmicro.com>
	<20100830141729.75388459.jhnikula@gmail.com>
	<20100902142518.GA5809@rakim.wolfsonmicro.main>
	<20100903105532.07894824.jhnikula@gmail.com>
	<20100903093345.GA16587@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8433D2438E
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 12:01:00 +0200 (CEST)
Received: by wwi17 with SMTP id 17so1871950wwi.20
	for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2010 03:01:00 -0700 (PDT)
In-Reply-To: <20100903093345.GA16587@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-03 at 10:33 +0100, Mark Brown wrote:
> On Fri, Sep 03, 2010 at 10:55:32AM +0300, Jarkko Nikula wrote:
> 
> > So we need to split these into three separate problems:
> 
> > - Prefixing
> > - DAPM linking between codecs
> > - Registering DAIless codecs in machine drivers
> 
> > What you think: is it better to hold my prefixing patch until DAPM
> > linking is solved or can it be applied before? I mean if we need to go
> > some global, not codec based DAPM, then there is need to prefix but not
> > if DAPM remains per codec.
> 
> Well, the DAPM map needs to be global in some sense since it needs to
> flow between CODECs and we need board widgets which are definitely not
> fixed on an individual chip.  
> 
> I think I'd like a firm idea of how the cross device DAPM works before
> we do anything with the prefixes since there's some overlap there (if
> only due to the fact that half the controls come from DAPM), even if the
> cross device DAPM doesn't actually work yet.  I think your current code
> is probably going to work well with DAPM but I need to have a bit of a
> think about that over the weekend.

I've made some initial progress here with DAPM by de-coupling it from
CODEC drivers. So I now have a struct dapm_context * in the codec,
platform and machine drivers. I just now need to get some time to
experiment with the best way to hook them all up.

It's currently in my L24.9 branch, although the patches are in need of
clean up and squashing so are not ready for upstream yet.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
