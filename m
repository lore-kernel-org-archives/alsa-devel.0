From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/15] ASoC: dapm: Add locked version
	of	snd_soc_dapm_xxxx_pin functions
Date: Tue, 18 Feb 2014 09:04:54 +0000
Message-ID: <20140218090454.GA18502@opensource.wolfsonmicro.com>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392655903-24537-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <5302417B.3070408@metafoo.de> <20140218003030.GH2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6253126514B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 10:04:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140218003030.GH2669@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, eric.y.miao@gmail.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 18, 2014 at 09:30:30AM +0900, Mark Brown wrote:
> On Mon, Feb 17, 2014 at 06:06:03PM +0100, Lars-Peter Clausen wrote:
> 
> > Hm, this is a bit confusing. For other functions in ASoC when we
> > have a pair of functions with the _locked suffix and without the one
> > with _locked takes the lock, the other one doesn't. E.g.
> > snd_soc_update_bits_locked. Here we do it the other way around.
> 
> Yes, this is definitely confusing.  The existing naming might not be the
> best but making things inconsistent isn't going to help the situation
> either.

Oops... sorry that was not intentional I will respin to correct
this.

Thanks,
Charles

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
