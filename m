From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Skylake: Make local
	functions static
Date: Mon, 4 Dec 2017 14:20:53 +0530
Message-ID: <20171204085052.GF32417@localhost>
References: <20171204050012.21498-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B1E38266C5E
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 09:47:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171204050012.21498-1-guneshwor.o.singh@intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 04, 2017 at 10:30:11AM +0530, Guneshwor Singh wrote:
> Some functions are local to the source and do not need to be in global
> scope, so make them static.

Both:

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
