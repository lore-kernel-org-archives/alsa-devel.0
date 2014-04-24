From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Testing rewindability of a pcm
Date: Thu, 24 Apr 2014 14:00:48 +0200
Message-ID: <5358FCF0.2040701@ladisch.de>
References: <5356A9B6.9060405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A497A26525B
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:00:51 +0200 (CEST)
In-Reply-To: <5356A9B6.9060405@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, alsa-devel@alsa-project.org
Cc: david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> And we don't even have a rewindable resampler implementation!

The rate plugin implements rewinding.  (I haven't tested if this
implementation is correct.  What is the problem?)

> Should PulseAudio indeed use a complex dance with snd_pcm_rewindable()
> to get the essentially-static bit of information whether a given PCM
> supports full rewinds?

As far as I can tell, ALSA assumes that _every_ device allows random
access to its ring buffer.

In particular, both alsa-lib's internal API and the explug/ioplug APIs,
when writing samples, have no concept of "current position" and write to
an explicitly specified position in the buffer.  The implementation
if snd_pcm_rewindable() assumes that the entire buffer is accessible
(the only plugin to change this is the file plugin).

snd_pcm_rewindable/forwardable() are just for determining the possible
amount of movement, not whether it's possible at all.


In other words: any plugin that does not allow random access is, as far
as the ALSA API is concerned, buggy.


> 2) Use snd_pcm_forwardable() with an empty buffer just after setting
>    hw_params: works (once the implementation in ioplug/extplug is
>    fixed to return 0), doesn't require API additions,

If ALSA is changed to track the information whether a device allows
random access or not, this would be the correct way.

>    but David doesn't like it. He thinks that the sets of PCMs that
>    support forwarding and rewinding may be different (here I disagree,
>    but can't provide arguments).

It's possible to imagine devices that implement forwarding by just
inserting zero samples, but cannot go back in time.  (I'm not sure if
implemting that would make any sense.)

> 3) Add a new function to ALSA that gets this bit of static information
>    for a given pcm handle, use it.

I guess this will happen.


Regards,
Clemens
