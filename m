From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: Remove needless prints from
	machine drivers
Date: Wed, 6 Oct 2010 08:43:34 -0700
Message-ID: <20101006154334.GD2803@opensource.wolfsonmicro.com>
References: <1286372846-10238-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4CFC5103981
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 17:43:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286372846-10238-1-git-send-email-jhnikula@gmail.com>
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

On Wed, Oct 06, 2010 at 04:47:26PM +0300, Jarkko Nikula wrote:
> It is currently completely normal to execute these machine drivers code on
> different boards if the kernel includes support for multiple boards so no
> error message should be printed if the machine_is_xxx does not match with
> the machine driver.
> 
> Therefore remove these pr_err and pr_debug prints in those cases.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
