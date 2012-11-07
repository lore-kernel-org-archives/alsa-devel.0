From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4271: free allocated GPIO
Date: Wed, 7 Nov 2012 14:07:20 +0000
Message-ID: <20121107140720.GB28954@opensource.wolfsonmicro.com>
References: <1352294155-6733-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66E6926501A
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 15:17:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1352294155-6733-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Alexander Sverdlin <subaparts@yandex.ru>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 07, 2012 at 02:15:55PM +0100, Daniel Mack wrote:
> In case of probe deferral, the allocated GPIO line is not freed, which
> prevents it from being claimed and properly asserted in later attempts.
> 
> Fix this by freeing the GPIO in case of errors.

Can we convert to devm_gpio_request_one() instead?
