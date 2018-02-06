From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Extra ASoC updates for v4.16
Date: Tue, 6 Feb 2018 15:25:34 -0800
Message-ID: <CA+55aFzD0+2pfQN+hPOmGNR5CHfp5KYKNtvng0NqVbKGTE5LRg@mail.gmail.com>
References: <20180206114439.GC5681@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 1917E266F62
 for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2018 00:25:36 +0100 (CET)
Received: by mail-io0-f181.google.com with SMTP id f89so4342784ioj.4
 for <alsa-devel@alsa-project.org>; Tue, 06 Feb 2018 15:25:36 -0800 (PST)
In-Reply-To: <20180206114439.GC5681@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 6, 2018 at 3:44 AM, Mark Brown <broonie@kernel.org> wrote:
> This pull request is for things that arrived in the last week of the
> v4.15 cycle, I'm sending it directly since Takashi still seems to be on
> holiday (I'd thought he'd be back this week).  There's some random new
> development in here and also a bunch of bugfixes.

No. I'm not taking this completely crazy stuff.

It has 54 commits total. Of those, 35 are merges. Many of those merges
are complicated octopus merges that don't bring in _anything_ new,
because the commits they merge all came in through some other source.

Really. Ask yourself - why would I take that kind of complete and
utter mess, where two thirds of the commits don't actually do anything
but mess up the history and make things hard to follow?

> Unfortunately I can't figure out how to generate a sensible git pull
> request for this since it ended up containing both v4.15-rc9 and my
> prior pull requests.

git pull-request doesn't necessarily work if you have complex history,
and this is more complex than most, by a long shot.

In fact, it was so complex that just "git merge" - which usually
completes in under a second - spent a lot of CPU time on that merge
from hell. It probably had a ton of different common merge points that
all ended up being recursively merged together to get a base for the
final merge.

[ Whee. I went back and looked. There's 88 merge-bases. EIGHTY-EIGHT!
Christ. That must be some kind of record. Poor git. It did end up with
a clean merge in the end, but no wonder it took tens of seconds to do
so ]

It is expected that anybody who doesn't have a linear history knows
how to do a test merge and report the result that way.

That said, history really generally isn't expected to be this messy
_anyway_. This looks like some drug-induced frenzy of "let's just
merge random branches for no good reason even if they have been merged
earlier".

So pulled and then unpulled in horror.

Because some of those merges look very Lovecraftian, with the whole
gigantic octopus merge theme. Cthulhu and tentacles galore.

              Linus
