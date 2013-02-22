From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: dapm: Fix handling of loops
Date: Fri, 22 Feb 2013 21:41:54 +0000
Message-ID: <1361569314.2567.13.camel@loki>
References: <1361555534-6811-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B52CF262625
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 22:42:07 +0100 (CET)
In-Reply-To: <1361555534-6811-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-02-22 at 17:52 +0000, Mark Brown wrote:
> Currently if a path loops back on itself we correctly skip over it to
> avoid going into an infinite loop but this causes us to ignore the need
> to power up the path as we don't count the loop for the purposes of
> counting inputs and outputs. This means that internal loopbacks within a
> device that have powered devices on them won't be powered up.
> 
> Fix this by treating any path that is currently in the process of being
> recursed as having a single input or output so that it is counted for
> the purposes of power decisions.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
