From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: dapm: Only clear paths we've walked
Date: Mon, 01 Apr 2013 17:54:59 +0100
Message-ID: <1364835299.2416.11.camel@loki>
References: <1364817085-8202-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 25928264F40
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2013 18:55:33 +0200 (CEST)
In-Reply-To: <1364817085-8202-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-04-01 at 12:51 +0100, Mark Brown wrote:
> From: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
> 
> When clearing the walked flags there is no need to clear all paths, we
> only need to clear the paths we actually walked. This means we can split
> dapm_clear_walk() into input and output versions and rather than going
> through all DAPM paths we can recurse down the path until we encounter
> paths we have not yet walked.
> 
> This reduces the number of operations we need to perform and improves
> cache locality.
> 
> [Pulled out of the vendor tree that the patch was originally generated
> for by me, any bugs were introduced in that process -- broonie]
> 
> Signed-off-by: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
