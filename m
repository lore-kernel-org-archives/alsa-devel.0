From: Ingmar Stieger <alsauser@stiegerhs.de>
Subject: Intel HDA digital out distortion
Date: Mon, 23 Jul 2007 23:09:24 +0200
Message-ID: <46A51904.3010606@stiegerhs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from stiegerhs.de (lvps87-230-14-58.dedicated.hosteurope.de
	[87.230.14.58]) by alsa0.perex.cz (Postfix) with ESMTP id C740D1038A2
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 23:09:31 +0200 (CEST)
Received: from p5498c6f3.dip.t-dialin.net ([84.152.198.243]
	helo=[192.168.1.20])
	by stiegerhs.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1ID59h-00039J-6F
	for alsa-devel@alsa-project.org; Mon, 23 Jul 2007 23:09:30 +0200
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

Hi,

a couple of weeks ago, I bought an ASUS mainboard with integrated Intel HDA and 
an AD1988B codec. Unfortunately, the digital / SPDIF output gets distorted with 
stock 1.0.14 drivers. It does not matter what the volume levels of the various 
mixers are set to.

I think I might have found the source for this problem. Maybe it's only a 
workaround, but it solved the issue and digital out now works fine for me, so I 
thought I'd share.

In patch_analog.c, in static struct hda_verb ad1988_spdif_init_verbs[], 
changeing the forth entry

from {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},

to {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)}

mutes what might be an feedback loop from the analog inputs. The distortion is 
gone if the input to this widget is muted.

On a side note, the settings for the ADCs with NID:08, 09, and 0F looks fishy, 
too. According to the functional diagram, those should have no amps, and thus 
should not be muteable. The driver mutes them anyway...

I'd like to help somebody who really understands this stuff to solve the 
problem for good. What would the next step be ?

Thanks,
Ingmar
