From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] Blackfin: bf537: Stamp: Register ASoC
 EVAL-ADAU1373 board driver
Date: Wed, 17 Aug 2011 00:56:07 +0900
Message-ID: <20110816155606.GG15484@opensource.wolfsonmicro.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81B50244BA
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 17:56:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313432124-22591-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 15, 2011 at 08:15:24PM +0200, Lars-Peter Clausen wrote:
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Mike Frysinger <vapier@gentoo.org>

I'm OK with this but may as well go via the blackfin tree as there's no
code dependency on any of the ASoC stuff and it reduces the risk of any
collisions with other blackfin work.  If you guys would prefer that it
goes via ASoC then I can apply it there though.
