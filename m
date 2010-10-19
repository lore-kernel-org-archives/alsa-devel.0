From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: PATCH[1/1] Add I2S common driver for Intel MID
	platform
Date: Tue, 19 Oct 2010 18:19:53 -0500
Message-ID: <AANLkTintB=QxNOkaJdCGr2wrKC+81bV9DEOd043h2ZjX@mail.gmail.com>
References: <2A84145621092446B6659B8A0F28E26F46FE77084A@irsmsx501.ger.corp.intel.com>
	<20101019213212.GB29234@sirena.org.uk>
	<AANLkTim8uEuSYhHyedLn3gbaPQLvwo7Gu+eo-Vo23KvC@mail.gmail.com>
	<1287529307.3272.579.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 583E4244D4
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 01:19:54 +0200 (CEST)
Received: by yws5 with SMTP id 5so1943485yws.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 16:19:53 -0700 (PDT)
In-Reply-To: <1287529307.3272.579.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Le Gall,
	Louis" <louis.le.gall@intel.com>
List-Id: alsa-devel@alsa-project.org

> Is the inband signaling here done in software ? I'd expect this to be
> multiplexed in the DAI by the hardware leaving the software to send PCM
> bursts to the CODEC/MODEM/whatever like Peter's DAC33 driver.

No, this signaling is handled by sw in user space, it's all modem specific.
-Pierre
