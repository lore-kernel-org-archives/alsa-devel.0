From: Matteo Fortini <matteo.fortini@gmail.com>
Subject: ASoC: mixing PCI card and SoC codec
Date: Fri, 14 Oct 2011 10:49:46 +0200
Message-ID: <CAC_9p+_9q9p3qKcOb1=b3MO1TWnJZkm_g35qMF_ceu1dAYoxoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A24CB24398
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 10:50:08 +0200 (CEST)
Received: by eyz10 with SMTP id 10so890527eyz.38
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 01:50:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have a Geode board with integrated PCI CS5535 sound card, and I'll be
using an external ADAU1761 codec as an aux_dev (mixer and probably DSP).

Until now I defined the ADAU as a dummy sound card, just to be able to use
its mixer.

I guess there's a cleaner solution to that, which I suspect involves
bridging SoC and PCI codecs (I think avoiding to call snd_device_new in the
PCI codec and moving it to a SOC card would be a good start...).

Should I try that, or stick to the dummy soc implementation?

Thank you.
