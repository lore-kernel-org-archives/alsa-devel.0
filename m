From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: common: Replace custom
 implementation of readq / writeq
Date: Fri, 03 Feb 2017 14:12:05 +0000
Message-ID: <1486131125.2563.3.camel@loki>
References: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F6A9260083
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 15:12:11 +0100 (CET)
In-Reply-To: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-01-31 at 16:14 +0200, Andy Shevchenko wrote:
> The readq() and writeq() helpers are available in the
> linux/io-64-nonatomic-hi-lo.h and linux/io-64-nonatomic-lo-hi.h headers.
> 
> Replace custom implementation by the generic helpers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

All

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
