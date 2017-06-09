From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/7] ASoC: intel: skl: Constify
	hw_constraints
Date: Fri, 9 Jun 2017 09:06:54 +0530
Message-ID: <20170609033654.GQ2885@localhost>
References: <20170608213725.5378-1-tiwai@suse.de>
 <20170608213725.5378-6-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 42211267502
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 05:34:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170608213725.5378-6-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 08, 2017 at 11:37:23PM +0200, Takashi Iwai wrote:
> snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
> const pointers.  Constify the corresponding static objects for better
> hardening.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
