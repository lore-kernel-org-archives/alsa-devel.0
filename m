From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Extra ASoC updates for v4.16
Date: Wed, 7 Feb 2018 12:19:14 -0800
Message-ID: <CA+55aFyW+zeV2m+s1m8oQDmvSfdpMvHj1DwbfW8cb1kG4+EOQg@mail.gmail.com>
References: <20180206114439.GC5681@sirena.org.uk>
 <CA+55aFzD0+2pfQN+hPOmGNR5CHfp5KYKNtvng0NqVbKGTE5LRg@mail.gmail.com>
 <s5h372d743i.wl-tiwai@suse.de>
 <CA+55aFy7b_eCGhH1PVVzw10BKanxAcRVK=k5CRNc2fDhN9717Q@mail.gmail.com>
 <20180207122927.GB6003@sirena.org.uk>
 <CA+55aFw3T5eLAY=VReAyWMaeJU1hKktwoqRMXS0Ynkjtf=b8oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id EF4C32676C5
 for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2018 21:19:16 +0100 (CET)
Received: by mail-io0-f174.google.com with SMTP id t22so3359165ioa.7
 for <alsa-devel@alsa-project.org>; Wed, 07 Feb 2018 12:19:16 -0800 (PST)
In-Reply-To: <CA+55aFw3T5eLAY=VReAyWMaeJU1hKktwoqRMXS0Ynkjtf=b8oA@mail.gmail.com>
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

On Wed, Feb 7, 2018 at 12:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This new pull request looks better, I'll look at it next.

Ok, pulled and pushed out.

And the reason your diffstat looked like crap is that "git
request-pull" simply does a diff between two points, not a real merge.
That diff works fine for straight-line development, or for simple
history, but when you have multiple branches that came in at different
points, there is no single starting point for the diff.

So git picks _one_ common point for the start of the diff, and that is
the right thing for the simple cases, but for the case where you have
lots of different starting points, that one point will be right for
_one_ branch, but for another branch it will contain (or miss) a lot
of other development that happened between the starting points of the
different branches.

But since "diff" is fundamentally a comparison between two points in
history, it very fundamentally cannot do better.

If you want to get the real diffstat for that case, you have to do an
actual test merge. A merge will do a *much* more complex operation,
taking *all* the different base points into account. It really is a
lot more complex thing. Then you can diff the two points of "before
merge" and "after merge".

                Linus
