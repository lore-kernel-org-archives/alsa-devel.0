From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V1 01/13] Temporarily undo
	2008f137e92220b98120c4803499cdddb2b0fb06
Date: Thu, 14 May 2009 16:21:44 -0400
Message-ID: <9e4733910905141321u523676cflcbe7df210757f1bd@mail.gmail.com>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015901.28145.40556.stgit@terra>
	<20090514101305.GB28291@sirena.org.uk>
	<9e4733910905140737u74e594f5wfc17fc068dc36361@mail.gmail.com>
	<1242318341.31458.1786.camel@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B47610393B
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 22:21:46 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2745497qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 13:21:45 -0700 (PDT)
In-Reply-To: <1242318341.31458.1786.camel@finisterre>
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

On Thu, May 14, 2009 at 12:25 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, 2009-05-14 at 10:37 -0400, Jon Smirl wrote:
>
>> You and I can easily see how this patch can be folded into the next
>> one. Git is broken in this situation. I've reported the issue to the
>> git people and they acknowledge it, but no one has fixed it. Git's
>> merge strategy does not handle the case of a file splitting. When git
>> tries to merge this one-liner into the next patch that splits the
>> files, it does the merge wrong which then messes up the entire patch
>> stack.
>
> It should be possible to do the relevant thing by hand - it's only a one
> line change you're staging out. Like I say, not the end of the world
> anyway.

I manually edited the diff files to fix this. That not something I
like to do because it is too easy to make mistakes. Once they were
edited I could feed them back into git. This is the second time I've
hit this problem in git.

-- 
Jon Smirl
jonsmirl@gmail.com
