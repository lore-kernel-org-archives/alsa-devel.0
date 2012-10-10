From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Bug 48381 - [Regression][Bisected]Sound gets
 permanently muted a few minutes after booting
Date: Wed, 10 Oct 2012 15:20:50 +0200
Message-ID: <50757632.2070900@canonical.com>
References: <CAMNub_Z-92W6ZWxpPPprWCOQpO9er2FXwVVpD4xMB8v6rFZvXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id ADDC026509B
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 15:20:50 +0200 (CEST)
In-Reply-To: <CAMNub_Z-92W6ZWxpPPprWCOQpO9er2FXwVVpD4xMB8v6rFZvXQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Da Fox <da.fox.mail@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/10/2012 02:59 PM, Da Fox wrote:
> Hi all,
>
> Since the official bug-tracker at
> https://bugtrack.alsa-project.org/alsa-bug/ seems to be down (and
> moreover this appears to be a kernel bug), I have filed a bug at the
> kernel's bug-tracker last week (
> https://bugzilla.kernel.org/show_bug.cgi?id=48381 ). However, it seems
> to have gone unnoticed thus-far.
>
> Quick summary of the issue:
> After a while of inactivity the sound-card seems to go into a sort of
> power-saving mode (you can hear a faint 'pop' from the speakers).
> Before the sound would automatically turn back on again as soon as a
> program attempted to play sound. However now it seems that after
> resuming from the power-saving mode the driver thinks that there is
> always a headphone connected, even when it is not. I think this is
> what happens because toggling the 'Auto-Mute Mode' (setting it to
> 'Disabled') in alsamixer allows the speakers to produce sound again.
> This is all on a laptop (please see the linked bug report for more
> detailed hardware description).
>
> Would a developer please take a look at it? I have bisected the issue
> down to a commit made by David Henningsson and/or Takashi Iwai:
> ---8<---------
> 80c8bfbe76869bfd6bdf3d260d316e7a32f318c3 is the first bad commit
> commit 80c8bfbe76869bfd6bdf3d260d316e7a32f318c3
> Author: David Henningsson <david.henningsson@canonical.com>
> Date:   Mon Jun 4 09:33:51 2012 +0200
>
>      ALSA: HDA: Create phantom jacks for fixed inputs and outputs
>
>      PulseAudio sometimes have difficulties knowing that there is a
>      "Speaker" or "Internal Mic", if they have no individual volume
>      controls or selectors. As a result, only e g "Headphone" might
>      be created for a laptop, but no "Speaker".
>      To help out, create phantom jacks (that are always present,
>      at least for now) for "Speaker", "Internal Mic" etc, in case we
>      detect them.
>      The naming convention is e g "Speaker Phantom Jack".
>
>      In order not to pollute the /dev/input namespace with even more
>      devices, these are added to the kcontrols only, not the input devices.
>
>      Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>      Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> :040000 040000 7a954b731bef80cee731763521f64a424a7058a0
> 7d176b02ebb4553b0b0f97d200f7527cb69c122a M    sound
> --->8---------
>
> If any additional information is required please let me know.

Thanks for the heads up. I would need the following additional information:

1) One alsa-info taken during playback through internal speakers, when 
the internal speakers are working, and
2) One alsa-info taken during playback through internal speakers, when 
the internal speakers are not working.

(See https://wiki.ubuntu.com/Audio/AlsaInfo if you don't know what 
alsa-info is.)

If you're using PulseAudio for playback, please also include the output 
of "pacmd list" in the above two scenarios.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
