From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: broonie/sound-2.6.git rebase?
Date: Sun, 15 Mar 2009 21:16:50 +0000
Message-ID: <20090315211649.GC7439@sirena.org.uk>
References: <20090315204427.GA6977@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B9AB1037EF
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 22:16:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090315204427.GA6977@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 15, 2009 at 09:44:27PM +0100, Daniel Mack wrote:

> Could you rebase your broonie/sound-2.6.git to Linus' master? When
> trying to merge them, I currently get:

No I can't do that, it's almost entirely Takashi's tree and in any case
I doubt that this would actually help with the problems you are seeing.

Looking at what you're getting below I suspect you've got something that
looks like the ASoC branch in there but for some reason git isn't
figuring out the merge automatically.  In my experience this is normally
a result of either cherry picking patches over or having had one of your
patches merged (which has the same effect).

> From git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6
>  * branch            pxa-ssp    -> FETCH_HEAD

I suspect this is a pull or something, rather than a merge?

> Auto-merging arch/arm/mach-shark/include/mach/io.h
> CONFLICT (content): Merge conflict in arch/arm/mach-shark/include/mach/io.h

There's no diff between my tree and Linus' tree here any more.

> Auto-merging sound/soc/codecs/wm8400.c
> CONFLICT (add/add): Merge conflict in sound/soc/codecs/wm8400.c

This file isn't present in Linus' tree.

> Or is there any mystery about git I still haven't fully understood?

I would expect that the easiest thing to do here is for you to just
accept all the for-2.6.30 versions of things.
