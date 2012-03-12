From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] [PATCH 0/5] Add vmaster hook for HD-audio
 mute-LED controls
Date: Mon, 12 Mar 2012 15:57:35 +0100
Message-ID: <4F5E0EDF.1090402@canonical.com>
References: <1331562530-16044-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id E8C881040DB
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:57:41 +0100 (CET)
In-Reply-To: <1331562530-16044-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/12/2012 03:28 PM, Takashi Iwai wrote:
> This is yet another hack for HD-audio.  Currently the mute-LED is
> controlled via abusing the powerstatus check callback for power-saving
> feature.  Thus the mute-LED won't be enabled when user didn't build the
> driver with CONFIG_SND_HDA_POWER_SAVE=y.  With this patchset, the driver
> will refer to only Master switch to follow the mute-LED status.
>
> The first patch is to add a hook to vmaster control.  It's simple and
> small.  The rest are implementations of hooks and replacements of the
> existing codes with the vmaster hook.  The last patch is the addition of
> the mute-EAPD support on Conexant codec.  This was one of the major
> reason I wanted to implement before 3.4, since it's the biggest missing
> piece in Conexant auto-parser.
>
> I've checked quickly on a few machines.  The patches are found in my
> sound-unstable tree topic/cxt-fix branch, too.
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git topic/cxt-fix
>
> Let me know if you see any problems with this patchset.

I'm not really happy with it. Or rather, it does not solve my problem. 
I've heard people say "hmm, when I mute the internal speakers or 
headphones, the mute LED is lit, but not when I mute HDMI, what's the 
logic in that?". (And since HDMI might very well be on a separate card, 
checking all different codecs won't help.)

I believe you need to make the mute LED (and mic mute LED, if present) 
controllable by userspace. If you like it the way it is, I'm okay with 
making a kcontrol that has "On", "Off" and "Follow master mute" with the 
last one being the default.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
