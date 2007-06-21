From: Robert Lemmen <robertle@semistable.com>
Subject: Re: hda-intel without headphone output
Date: Thu, 21 Jun 2007 19:12:30 +0200
Message-ID: <20070621171230.GA2057@sandbender>
References: <20070614083156.GB26945@sandbender> <s5h8xamk612.wl%tiwai@suse.de>
	<20070614182703.GA9443@sandbender>
	<1181874374.12385.203.camel@razman.gruemaster.com>
	<s5hhcp4i711.wl%tiwai@suse.de> <20070619113525.GA4477@sandbender>
	<s5htzt4gof6.wl%tiwai@suse.de> <20070620190240.GA13021@sandbender>
	<s5hejk5a9m0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d80-237-144-212.dds.hosteurope.de (debian.semistable.com
	[80.237.144.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 02A22103843
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 19:18:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hejk5a9m0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 21, 2007 at 12:24:23PM +0200, Takashi Iwai wrote:
> > i am sorry, but this still doesn't work.
> 
> Are you sure that you remove model option with that patch?
> The model option overrides the default model preset.

sorry for the confusion, but the second patch i got here (the one where
the model is set to "laptop" in the quirks stuff), actually *does* work
fine. it seems it was a bit late for me, and i got confused with
different versions of the modules under /lib/**.

cu  robert

-- 
Robert Lemmen                               http://www.semistable.com 
