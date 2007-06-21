From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: hda-intel without headphone output
Date: Thu, 21 Jun 2007 10:52:34 -0700
Message-ID: <1182448354.15219.254.camel@razman.gruemaster.com>
References: <20070614083156.GB26945@sandbender>
	<s5h8xamk612.wl%tiwai@suse.de> <20070614182703.GA9443@sandbender>
	<1181874374.12385.203.camel@razman.gruemaster.com>
	<s5hhcp4i711.wl%tiwai@suse.de> <20070619113525.GA4477@sandbender>
	<s5htzt4gof6.wl%tiwai@suse.de> <20070620190240.GA13021@sandbender>
	<s5hejk5a9m0.wl%tiwai@suse.de>  <20070621171230.GA2057@sandbender>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id E1A1310384B
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 19:52:35 +0200 (CEST)
In-Reply-To: <20070621171230.GA2057@sandbender>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Lemmen <robertle@semistable.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oops.  The patch I sent you was based on a previous HG snapshot.  I
updated my tree and remade the patch.  It just went out to the mailing
list & Takashi for integration in the main tree.

Tobin

On Thu, 2007-06-21 at 19:12 +0200, Robert Lemmen wrote:

> On Thu, Jun 21, 2007 at 12:24:23PM +0200, Takashi Iwai wrote:
> > > i am sorry, but this still doesn't work.
> > 
> > Are you sure that you remove model option with that patch?
> > The model option overrides the default model preset.
> 
> sorry for the confusion, but the second patch i got here (the one where
> the model is set to "laptop" in the quirks stuff), actually *does* work
> fine. it seems it was a bit late for me, and i got confused with
> different versions of the modules under /lib/**.
> 
> cu  robert
> 

-- 
Tobin Davis <tdavis@dsl-only.net>
