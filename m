From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Extra ASoC updates for v4.16
Date: Wed, 7 Feb 2018 12:10:46 -0800
Message-ID: <CA+55aFw3T5eLAY=VReAyWMaeJU1hKktwoqRMXS0Ynkjtf=b8oA@mail.gmail.com>
References: <20180206114439.GC5681@sirena.org.uk>
 <CA+55aFzD0+2pfQN+hPOmGNR5CHfp5KYKNtvng0NqVbKGTE5LRg@mail.gmail.com>
 <s5h372d743i.wl-tiwai@suse.de>
 <CA+55aFy7b_eCGhH1PVVzw10BKanxAcRVK=k5CRNc2fDhN9717Q@mail.gmail.com>
 <20180207122927.GB6003@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 42DDC2676C5
 for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2018 21:10:48 +0100 (CET)
Received: by mail-it0-f49.google.com with SMTP id k6so3714727ita.3
 for <alsa-devel@alsa-project.org>; Wed, 07 Feb 2018 12:10:48 -0800 (PST)
In-Reply-To: <20180207122927.GB6003@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <takashi.iwai@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 7, 2018 at 4:29 AM, Mark Brown <broonie@kernel.org> wrote:
>
> I'm frankly a little bit confused about what went wrong here, usually
> git does manage to elide empty merges - for example, if I ask git to
> merge four branches two of which are already merged:

Yes, so git does elide truly trivial merges, but the git triviality
test is actually not "have all the commits been merged elsewhere", but
"are all the branches completely just subsets in history of each
other".

So a single extra merge commit that exists in one branch but not the
others will defeat that, and then you get a merge of a merge etc.
That's something we saw early on, when people would do daily
back-merges - even if there was no extra work in the development
branch, the previous back-merge *itself* would mean that the merge
wouldn't fast-forward to the upstream code, but would just do another
merge, because upstream wasn't a full superset of the development
branch due to the previous back-merge that wasn't upstream.

But in this case, the issue doesn't seem to be a previous back-merge,
but simply that the commits ion question had been merged up-stream -
but they weren't in your development branch, so when your development
branch does a merge, to *that* branch it looks like new commits, even
if it isn't anythign new or interesting to *me*, because I got those
commits from Takashi's pull two weeks ago.

This new pull request looks better, I'll look at it next.

               Linus
