From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 3/7] ASoC: edb93xx: convert to use
	snd_soc_register_card()
Date: Sun, 18 Sep 2011 10:38:52 +0300
Message-ID: <20110918073852.GA2625@mwesterb-mobl.ger.corp.intel.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<0fef3fd00e8cdb8a606f4a81ad4e7f2b7014621c.1315732452.git.mika.westerberg@iki.fi>
	<1316191555.17769.2.camel@r60e>
	<20110917065202.GA2759@mwesterb-mobl.ger.corp.intel.com>
	<1316260700.17769.8.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id AC65524656
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Sep 2011 09:38:57 +0200 (CEST)
Received: by fxe22 with SMTP id 22so3034251fxe.38
	for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2011 00:38:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316260700.17769.8.camel@r60e>
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

On Sat, Sep 17, 2011 at 01:58:20PM +0200, Alexander Sverdlin wrote:
> 
> I've checked mainline linux-next without your patches, it's broken too.
> So your patches are not the root cause for that.

Ok thanks.

Still it would be good to find out which causes it to fail. Are you able to
load all the modules manually? Does it work then?
