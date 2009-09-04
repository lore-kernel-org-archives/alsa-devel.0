From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: AK4671: add ak4671 codec driver
Date: Fri, 4 Sep 2009 11:19:00 +0100
Message-ID: <20090904101859.GA17522@rakim.wolfsonmicro.main>
References: <4A9FB5C7.5060607@samsung.com>
	<20090903140236.GB1406@rakim.wolfsonmicro.main>
	<4AA06DB5.6060107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67028243FA
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 12:19:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AA06DB5.6060107@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 04, 2009 at 10:30:29AM +0900, Joonyoung Shim wrote:
> On 9/3/2009 11:02 PM, Mark Brown wrote:

> >> +	case SND_SOC_BIAS_STANDBY:
> >> +		if (ak4671->pll_on) {

> > I suspect this will run into trouble with bypass paths (which do appear
> > to exist if I read the DAPM routes correctly).  If a bypass path is
> > active then the CODEC will be brought up to full bias out of sync with
> > any configuration of pll_on by the DAI format configuration.

> A bypass path should operate regardless pll_on.

Yes, I'd expect the bypass path itself to be fine.  What I'm concerned
about is that because with newer ASoC versions the bypass path will
cause the CODEC to change bias levels independantly of playback and
record starting the PLL will be configured when the bypass path is
enabled rather than when record/playback is started.  This may cause
things to get out of sync.
