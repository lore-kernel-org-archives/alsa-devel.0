From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 4/5] ASoC: compress: Prevent multicodec
 for compressed stream
Date: Mon, 7 Jul 2014 14:20:20 +0530
Message-ID: <20140707085020.GX2296@intel.com>
References: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
 <1404490075-24997-5-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id CD7222654B7
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 10:52:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1404490075-24997-5-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2014 at 06:07:54PM +0200, Benoit Cousson wrote:
> Multiple codecs does not make sense in the case of compressed
> stream.
> 
> Exit with error if it happens.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
