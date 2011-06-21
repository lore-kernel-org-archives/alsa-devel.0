From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Tue, 21 Jun 2011 12:01:16 +0200
Message-ID: <4E006BEC.7010202@canonical.com>
References: <s5hvcw04k50.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id DB602103839
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 12:01:20 +0200 (CEST)
In-Reply-To: <s5hvcw04k50.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, alex.baldacchino.alsasub@gmail.com, haraldwelte@viatech.com, lydiawang <lydiawang@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

On 2011-06-20 17:06, Takashi Iwai wrote:
> Hi,
>
> as there have many problems reported for VIA codecs, I started looking
> at the driver code, and decided to rework on it.

Excellent initiative, thanks!

> The current development is found in sound git tree topic/via-cleanup
> branch:
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
> You can pull into the latest Linus tree from topic/via-cleanup
> branch:
>     # this is the vanilla tree
>     % cd linux-2.6
>     % git pull \
>        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git \
>        topic/via-cleanup

The tree as of today, is now also available for easy testing for Ubuntu 
users: Just download and install 
http://people.canonical.com/~diwic/temp/alsa-hda-dkms-viacleanup_0.1_all.deb 
(works at least on Ubuntu 10.10 and 11.04), reboot and test.

> But, the driver isn't tested with real machines, yet.  That is, I need
> testers with real machines.
>
> Could VIA machine owners take a look at these commits and test it if
> possible?  Especially, I'd like to know whether the headphone
> auto-mute works in this form or not.

I have tested the new driver code on a machine here, and automute does 
work. There is however no enable/disable automute yet, as Realtek has. 
There are no input jack devices either (i e those we're debating in the 
other thread).

On the input side I notice a minor thing: "Front Mic Playback Volume" 
has an unneccessary index on it. Well, the Front mic is actually an 
internal mic, but that's BIOS lying to us, I guess.

Otherwise it seems to work fine here, so well done! :-)

> Also, if anyone has alsa-info.sh outputs of VIA codecs, please let me
> know.  It'd be very helpful for debugging, since I can check it via
> hda-emu with alsa-info.sh output.  For now, I have the files of only
> VT1702, VT1708S, VT1718S, VT1828S and VT2020 codecs.  The alsa-info.sh
> outputs of other VIA codecs would be greatly appreciated.

Alsa-info for the machine I have here will follow shortly.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
