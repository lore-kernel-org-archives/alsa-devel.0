From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: Intel: Skylake: Reset the
	controller in probe
Date: Sat, 29 Jul 2017 10:05:28 +0530
Message-ID: <20170729043527.GZ3053@localhost>
References: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E77B266A51
 for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2017 06:32:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 28, 2017 at 04:12:13PM +0530, Guneshwor Singh wrote:
> Controller can be in reset state by default. Capability structure
> traversal requires the controller to be out of reset else it
> results in broken capability parsing. Hence make sure that controller is
> out of reset before parsing capabilities by doing a full reset.

Good series and nice changelogs...

Whole series:

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
