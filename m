From: Andrey Gelman <andrey.gelman@compulab.co.il>
Subject: PROBLEM: iMX6 SSI - set up as a master of external
	audio codec
Date: Mon, 15 Apr 2013 14:13:58 +0300
Message-ID: <516BE0F6.3060409@compulab.co.il>
References: <516BDCE2.6010800@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from compulab.co.il (softlayer.compulab.co.il [50.23.254.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 76549265148
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 13:14:01 +0200 (CEST)
In-Reply-To: <516BDCE2.6010800@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, fabio.estevam@freescale.com
List-Id: alsa-devel@alsa-project.org

Hi, everyone !

I'm bringing up a wm8731 audio codec on an iMX6 based board. I use the
slave mode, i.e. SSI outputs all the clocks towards the codec IC.
I work with 3.0.35 Android kernel provided by freescale.

While, generally, the playback is Ok, I face 2 issues:
- cannot play back mono streams (too high rate, one speaker produces
only noise)
- cannot play back streams with sampling rate as low as 8kHz (the sound
is accompanied by high distortion)
In the mainline kernel (commits to v3.6), there is a workaround to the
1-st issue by simply removing mono support from imx-ssi.c. Similar
approach would fix the 2-nd issue as well - SSI would report it does not
support 8kHz sampling rate.
In a later commit, this workaround has been reverted, enabling mono
support back.

My question is this:
Is this a real limitation of SSI ? Does it support mono playback or not ?
Does SSI support 8kHz sampling rate ? If yes, what could be possible
reason to the distortions I get, while higher rates are played back well ?
Is there a real fix to these issues, or only workarounds are available ?

Thanks,
Andrey Gelman
