From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: hda : computer using EAPD as external amplifier
 controller
Date: Thu, 20 Jan 2011 10:07:55 +0100
Message-ID: <4D37FB6B.9040701@canonical.com>
References: <20110119182448.2c8dbf28@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 20F9A1037E3
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 10:07:59 +0100 (CET)
In-Reply-To: <20110119182448.2c8dbf28@destiny.ordissimo>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anisse Astier <anisse@astier.eu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2011-01-19 18:24, Anisse Astier wrote:
> Hi,
>
> I have this computer, with an integrated speaker. It's using an ALC662,
> see attached alsa-info output.
>
> By default, speaker doesn't work. Now, after playing a bit with
> hda-analyzer, I figured that output PIN 0x14 has EAPD enabled, which is
> the default way of doing things in auto configure mode. But disabling
> EAPD on this PIN makes speaker work. See second alsa-info attached.
>
> Is it necessary to write a full blown quirk just to modify this parameter?
>
>  From what I've seen in patch_realtek, it seems we need to write the whole
> config for the device when adding a quirk: we can't rely on auto
> configuration and then put a small quirk on top of that. Am I right ?

Perhaps this commit can give you some inspiration?

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=357f915ece53aa4c8759087888346145848ea753

...although Takashi just rewrote the quirking system a bit, so you'll 
have to adjust to that when you add your (similar) quirk.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
