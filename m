From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix race in dapm_power_widgets
Date: Thu, 4 Nov 2010 14:08:58 -0400
Message-ID: <20101104180858.GA6088@opensource.wolfsonmicro.com>
References: <1288858605-8388-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101104134354.GA1201@opensource.wolfsonmicro.com>
	<201011041618.07655.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 31B88243ED
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:08:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201011041618.07655.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 04, 2010 at 04:18:03PM +0200, Peter Ujfalusi wrote:

> It is really hard to see what is actually happening, but based on my observation 
> the root is this:
> the widget's power_list going to be modified during the dapm_power_widgets call.
> If the previous call to dapm_power_widgets did not finished, and it is going 
> through the widget's power_list, another call to dapm_power_widgets might cause 
> the power_list to be changed. This leads to a crash.
> It is possible that the list which existed in the first dapm_power_widgets call 
> got distroyed by the second call while the first instance was going through 
> that.
> IMHO in most cases the new mutex is not going to add much delay, since it is 
> really rare case, when we can hit this bug.

Sure, it's fairly clear how this could fall over.

> I did not find lower level point where I can safely deal with this problem.

Right, that's what I was thinking - I'm mostly concerned that we need to
have the locking further up the stack rather than further down.  This
feels like a band aid which fixes the symptom (the list pointers getting
corrupted) but it smells like we may have something further up the stack
which can still create issues.  For example, if both DAPM and something
else manipulate the register map simultaneously we could get R/M/W
issues.
