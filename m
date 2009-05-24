From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V2 1/9] Register the wm9712 DAIs on module
	load
Date: Sun, 24 May 2009 11:32:48 -0400
Message-ID: <9e4733910905240832pbcb78adh5e3708d010263f6c@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231257.17919.4483.stgit@terra>
	<20090524111118.GC4933@sirena.org.uk>
	<9e4733910905240828q4b4cfd96xe840f3ae983143dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 24BFF2449B
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 17:32:50 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3765883qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 08:32:48 -0700 (PDT)
In-Reply-To: <9e4733910905240828q4b4cfd96xe840f3ae983143dc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Output with SOC DEBUG turned on:

Advanced Linux Sound Architecture Driver Version 1.0.19.
No device for DAI stac9766 analog
Registered DAI 'stac9766 analog'
No device for DAI stac9766 IEC958
Registered DAI 'stac9766 IEC958'
No device for DAI tas5504
Registered DAI 'tas5504'
Registered platform 'mpc5200-psc-audio'
irq: irq 129 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 129
irq: irq 194 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 194
irq: irq 195 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 195
Registered DAI 'AC97'
Registered DAI 'SPDIF'
mpc5200-psc-ac97 f0002000.ac97: Codec ID is 574d 4c12
soc-audio soc-audio.1: DAI AC97 HiFi not registered
soc-audio soc-audio.1: Registered card 'pcm030'
ALSA device list:
  No soundcards found.


-- 
Jon Smirl
jonsmirl@gmail.com
