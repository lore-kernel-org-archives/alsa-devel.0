From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v4 0/5] ALSA: jack: Refactoring for jack
 kctls
Date: Wed, 08 Apr 2015 09:20:56 +0200
Message-ID: <5524D6D8.60205@canonical.com>
References: <1428062838-14786-1-git-send-email-yang.jie@intel.com>
 <s5h1tjvq5wd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 68297260451
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 09:21:01 +0200 (CEST)
In-Reply-To: <s5h1tjvq5wd.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org



On 2015-04-07 18:06, Takashi Iwai wrote:
> This would work, yes.  But, I have some uneasy feeling, something not
> well digested...
>
> Ideally, we want a single API for representing both input and kctl
> jacks.

Maybe this is somewhat my fault for steering Yang in that direction. But 
the requirements are somewhat different.

HDA has the phantom jacks, and the exact naming for each kctl requirements.
ASoC has the combination/button requirements, i e one jack can represent 
more than one kctl.

The phantom jack requirement means that the snd_kctl_jack_new API cannot 
be removed straight away; we could move it to be internal to HDA (it's 
not much code anyway), but I don't see a need for that.

But the HDA code can be moved around to look like this:

    if (phantom_jack) {
       snd_kctl_jack_new();
    }
    else {
       snd_jack_new();
       snd_jack_add_new_kctls();
    }

Now the HDA looks more like the ASoC variant. Yang, what do you think 
about that? That would make the API simpler, wouldn't it?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
