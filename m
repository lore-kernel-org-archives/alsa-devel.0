From: Hans Schou <linux@schou.dk>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Wed, 23 Jun 2010 20:22:56 +0200
Message-ID: <AANLkTiln40Xo3fHbMSkEvdBUtFq8ZWrF57wgRWdU2Juc@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
	<AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
	<1277262047.10818.9.camel@obelisk.thedillows.org>
	<1277271419.10818.22.camel@obelisk.thedillows.org>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E3F64103912
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 20:23:20 +0200 (CEST)
Received: by wwf26 with SMTP id 26so427755wwf.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 11:23:16 -0700 (PDT)
In-Reply-To: <1277271419.10818.22.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2010/6/23 David Dillow <dave@thedillows.org>:

> I can reproduce the alternating pattern of periods using a different
> device, so this may be something in the core code of ALSA.

Strange? The program I am actually using is one I have written myself.
I was sure I was using the old method as I open(2). In my program I
use
   int fd = open("/dev/dsp",  O_RDWR);

This should not go through ALSA (I think). I gues one should use
something with "snd_pcm_open()" to use ALSA.

> Since this problem is not related to the SiS7019 driver, I'll leave it
> to later -- or for others to investigate. Using three periods per buffer
> sees a similar pattern, but one has an extra period time to work
> within.

I really don't understand why I do not see this problem on other
hardware using the same compiled code.

If the problem is ALSA, how can I then turn it off?

Thanks for your investigation.

regards/hans
