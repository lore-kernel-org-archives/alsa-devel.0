From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 3/4] ASoC: tlv320aic3x: Use regulator
 notifiers for optimizing the cache sync
Date: Mon, 20 Sep 2010 11:38:43 +0100
Message-ID: <20100920103842.GE3414@rakim.wolfsonmicro.main>
References: <1284968354-12536-1-git-send-email-jhnikula@gmail.com>
	<1284968354-12536-4-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5786310384E
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 12:38:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284968354-12536-4-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 20, 2010 at 10:39:13AM +0300, Jarkko Nikula wrote:
> There is no need to reset the codec and perform cache sync if none of the
> supply regulators were not disabled. Patch registers a notifier callback for
> each supply and callback then sets a flag to indicate when cache sync is
> required.
> 
> HW writes are also needless when codec bias is off so cache_only flag is set
> independently of actual supply regulators state.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
