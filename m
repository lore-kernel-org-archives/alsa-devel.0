From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Dynamic HDMI PCM creation
Date: Mon, 17 Sep 2012 12:15:23 +0200
Message-ID: <5056F83B.7080602@canonical.com>
References: <s5htxv6rq0e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 82361261665
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 12:15:24 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
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
> But it'd be good if you also check in your side.

Hmm.

As you probably know, PA does extensively test opening device strings at 
startup, and then never again.
As such, I can understand that PA gets confused if you start adding and 
removing PCM devices, because that changes whether and how different 
device strings can be opened.

Looking forward, with HDMI, it's a reality that this will happen. And 
therefore we need to deal with it in PA somehow, even if this is 
non-trivial. So the first question would be - what notification 
mechanism should we have to trigger "reprobing"? Are we recommended to 
use the jack detection kcontrol API, or is there something else that 
tells us that suddenly "hdmi:1,2" will actually be worth trying again?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
