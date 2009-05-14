From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V1 01/13] Temporarily undo
	2008f137e92220b98120c4803499cdddb2b0fb06
Date: Thu, 14 May 2009 10:37:10 -0400
Message-ID: <9e4733910905140737u74e594f5wfc17fc068dc36361@mail.gmail.com>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015901.28145.40556.stgit@terra>
	<20090514101305.GB28291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f125.google.com (mail-pz0-f125.google.com
	[209.85.222.125])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F39210397A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 16:37:13 +0200 (CEST)
Received: by pzk31 with SMTP id 31so591044pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 07:37:12 -0700 (PDT)
In-Reply-To: <20090514101305.GB28291@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 6:13 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 13, 2009 at 09:59:01PM -0400, Jon Smirl wrote:
>
>> Temporarily undo 2008f137e92220b98120c4803499cdddb2b0fb06 in sound/soc/fsl/mpc5200_psc_i2s.c so that it won't interfere with following patches that split mpc5200_psc_i2s.c.
>
> I'm fairly sure it's possible to squash these in with the other two
> patches but I guess it's not the end of the world :(
>

You and I can easily see how this patch can be folded into the next
one. Git is broken in this situation. I've reported the issue to the
git people and they acknowledge it, but no one has fixed it. Git's
merge strategy does not handle the case of a file splitting. When git
tries to merge this one-liner into the next patch that splits the
files, it does the merge wrong which then messes up the entire patch
stack.

-- 
Jon Smirl
jonsmirl@gmail.com
