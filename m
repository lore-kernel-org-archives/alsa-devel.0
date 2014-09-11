From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH RFC 0/7] Allow multiple callbacks for
	hda_jack
Date: Thu, 11 Sep 2014 17:14:00 +0200
Message-ID: <5411BC38.5020503@canonical.com>
References: <1410445157-23198-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 576542656C0
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 17:14:00 +0200 (CEST)
In-Reply-To: <1410445157-23198-1-git-send-email-tiwai@suse.de>
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



On 2014-09-11 16:19, Takashi Iwai wrote:
> Hi,
>
> this is a series of patches I quickly cooked up after the discussion
> in this morning: the support of multiple callbacks per jack.
>
> The series is applied on top of the previous fix patch (ALSA: hda -
> Fix invalid pin powermap without jack detection).  It begins with
> a couple of cleanups, then introduces the new hda_jack_callback
> struct and the changes along with it, then ends with another
> couple of cleanup patches based on the new infrastructure.
>
> I've tested only with a small set of devices, so far.

In general I like this idea and I remember thinking along the same lines.

I'm pondering whether we could use a more memory efficient layout for 
the callback list. Like allocating a snd_array on codec level and have 
indices to that list instead of pointers. Then the kernel would have 
less memory blocks to worry about. What do you think?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
