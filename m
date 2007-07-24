From: Ingmar Stieger <alsauser@stiegerhs.de>
Subject: Re: Intel HDA digital out distortion
Date: Tue, 24 Jul 2007 11:28:25 +0200
Message-ID: <46A5C639.2090908@stiegerhs.de>
References: <46A51904.3010606@stiegerhs.de>
	<200707240906.49135.ml_alsa@mortal-soul.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from stiegerhs.de (lvps87-230-14-58.dedicated.hosteurope.de
	[87.230.14.58]) by alsa0.perex.cz (Postfix) with ESMTP id 60F3E10386F
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 11:28:29 +0200 (CEST)
Received: from p5498ef91.dip.t-dialin.net ([84.152.239.145]
	helo=[192.168.1.20])
	by stiegerhs.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1IDGgq-0007K9-5W
	for alsa-devel@alsa-project.org; Tue, 24 Jul 2007 11:28:28 +0200
In-Reply-To: <200707240906.49135.ml_alsa@mortal-soul.de>
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

Hi Matthias,

Matthias Dahl wrote:

> That makes two of us. I've reported similar problems a few weeks back. So the 
> thread "snd-hda-intel, AD 1988b: SPDIF output not working correctly, volume 
> low for analog output" maybe of interest to you too. (I posted a similar 
> patch just a few minutes before your's by the way -g-)

I've read through your thread, and I think we might have two seperate problems
with this chip ? I am not getting any noise over SPDIF when no sound is
playing, but it will inevitably be distorted at any volume level and mixer
settings if sound is played through aplay or mplayer. I have not tried with
dts, only with wave files, by the way.

Looking at the functional diagram, and trying to mute the various amps that
might have something to do with this, then led to the 0x1D one that I mentioned.

Analog out seems to be fine with the stock drivers for me, altough I did not
compare the volume level with the levels of a Windows driver. At least it is as
loud as my CD player, so I'd say it is ok. It also sounds clean with the stock
drivers. No problem here.

> Could you please tell me what board you have...? If you play back analog sound 
> through spdif, do you hear "distortions" in the background like bass-like low 
> frequency pumping and so on...?

The board came pre-installed in a bare-bone system, so I only know that it is
from ASUS and whatever mainboard they put into their Pundit P2 system. The
chipset is a Intel 945G with ICH7.

I can not discern any special background noise, since the distortion is so loud
that any background noise that might be there is not audible.

Bye,
Ingmar
