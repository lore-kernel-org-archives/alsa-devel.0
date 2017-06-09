From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/7] ASoC: intel: byt: Constify
	hw_constraints
Date: Fri, 9 Jun 2017 09:06:21 +0530
Message-ID: <20170609033621.GP2885@localhost>
References: <20170608213725.5378-1-tiwai@suse.de>
 <20170608213725.5378-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BA0E267339
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 05:33:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170608213725.5378-5-tiwai@suse.de>
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

On Thu, Jun 08, 2017 at 11:37:22PM +0200, Takashi Iwai wrote:
> snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
> const pointers.  Constify the corresponding static objects for better
> hardening.
> 

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
