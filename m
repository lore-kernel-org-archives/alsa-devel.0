From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] RFC: ASoC: Davinci: Fix data_type divide
 by zero
Date: Sat, 12 Sep 2009 13:19:17 +0100
Message-ID: <20090912121917.GA4633@sirena.org.uk>
References: <1252547830-16585-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090911103139.GA19204@sirena.org.uk>
	<4AAAC0B6.2010904@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BF1EC1037F2
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 14:19:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AAAC0B6.2010904@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: khilman@deeprootsystems.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 11, 2009 at 02:27:18PM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> >> +	 * dma_params must be first because rtd->dai->cpu_dai->private_data
> >> +	 * is cast to an array of struct davinci_pcm_dma_params ** in
> >> +	 * davinci_pcm_open.
> >> +	 */

> > Is it not possible to deal with this by going through the types
> > properly?  The comment sets off all sorts of alarm bells.

> private_data will be either struct davinci_mcbsp_dev or
> struct davinci_audio_dev

Hrm.  Might be nice to change that :/

> Btw, I'm about to submit another rev of this against your for32
> branch. But your branch currently give compile errors, so it
> my compile test just doesn't generate new errors.

You'll need to merge it with Kevin's branch to build - or wait for -rc1
when everything should've made it into mainline.  Kevin's git has a
branch temp/asoc with the merge done in it.
