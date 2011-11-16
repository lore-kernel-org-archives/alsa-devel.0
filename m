From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: alc5632: Added support of two
 undocumented registers
Date: Wed, 16 Nov 2011 10:37:40 +0000
Message-ID: <20111116103739.GC3072@opensource.wolfsonmicro.com>
References: <1321438023-29660-1-git-send-email-leon@leon.nu>
	<1321438023-29660-6-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9228624471
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:37:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321438023-29660-6-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 12:07:02PM +0200, Leon Romanovsky wrote:

> +	{ 124, 0x0000 },	/* R124 - Vendor ID1 (Undocumented) */
> +	{ 125, 0x0000 },	/* R124 - Vendor ID2 (Undocumented) */

As these are volatile registers you don't need to provide defaults and
doing so might cause confusion.
