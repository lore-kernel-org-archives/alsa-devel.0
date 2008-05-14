From: Andreas Mohr <andi@lisas.de>
Subject: Oh, BTW... (OPL3 PM issue)
Date: Wed, 14 May 2008 23:45:44 +0200
Message-ID: <20080514214544.GA15207@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 7299924467
	for <alsa-devel@alsa-project.org>;
	Wed, 14 May 2008 23:45:44 +0200 (CEST)
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
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

unfortunately I forgot to mention this:

when I tested OPL3 functionality of my driver, I of course also
tested this to do proper power management, and... well... it didn't!
The result of doing an S2D was that the formerly perfectly playing
emulated MIDI synth ended up with distorted (sort of Micky-Mouse'ish)
voices directly after resume.

I really don't think that it's my driver's power management which is
at fault here, and I'd strongly guesstimate that ALSA does its own
generic OPL3 power management handling for standard OPL3 hardware registration.

So??? (aka "what the...!?")

Thanks,

Andreas Mohr
