From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Extra ASoC updates for v4.16
Date: Tue, 6 Feb 2018 22:12:28 -0800
Message-ID: <CA+55aFy7b_eCGhH1PVVzw10BKanxAcRVK=k5CRNc2fDhN9717Q@mail.gmail.com>
References: <20180206114439.GC5681@sirena.org.uk>
 <CA+55aFzD0+2pfQN+hPOmGNR5CHfp5KYKNtvng0NqVbKGTE5LRg@mail.gmail.com>
 <s5h372d743i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D4A266F62
 for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2018 07:12:30 +0100 (CET)
Received: by mail-it0-f42.google.com with SMTP id k6so867426ita.3
 for <alsa-devel@alsa-project.org>; Tue, 06 Feb 2018 22:12:30 -0800 (PST)
In-Reply-To: <s5h372d743i.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <takashi.iwai@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 6, 2018 at 9:37 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>
>> Because some of those merges look very Lovecraftian, with the whole
>> gigantic octopus merge theme. Cthulhu and tentacles galore.
>
> So, would you suggest to straighten commits by rebase at this time?
> The rebase was a thing to be avoided in general, and that's the reason
> of the messy multiple merges.

You don't need to rebase the commits themselves - not the ones that
are real commits that do things.

But the merging up of the commits is insane.

For example, these merges bring in basically *nothing* new (ok, so
some of them bring in a couple of commits, but see the pattern here?):

 - 3df40aaee07cd24df42ace7fa88fb4db32ad9a30 merge of a remote tracking
branch that had already been merged

 - e0a663f24d532c7ad9ff34cc1aa96bf94c75ef44 merge of a remote tracking
branch that had already been merged

 - b10f47faa4ad94b8b26780a873ed8756cee51120 merge of five
remote-tracking branches that had already been merged

 - eeb58f1eed5e8e503f12e4b84a3f27b3d21a40eb merge of five remote
tracking branches that had already been merged

 - 3cad9eda9bf8f11d4574399b68dd04405d1cafb3 merge of three remote
tracking branches that had already been merged

 - fcf9403a18a77f887c8a7034d53fc39f2f44f549 merge of three remote
tracking branches that had already been merged

 - e193ddead848f3da380c4f85bf78af9f34ba94f2 merge of five remote
tracking branches that had already been merged

 - 01813e837ff00dbf27e5b87790f646be23bc1935 merge of five remote
tracking branches, *ONE* of cwhich had a single new commit in it.

 - 5a477f39532a06532e05b5b1391f3d1393577180 merge of five remote
tracking branches that had already been merged

 - 2aa5cad2e8daf9f5a75bd55351fc71963a8da90d merge of five remote
tracking branches, of which three actually had *one* real commit each

 - a451d4e0c23b096bcfe5ec494fce7e5125bc4dd3 merge ot two remote
tracking branches that had already been merged

 - 7cf143ca596da8e5e4091f622315b269bba82508 merge of two remote
tracking branches that had already been merged

 - 19c2d84997beaf06327e392071c2dbe98602c56b merge of five remote
tracking branches, of which *ONE* had a single new commit in it

 - 5e1b94471344c5415e8fa61f07c6cedbaf242bbc merge of five remote
tracking branches that had already been merged

 - 92730ec723b3f089a6c4d84984ca940d498be792 merge of four remote
tracking branches of which *ONE* had a single new commit in it.

 - 43900579c34d58f5feb67de2bd8733ae3585e79a merge of four remote
tracking branches that had already been merged

 - f3ae09ce60c425d2e66591c7135a291196fa6739 merge of five remote
tracking branches that had already been merged

 - c710f11f3a1662490d6f5516c877dcd4d9c5948b merge of five remote
tracking branches that had already been merged

...

then I got really tired of walking through things.

See a pattern above? It's not that the actual commits that change
something need to be rebased.

It's the *MERGES* that need to be stopped. I don't know what the hell
Mark is doing. There's some kind of completely mindless and crazy
merging going on.

And I think it's entirely automated *GARBAGE*. Look at this:

     git log --pretty='%cn %cd' --merges 3f551e3cefcf..e0a663f24d53

which shows just the committer and the commit date of the merges in
question. And there is a total of 35 merges in that range, but what's
notable is that ALL BUT ONE of them happen in between

    Fri Jan 26 15:24:49 2018

and

    Fri Jan 26 15:27:56 2018

so we had 34 mindless merges in just over three minutes. That's a
merge every six seconds.

Put another way: Mark is doing some automated stupid crap. The result
of that stupid crap is all those merges of stuff that had already been
merged.

It's wrong, and I'm not pulling that kind of idiotic auto-generated merge hell.

But there are actually real commits in there, as shown by

    git log --oneline --no-merges 3f551e3cefcf..e0a663f24d53

but those 19 real commits are basically overwhelmed by the 34 crazy
automated and complex merges.

And I really don't think they need to be rebased. They just need to be
merged *sanely* instead of being merged mindlessly with octopus merges
where one branch (out of five) _might_ have had a new commit.

See what I'm complaining about?

               Linus
