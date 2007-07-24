From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: Re: Intel HDA digital out distortion
Date: Tue, 24 Jul 2007 09:06:45 +0200
Message-ID: <200707240906.49135.ml_alsa@mortal-soul.de>
References: <46A51904.3010606@stiegerhs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 00C0E10386F
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 09:06:34 +0200 (CEST)
In-Reply-To: <46A51904.3010606@stiegerhs.de>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, Ingmar Stieger <alsauser@stiegerhs.de>
List-Id: alsa-devel@alsa-project.org

Hi Ingmar.

On Monday 23 July 2007 23:09:24 Ingmar Stieger wrote:

> a couple of weeks ago, I bought an ASUS mainboard with integrated Intel HDA
> and an AD1988B codec. Unfortunately, the digital / SPDIF output gets
> distorted with stock 1.0.14 drivers. It does not matter what the volume
> levels of the various mixers are set to.

That makes two of us. I've reported similar problems a few weeks back. So the 
thread "snd-hda-intel, AD 1988b: SPDIF output not working correctly, volume 
low for analog output" maybe of interest to you too. (I posted a similar 
patch just a few minutes before your's by the way -g-)

Could you please tell me what board you have...? If you play back analog sound 
through spdif, do you hear "distortions" in the background like bass-like low 
frequency pumping and so on...?

Best regards,
Matthias Dahl
