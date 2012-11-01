From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: limitations on number of alsa controls for a card
Date: Thu, 01 Nov 2012 20:16:51 +0530
Message-ID: <1351781211.7077.44.camel@vkoul-udesk3>
References: <1351692451.7077.40.camel@vkoul-udesk3>
 <20121101142558.GF4413@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D02FA26173C
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 16:00:41 +0100 (CET)
In-Reply-To: <20121101142558.GF4413@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Liam <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-11-01 at 14:25 +0000, Mark Brown wrote:
> On Wed, Oct 31, 2012 at 07:37:31PM +0530, Vinod Koul wrote:
> 
> > Is there any limitation on maximum number of controls we can have.
> 
> > I had some platform side controls to represent DSP and adding them made
> > some of codec controls to vanish. And looks like if I register these
> > platform controls not all codec controls are visible in userpsace.
> > Is there nay max limit I am hitting?
> 
> Not that I'm aware of beyond sizeof() type stuff which you're probably
> still a way away from.  How are you listing the controls and are there
> any name collisons?
alsa_amixer -c"cardname" controls

if there isn't anything in kernel which limits this, would there be
something in alsa-lib to have this kind of behavior?

-- 
~Vinod
