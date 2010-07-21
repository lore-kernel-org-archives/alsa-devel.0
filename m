From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2] ASoC: multi-component - Add Aquila sound
 driver
Date: Wed, 21 Jul 2010 10:58:07 +0100
Message-ID: <1279706287.3072.4.camel@odin>
References: <4C462C10.2050500@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A0272452E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 11:58:12 +0200 (CEST)
Received: by wwb22 with SMTP id 22so555180wwb.20
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 02:58:11 -0700 (PDT)
In-Reply-To: <4C462C10.2050500@samsung.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-07-21 at 08:06 +0900, Chanwoo Choi wrote:
> This patch add sound support for the Aquila board based on S5PC110.
> 
> The Aquila board is based on Samsung SoC(S5PC110) and include
> WM8994 codec over I2S to support sound. This uses the I2Sv4 driver
> compatible with I2Sv5 to run sound.
> 
> The kind of jack is below states :
> * SND_JACK_HEADPHONE
> * SND_JACK_HEADSET
> * SND_JACK_MECHANICAL
>   : When TV-OUT cable is inserted on Aquila board,
>   the TV-OUT cable isn't connected to television.
> * SND_JACK_AVOUT
>   : When TV-OUT cable is inserted on Aquila board,
>   the TV-OUT cable is connected to television.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
