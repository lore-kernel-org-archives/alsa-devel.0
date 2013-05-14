From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Move
 snd_soc_set_runtime_hwparams() to soc-pcm.c
Date: Tue, 14 May 2013 11:37:43 +0100
Message-ID: <1368527863.2508.13.camel@loki>
References: <1368522332-15624-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B7C52607BA
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 12:37:51 +0200 (CEST)
In-Reply-To: <1368522332-15624-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-05-14 at 11:05 +0200, Lars-Peter Clausen wrote:
> snd_soc_set_runtime_hwparams() is the only PCM related function that lives in
> soc-core.c. All other PCM related functions live in soc-pcm.c, so move
> snd_soc_set_runtime_hwparams() over as well for a bit more consistency.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

All 

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
