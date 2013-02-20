From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: arizona: Tidy up SYNCCLK
	selection and cache	values
Date: Wed, 20 Feb 2013 16:53:05 +0000
Message-ID: <20130220165305.GA14994@opensource.wolfsonmicro.com>
References: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1361376579-29051-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130220163106.GG2726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C337726171D
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:53:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130220163106.GG2726@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 20, 2013 at 04:31:06PM +0000, Mark Brown wrote:
> On Wed, Feb 20, 2013 at 04:09:33PM +0000, Charles Keepax wrote:
> 
> > +	if (fll->ref_src < 0 || fll->ref_src == source) {
> 
> > +	} else if (fll->ref_src != source) {
> 
> > +	}
> 
> This appears to be missing a final error checking case...

Apologies that else if is completely redundant and should just
be an if. I will fix and resend.

Charles
