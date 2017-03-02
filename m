From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: hdac_hdmi: avoid reference to
 invalid variable of the pin list
Date: Thu, 2 Mar 2017 14:22:55 +0530
Message-ID: <20170302085255.GQ2843@localhost>
References: <1488388284-11227-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 75590266A8A
 for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2017 09:52:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1488388284-11227-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 01, 2017 at 10:41:23PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> Using pin list array iterator outside the iteration of the list can
> point to dummy element, which can be invalid. So don't use pin variable
> outside the pin list iteration.
> 
> This fixes the following coccinelle warning:
> sound/soc/codecs/hdac_hdmi.c:1419:5-8: ERROR: invalid reference to the
> index variable of the iterator
> 
> Fixes: 2acd8309a3a4('ASoC: hdac_hdmi: Add support to handle MST capable pin')
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Jeeja KP <jeeja.kp@intel.com>

Both:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
