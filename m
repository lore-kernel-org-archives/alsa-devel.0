From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Thu, 23 Apr 2009 09:24:49 +0100
Message-ID: <20090423082449.GC30105@sirena.org.uk>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DCE66103838
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 10:24:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 01:06:12PM +0800, Eric Miao wrote:
> Actually, due to the number of possible SSP configurations, it's quite a
> difficult job to maintain an API that can be well re-used. The guideline
> here is to keep only a list of SSP devices and their basic information,
> and it's up to the user driver (like SPI or Audio SSP) to configure the
> SSP in a desired way.

This looks fine to me

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
