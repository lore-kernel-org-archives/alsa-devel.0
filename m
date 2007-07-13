From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: M-Audio Audiophile USB - Remaining issues
Date: Fri, 13 Jul 2007 16:51:31 +0200
Message-ID: <000001c7c55d$50a50190$161ce4a0@supelec.fr>
References: <s5hzm20zkuz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpn.supelec.fr (smtpn.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id EA1B91037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 16:51:45 +0200 (CEST)
Received: from lemeurnx (lemeur-nx.supelec.fr [160.228.28.22])
	by smtpn.supelec.fr (8.14.1/8.13.8) with ESMTP id l6DEpV6k002497
	for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2007 16:51:44 +0200
In-Reply-To: <s5hzm20zkuz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

For the M-Audio Audiophile USB device I still see 3 tasks that could be done
to improve support under Alsa:

1- Remap the Alsa 'hardware pcm devices'

Currently:
* hw:1,0 is bound to the Analog interface in playback mode but to the
Digital interface in capture mode 
* hw:1,1 is bound to the Analog interface in capture mode but to the Digital
interface in playback mode

It would be great if the one pcm device+subdevice was always linked to the
same interface (Analog or Digital)
Can anyone could point me to the piece of code that chooses the mapping
between the device physiscal interface and Alsa's pcm interface? I'll try to
see if I can fix this.

2- Have the device able to act as a 4 channels-in + 4 channels-out combined
device under Jackd
I had no success in defining a multi pcm device and have it work under Jackd
(but this might be a Jackd issue).

Just a question about this: in the "Multiple ICE1712 Sound Cards" tutorial,
it is said that :
"A change was made in alsa-lib-1.0.9rc1 which had the unintended effect of
preventing the pcm_multi plugin from working with jackd (or jackdmp) in
duplex mode" "To make it work it's necessary to remove the linking code
which was added in pcm_multi.c rev 1.89. It isn't needed here anyway. Here's
a patch(http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch) that removes
it from alsa-lib versions 1.0.10 to 1.0.13."

Is it still true with current versions of alsa-lib?


3- Have a user interface to switch device_setup modes
This may be the hardest to do and I don't think I've got the required skills
to do this. Anyway, I would realy appreciate any information (or existing
piece of code) about the following: 
* how to write a user interface which interacts with the kernel module
* forcing a reinitialization of the snd-usb-audio module without
unprobing/reprobing the kernel module


Thanks in advance,
Thibault
