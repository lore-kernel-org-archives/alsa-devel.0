From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 3/7] ASoC: edb93xx: convert to use
	snd_soc_register_card()
Date: Sat, 17 Sep 2011 09:52:02 +0300
Message-ID: <20110917065202.GA2759@mwesterb-mobl.ger.corp.intel.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<0fef3fd00e8cdb8a606f4a81ad4e7f2b7014621c.1315732452.git.mika.westerberg@iki.fi>
	<1316191555.17769.2.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9EECE24490
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 08:52:08 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2402686fxe.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2011 23:52:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316191555.17769.2.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, rmallon@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 06:45:55PM +0200, Alexander Sverdlin wrote:
> 
> Have you tried the driver on reference boards?

No - I don't have any of those.

> For me it doesn't work any more. Boot messages are ok, as before, but
> alsa open produces such messages:
> Jan  1 00:32:19 IPCUn user.err kernel: asoc: can't open platform
> ep93xx-pcm-audio

Do you have the first patch ("ASoC: ep93xx-pcm: add MODULE_ALIAS") in this
series applied? Have you tried whether it still works if you compile
everything in?
