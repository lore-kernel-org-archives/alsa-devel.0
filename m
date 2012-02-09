From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2] ALSA: PCM - Add PCM creation API for
 internal PCMs.
Date: Thu, 09 Feb 2012 08:41:02 +0000
Message-ID: <1328776862.3951.3.camel@odin>
References: <1328733211-3234-1-git-send-email-lrg@ti.com>
	<s5hk43xypmq.wl%tiwai@suse.de> <20120208225728.GA6596@sirena.org.uk>
	<s5hhaz0jtw4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C32F103FE9
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 09:41:19 +0100 (CET)
Received: by werp13 with SMTP id p13so1103629wer.12
	for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2012 00:41:04 -0800 (PST)
In-Reply-To: <s5hhaz0jtw4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-02-09 at 09:25 +0100, Takashi Iwai wrote:
> At Wed, 8 Feb 2012 22:57:34 +0000,
> Mark Brown wrote:
> > 
> > [1  <text/plain; us-ascii (7bit)>]
> > On Wed, Feb 08, 2012 at 10:35:57PM +0100, Takashi Iwai wrote:
> > > At Wed,  8 Feb 2012 20:33:31 +0000,
> > > Liam Girdwood wrote:
> > 
> > > > The new ASoC dynamic PCM core needs to create PCMs and substreams that are
> > > > for use by internal ASoC drivers only and not visible to userspace for
> > > > direct IO. These new PCMs are similar to regular PCMs expect they have no
> > > > device nodes or procfs entries. The ASoC component drivers use them in exactly
> > > > the same way as regular PCMs for PCM and DAI operations.
> > 
> > > The changes look OK to me, but could you fix a few errors/warnings
> > > by checkpatch.pl?
> > 
> > Since Liam's got a whole raft of ASoC changes depending on this one can
> > you please either apply it to a branch or ack it for merge via ASoC?
> 
> OK, now I fixed coding-style issues by myself and applied the patch.
> It's found in an individual branch, topic/pcm-internal of sound git
> tree.  Feel free to pull this branch to your trees.
> 

Appologies, I didn't catch that after rebasing from V1.

Liam
