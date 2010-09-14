From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove needless codec->bias_level
 assignment to SND_SOC_BIAS_OFF
Date: Tue, 14 Sep 2010 13:53:31 +0100
Message-ID: <1284468811.3274.155.camel@vega>
References: <1284467078-6164-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 446A024471
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Sep 2010 14:53:50 +0200 (CEST)
Received: by gyh4 with SMTP id 4so2708915gyh.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 05:53:49 -0700 (PDT)
In-Reply-To: <1284467078-6164-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-09-14 at 15:24 +0300, Jarkko Nikula wrote:
> This assignment is done by the snd_soc_register_codec so there is no need
> to redo it in probe function of a codec driver.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>


-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
