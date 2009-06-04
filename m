From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 09:14:59 +0100
Message-ID: <20090604081458.GA29926@n2100.arm.linux.org.uk>
References: <200906032341.03266.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 21C6B2443D
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:15:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906032341.03266.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 11:41:03PM +0200, Marek Vasut wrote:
> +#include <mach/gpio.h>

should be linux/gpio.h
