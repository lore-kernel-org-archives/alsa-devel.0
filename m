From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Fri, 07 Sep 2012 18:39:15 +0300
Message-ID: <1347032355.8883.4.camel@laptop>
References: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
 <s5hligmw3s0.wl%tiwai@suse.de> <5049D9EB.5070301@canonical.com>
 <s5h8vcmvy9s.wl%tiwai@suse.de> <5049E5F6.8010007@canonical.com>
 <s5h1uievwk6.wl%tiwai@suse.de> <5049ECD4.2040501@canonical.com>
 <s5hwr06ugi4.wl%tiwai@suse.de> <504A0483.3050807@canonical.com>
 <s5hipbpvr7u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 15871261739
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 17:39:19 +0200 (CEST)
In-Reply-To: <s5hipbpvr7u.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 939161@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-09-07 at 16:32 +0200, Takashi Iwai wrote:
> > Hmm, I'm afraid it's not so easy to turn off PulseAudio's jack detection 
> > without being root. Maybe it's possible using some .asoundrc magic?
> 
> That's bad.  asoundrc is equally cryptic like udev rules :)
> 
> Honestly, can't the whole /usr/share/pulseaudio/* files be specified
> via an environment variable, or automatically looking at
> ~/.pulse/alsa-mixer/paths/* or such?

FWIW, I'm in favor of looking at the home directory...

-- 
Tanu
