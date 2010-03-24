From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch] wm8994: playback => capture
Date: Wed, 24 Mar 2010 13:51:46 +0000
Message-ID: <1269438706.3798.53.camel@odin>
References: <20100324115834.GG21571@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id F3E7C24435
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 14:51:51 +0100 (CET)
Received: by bwz20 with SMTP id 20so8703317bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 06:51:50 -0700 (PDT)
In-Reply-To: <20100324115834.GG21571@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-24 at 14:58 +0300, Dan Carpenter wrote:
> Sparse caught that initialize "playback" two times instead of
> initializing "capture".
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
