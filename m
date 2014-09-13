From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Sun, 14 Sep 2014 00:35:30 +0600
Message-ID: <54148E72.2050903@gmail.com>
References: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id D35C02657A2
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:35:32 +0200 (CEST)
Received: by mail-lb0-f179.google.com with SMTP id p9so2543477lbv.10
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:35:32 -0700 (PDT)
In-Reply-To: <540C76E0.9050808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

07.09.2014 21:16, Alexander E. Patrakov wrote:
> 1. PulseAudio does not call snd_pcm_rewindable(), because for some ALSA
> plugins it crashed. This crash is completely fixed in alsa-lib 1.0.28,
> but in some cases snd_pcm_rewindable() still returns wrong results.

Bad news: even in 1.0.28, snd_pcm_rewindable() crashes for the file 
plugin due to recursion. So I was wrong when saying "fixed completely" :(

> 3. On the hw plugin, I could demonstrate two other bugs regarding
> snd_pcm_rewindable(): stale data and bogus negative return values.

For all of the above issues, I have sent patches.

> === On the rewind safeguard ===

Result 1: it has been decided that the return value of 
snd_pcm_rewindable() is not changed, and the safeguard is returned by a 
separate function. This would require documentation changes for 
snd_pcm_rewindable(), though, as it officially no longer returns "safe 
count of frames which can be rewinded". I have difficulty designing a 
better wording what the function actually means now.

Result 2: the proposed heuristic has been rightfully and convincingly 
busted, but no alternatives were proposed. It is the top priority to get 
some constructive proposal here where to get the data, or a fallback 
plan for alsa-lib. A fallback plan is also needed for old kernels if the 
constructive proposal involves kernel changes.

> === On non-rewindability of the rate plugin ===

Nothing more to discuss.

> === On possibly-incomplete rewindability of the file plugin ===

Nothing more to discuss.

> === On bogus rewindability of ladspa and extplug plugins ===

No conclusion. The proposed hack to leave the .rewind implementation in 
place for use by old PulseAudio has met some opposition, but not such 
definite and convincing opposition as to the rewind-safeguard and 
low-latency-thread proposals. The proposed alternative (to make a 
"disallow imperfect rewinds" flag, off by default) means more work for 
no gain, and David also doubts whether such flag is worth the 
complexity. It's also notable that nobody explicitly said "let's regress 
old pulseaudio on new alsa-lib on the obscure dca plugin in the name of 
clean code" - which would have also closed the question :)

In fact, I am not really sure that everyone understands the problem.

> === On bogus rewindability of some ioplug-based plugins ===

The "low-latency-thread in ioplug" idea has been rightfully busted, and 
transformed into the "flexiblerewind" plugin idea. However, that plugin 
found no users (as PulseAudio won't use it), and thus there is no 
incentive for me or anyone else to implement it. Nothing left to discuss.

> === On the pulse plugin ===

We have reached an agreement that .rewindable and .rewind should be 
added to ioplug and used by the pulse plugin. Nothing more to discuss.

> === On communication of non-rewindability to the program ===

We have very good progress here: recognition of three rewindability 
classes that seemingly nobody objects to. The wanted behavior of 
PulseAudio for each rewindability class is not something we currently 
fully agree upon, though, but I think that it will be more appropriate 
to discuss further when someone sends a PulseAudio patch making use of 
these classes. I.e. not now. It is very good that there is at least one 
more person (Pierre Bossart) who understands the inherent conflict of 
requirements.

Transition plan remains to be discussed, but that's the same discussion 
as the one called for in the "rewind safeguard" part of the post.

> === On the programmer expectations ===
>
> (social issue)

Resolved (was misinterpretation on my side). I have to submit the 
documentation patch.

-- 
Alexander E. Patrakov
