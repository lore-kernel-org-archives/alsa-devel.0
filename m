From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: ac97: Support multi-platform AC'97
Date: Wed, 26 Jun 2013 11:56:34 -0600
Message-ID: <51CB2B52.8030508@wwwdotorg.org>
References: <1372247296-17108-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EFC5261619
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 19:56:38 +0200 (CEST)
In-Reply-To: <1372247296-17108-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 06/26/2013 05:48 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Currently we can only have a single platform built in with AC'97 support
> due to the use of a global variable to provide the bus operations. Fix
> this by making that variable a pointer and having the bus drivers set the
> operations prior to registering.
> 
> This is not a particularly good or nice approach but it avoids blocking
> multiplatform and a real fix involves fixing the fairly deep problems
> with AC'97 support - we should be converting it to a real bus.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
