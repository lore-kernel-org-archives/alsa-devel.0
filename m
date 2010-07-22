From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component - Add Goni sound
	driver
Date: Thu, 22 Jul 2010 10:11:36 +0100
Message-ID: <20100722091136.GB4737@rakim.wolfsonmicro.main>
References: <4C47E22A.6090405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E003103978
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 11:11:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C47E22A.6090405@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, alsa-devel@alsa-project.org, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 22, 2010 at 03:16:10PM +0900, Chanwoo Choi wrote:
> This patch add sound support for the Goni board based on S5PV210.
> 
> The Goni board is based on Samsung SoC(S5PV210) and include
> WM8994 codec over I2S to support sound.
> 
> The kind of jack is below states :
> * SND_JACK_HEADPHONE
> * SND_JACK_HEADSET
> * SND_JACK_MECHANICAL
>   : When TV-OUT cable is inserted on Goni board,
>   the TV-OUT cable isn't connected to television.
> * SND_JACK_AVOUT
>   : When TV-OUT cable is inserted on Goni board,
>   the TV-OUT cable is connected to television.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
