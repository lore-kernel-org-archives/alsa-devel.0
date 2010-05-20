From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: TWL6040: Fix playback with
	19.2	Mhz MCLK
Date: Fri, 21 May 2010 00:44:06 +0100
Message-ID: <20100520234405.GA6363@sirena.org.uk>
References: <1274395988-19801-1-git-send-email-jorge.candelaria@ti.com>
	<1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B42AA103816
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 01:44:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 20, 2010 at 05:53:07PM -0500, Jorge Eduardo Candelaria wrote:
> When using MCLK is configured for 19.2 Mhz, clock slicer should be
> enabled and HPPLL should be bypassed in clock path.
> 
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
