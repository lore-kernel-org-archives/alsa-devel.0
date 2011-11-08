From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Swapped channels issue on pxa-ssp based platforms
Date: Tue, 8 Nov 2011 12:27:02 +0000
Message-ID: <20111108122702.GK25591@opensource.wolfsonmicro.com>
References: <4EB817FC.4000905@gmail.com> <4EB83D3B.2050906@ladisch.de>
	<20111108113930.GI25591@opensource.wolfsonmicro.com>
	<4EB916A0.6090602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A01D1038E0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 13:27:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EB916A0.6090602@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 08, 2011 at 12:46:40PM +0100, Daniel Mack wrote:

> all over the place. I'm just curious whether there there is anything
> in the ASoC core that cares for this?

There's a big fat mutex around each PCM.
