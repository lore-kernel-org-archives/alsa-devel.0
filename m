From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/5] ALSA: usbaudio: parse USB descriptors
 with	structs
Date: Tue, 23 Feb 2010 09:26:34 +0100
Message-ID: <20100223082634.GR28972@buzzloop.caiaq.de>
References: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
	<1266878953-9184-2-git-send-email-daniel@caiaq.de>
	<4B8388C5.9070101@ladisch.de> <s5h7hq42xlf.wl%tiwai@suse.de>
	<20100223081032.GQ28972@buzzloop.caiaq.de>
	<s5h1vgc2wg2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 64B0210387A
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 09:26:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1vgc2wg2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2010 at 09:22:21AM +0100, Takashi Iwai wrote:
> At Tue, 23 Feb 2010 09:10:32 +0100,
> Daniel Mack wrote:

> > It does break compilation though, so I'll fix that up somehow before
> > merge.
> 
> Well, I'd like to merge this stuff ASAP because the merge window is
> closing, and I don't want to put such a big thing after the merge
> window.
> 
> If you are OK with merging for 2.6.35, then I'm fine to wait.
> If this is for 2.6.34, I can't wait long.

That's right. There hasn't been much real refactoring done, so that's a
good state to merge it and test it for regressions. More support for v2
can be aimed for for .35.

> Otherwise, it's easier to put things merged first, then refactor
> gradually.

Ok good. I'll fix the gadget drivers later today.

Thanks,
Daniel
