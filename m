From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Dynamic HDMI PCM creation
Date: Wed, 19 Sep 2012 13:54:28 +0200
Message-ID: <5059B274.40805@canonical.com>
References: <s5htxv6rq0e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B4FA2651AC
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 13:54:25 +0200 (CEST)
In-Reply-To: <s5htxv6rq0e.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On 09/10/2012 03:01 PM, Takashi Iwai wrote:
> Hi David,
>
> as we discussed at Plumbers, I tried some hack to create/delete
> HDMI/DP PCM stream per hotplug/unplug.  Test patches are found in
> sound-unstable git tree topic/hdmi-dynamic-pcm branch
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
>
> The patches are all small and easy, but it's still in a pretty rough
> cut.  It won't handle some cases, e.g. unplug during suspend, or
> such, I'm afraid.  After all, it's just a test.
>
> With these patches, the PCM device appears and disappears properly
> upon HDMI/DP hotplug/unplug on my system.  On mine, it appears as
> /dev/snd/pcmC0D8 as it's an Intel on-board.  So far, so good.
>
> Now the problem is that PA gets confused when this happens.  It can
> switch to HDMI/DP, but then the analog output disappears from PA's
> profile.  You cannot switch back to analog output after that, even
> after you unplug HDMI/DP cable.
>
> Or, it might be my PA version...  I'll check newer one.

Which PA version are you testing with?

> But it'd be good if you also check in your side.

Trying to figure out what's happening here - could you give the output 
of "pacmd list" both before and after things go wrong, as well as a more 
detailed instruction of what you do in what order?

It seems very strange that a profile would disappear during a card's 
lifetime, so probably it's something different happening.

Also; just to clarify - by default PulseAudio only tries one output + 
one input during its probing, which means that if you have a card which 
has both analog and HDMI outputs, by default it does not support 
simultaneous output to both.
As such it seems that "cannot switch back to analog output" is the 
troublesome point here, so exactly how are you trying to switch back, 
and do you get an error message?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
