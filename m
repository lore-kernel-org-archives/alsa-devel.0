From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/5] ASoC: Correct typo in
	SOC_VALUE_ENUM_SINGLE	macro
Date: Mon, 4 May 2015 15:23:54 +0100
Message-ID: <20150504142354.GZ3480@opensource.wolfsonmicro.com>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150504120341.GI15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B980260534
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 16:23:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150504120341.GI15510@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 04, 2015 at 01:03:41PM +0100, Mark Brown wrote:
> On Fri, May 01, 2015 at 12:37:23PM +0100, Charles Keepax wrote:
> 
> > Changes since v2:
> >  - Use snd_soc_enum_item_to_val to get zero value from mux to account for
> >    non-value enums
> >  - Improve handling in snd_soc_dapm_put_enum_double of the situation
> >    where the register and widget views of the control values don't match
> > 
> > Thanks,
> > Charles
> > 
> >  include/sound/soc.h |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> This list of changes doesn't appear to have anything to do with this
> patch?

Sorry, I probably should have either added a cover letter or put
those on patch 4 that is the patch they relate to.

Thanks,
Charles
