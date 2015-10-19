From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Headphone Mic and PA
Date: Mon, 19 Oct 2015 13:20:21 +0200
Message-ID: <5624D1F5.3090005@canonical.com>
References: <s5hsi57i3qm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DED582657FE
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 13:20:20 +0200 (CEST)
In-Reply-To: <s5hsi57i3qm.wl-tiwai@suse.de>
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



On 2015-10-19 11:53, Takashi Iwai wrote:
> Hi David,
>
> I'm currently checking the bug report regarding PA, and this looks
> like an issue with "Headphone Mic" jack control.
>
> The reported problem is that PA doesn't react properly when both HP
> and dock line-out jacks are plugged and line-out is unplugged.  The
> machine in question is Dell E7250, and I see that it has only
> "Headphone Mic Jack" kctl without "Headphone Jack" kctl.  Is this the
> intentional behavior?

Yes. The "Headphone Mic Jack" indicates that the jack can be used to 
indicate either "Headphone" or "Mic". The additional "Headset Mic 
Phantom Jack" indicates that headset is a third usage for the jack and 
there is no hardware that can detect which one of them it is. So it 
looks correct to me.

Also the Dell E7250 is Ubuntu certified, but I don't think docking 
stations are part of that certification suite (at least not for Dell E7250).

I skimmed through the opensuse bug as well. Two notes:

  1) Here's a guide of how to generate a PA log, avoiding the autospawn 
problem: https://wiki.ubuntu.com/PulseAudio/Log

  2) There is a patch series in the pipeline [2] that Tanu has promised 
to review, that makes module-switch-on-port-available more aggressive w 
r t being able to reroute away from unavailable things. I suspect it 
would help here, but I'm not completely sure.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[2] http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/23504
