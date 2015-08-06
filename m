From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm8731: Drop wm8731_writeable
	function
Date: Thu, 6 Aug 2015 17:24:21 +0100
Message-ID: <20150806162421.GC25225@opensource.wolfsonmicro.com>
References: <1438394622.6442.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEE692604D1
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 18:24:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1438394622.6442.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 01, 2015 at 10:03:42AM +0800, Axel Lin wrote:
> When .max_register is set and .writeable_reg is not implement, registers
> between 0 and .max_register are writeable. This is the same as current
> implementation of wm8731_writeable(), so just drop implementation for
> .writeable_reg callback.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
