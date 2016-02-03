From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Add support for
 SNDRV_PCM_RATE_KNOT
Date: Wed, 3 Feb 2016 09:41:13 +0000
Message-ID: <20160203094113.GT1490@localhost.localdomain>
References: <1454431084-21411-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160202193002.GV4455@sirena.org.uk> <56B1B939.5030503@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 206152614CB
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 10:41:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56B1B939.5030503@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 03, 2016 at 09:24:25AM +0100, Lars-Peter Clausen wrote:
> On 02/02/2016 08:30 PM, Mark Brown wrote:
> > On Tue, Feb 02, 2016 at 04:38:04PM +0000, Charles Keepax wrote:
> > 
> >> +#define ARIZONA_48K_RATES 12000, 24000, 48000, 96000, 192000, 4000, 8000, \
> >> +			  16000, 32000
> > 
> > This just looks wrong.  It's valid code but with the combination of the
> > split line and the list without any sort of parenthesis it sets off
> > alarm bells.  Duplicating might not be the worst thing ever...
> 
> For list constraints it is possible to specify a mask for which of the
> entries in the rates array should be considered. So you could use the same
> rate array, but use different masks. The adau1977 drive for example does this.
> 
> 

Thanks wasn't aware of that I will have a look and respin the
patch.

Thanks,
Charles
