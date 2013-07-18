From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH] ASoC: pcm: Use the power efficient
 workqueue for delayed powerdown
Date: Thu, 18 Jul 2013 12:00:01 +0100
Message-ID: <1374145201.2422.5.camel@loki>
References: <1374144867-25675-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 832732655B3
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 13:00:06 +0200 (CEST)
In-Reply-To: <1374144867-25675-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-07-18 at 11:54 +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> There is no need to use a normal per-CPU workqueue for delayed power downs
> as they're not timing or performance critical and waking up a core for them
> would defeat some of the point.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Liam Girdwood <liam.r.girdwood@intel.com>

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
