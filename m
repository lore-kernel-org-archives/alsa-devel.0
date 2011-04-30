From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 08/10] ALSA: hda - Add support for Line-Out
 automute to Realtek auto-parser
Date: Sat, 30 Apr 2011 08:52:58 +0200
Message-ID: <4DBBB1CA.8020508@canonical.com>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
	<1304097516-7258-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id AD96C24420
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Apr 2011 08:53:00 +0200 (CEST)
In-Reply-To: <1304097516-7258-9-git-send-email-tiwai@suse.de>
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

On 2011-04-29 19:18, Takashi Iwai wrote:
> By popular demands, I add the functionality to mute / unmute the
> line-out jacks per the headphone plug / unplug.  For achieving this
> and keeping the compatibility with the old behavior, the new mixer
> enum "Auto-Mute Mode" is added.  With this, user can control the
> auto-mute behavior either disabled, speaker-only or lineout+speaker.

Hi Takashi,

Great to see these improvements! I have a question about this patch:

There are three ways we can auto-mute:

Headphones might mute Internal Speakers.
Headphones might mute Line out.
Line out might mute Internal Speakers.

Are we considering the third option here or is that still unsupported?

Also, it might be slightly confusing for the end-user to have options 
that are irrelevant, e g if there are no internal speakers (or line-out 
for that matter), that option will still show up. Right?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
