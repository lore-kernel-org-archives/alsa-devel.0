From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Shared volume control again
Date: Wed, 29 Oct 2014 18:12:14 +0100
Message-ID: <54511FEE.40906@canonical.com>
References: <s5hegtq6c8d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 77A312604B5
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 18:12:12 +0100 (CET)
In-Reply-To: <s5hegtq6c8d.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-10-29 18:02, Takashi Iwai wrote:
> Hi,
>
> thinking of the problem about shared volume controls again, I stumbled
> on a case where your suggested solution doesn't work well.  Namely,
> when a headphone volume is shared for two headphones (one on the
> laptop and one on the dock), how should it be named?  One is
> "Headphone" and another is "Dock Headphone".  That's a bit tricky.
>
> So, in the end, we need the mapping representation somehow more
> explicitly than the control name.
>
> Thoughts?

In practice, it seems like we more often than not share DAC for all 
headphones. Also it is very common today that a jack called "Front 
Headphone" has a volume control called only "Headphone".

That's the status quo. As a result we have only one headphone path in 
PulseAudio for all types of headphones.
And it kind of works as long as we *always* share DAC between the 
different headphones. And when we don't, they're usually both controlled 
by a vmaster anyway. I haven't seen anything else recently, are you 
planning to make "headphone" and "dock headphone" have separate volume 
controls?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
