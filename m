From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Thu, 25 Jun 2009 12:01:21 +0100
Message-ID: <20090625110121.GE17812@sirena.org.uk>
References: <20090625102141.GA17812@sirena.org.uk>
	<s5hmy7wa9bt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 04F721037F2
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 13:01:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmy7wa9bt.wl%tiwai@suse.de>
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

On Thu, Jun 25, 2009 at 12:36:54PM +0200, Takashi Iwai wrote:

> You don't need to merge my branch now onto yours.  Instead, I'll merge
> your branch first.  In that way without back-merging the upstream, the
> history will be more straightforward.  That's what I learned
> recently.

Could you explain the problem here in more detail?  I don't see the
difference this is going to make here - your topic/asoc branch already
contains the upstream merge and all that should happen if I reset my
history is that the metadata for the merge commit changes.  With the
current branches your pull would just generate a fast forward.

The issue I'm aware of is with constantly pulling up mainline or other
merged branches into the topic branch during normal development since
that creates a merge heavy history which is harder to read and bisect
but that's not what's happened here.

> Could you take your branch back before merging the upstream?
> Then I'll merge yours, and you can go forward cleanly after that.

I should be able to do that, but like I say I'm not sure I understand
the problem.
