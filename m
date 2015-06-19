From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 0/4] ASoC: intel - add skylake PCM driver
Date: Fri, 19 Jun 2015 22:32:12 +0530
Message-ID: <20150619170212.GN28601@localhost>
References: <1434546055-28866-1-git-send-email-vinod.koul@intel.com>
 <20150619163046.GL14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EC8BE2605B1
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 19:00:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150619163046.GL14071@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2015 at 05:30:46PM +0100, Mark Brown wrote:
> On Wed, Jun 17, 2015 at 06:30:51PM +0530, Vinod Koul wrote:
> > This patch series adds the SKL PCM driver in first two patches and then adds
> > decoupling of the controller for splitting the links in last patch
> 
> This seems broadly fine but I guess there is some interdependency with
> the HDA updates that have been going via Takashi so probably best to
> wait until after the merge window.  There were a few minor coding style
> things - I noticed some if/else statements with braces on only one side
> for example - but nothing major.
Hi Mark,

As mentioned in the cover letter, these are indeed dependent upon HDA
patches in takashi's next. But if you merge them then linux-next build
will not break.

Either ways I would leave upto you and Takashi :) I dont mind if this is
accepted for 4.3 I will check the coding style one again and send updates
on those.

Btw would it be possible to put these in a topic branch in your tree so
that I can send updates and further traffic :)

Thanks
-- 
~Vinod
