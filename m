From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Add support for
	SNDRV_PCM_RATE_KNOT
Date: Thu, 4 Feb 2016 12:46:44 +0000
Message-ID: <20160204124644.GW1490@localhost.localdomain>
References: <1454431084-21411-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160202193002.GV4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 39DB02619E3
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:46:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160202193002.GV4455@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 02, 2016 at 07:30:02PM +0000, Mark Brown wrote:
> On Tue, Feb 02, 2016 at 04:38:04PM +0000, Charles Keepax wrote:
> 
> > +#define ARIZONA_48K_RATES 12000, 24000, 48000, 96000, 192000, 4000, 8000, \
> > +			  16000, 32000
> 
> This just looks wrong.  It's valid code but with the combination of the
> split line and the list without any sort of parenthesis it sets off
> alarm bells.  Duplicating might not be the worst thing ever...

I will respin with just duplicating the rates lists, I am happy
enough with that.

Thanks,
Charles
