From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/8] ASoC: da7210: Add support for DAPM
Date: Wed, 19 Oct 2011 13:13:41 +0100
Message-ID: <20111019121341.GE3107@opensource.wolfsonmicro.com>
References: <1318590098.12107.509.camel@matrix>
	<20111014192008.GD2931@opensource.wolfsonmicro.com>
	<1318666803.613.21.camel@matrix>
	<20111017214107.GC5200@opensource.wolfsonmicro.com>
	<1319008895.7230.11.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B7862455F
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 14:13:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319008895.7230.11.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 19, 2011 at 12:51:35PM +0530, Ashish Chavan wrote:

> BTW if in case, hardware designers reiterate to use STANDBY registers,
> will it suffice to only document this somewhere is the source?

The main thing is to make sure that the code is understandable and
doesn't look buggy to visual inspection so yes, if there's adequate
documentation that would be OK.
