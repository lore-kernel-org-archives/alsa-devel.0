From: Andrei Tanas <andrei@tanas.ca>
Subject: Re:
 =?utf-8?q?Asus_P5QL-EM_motherboard_=28ALC1200_codec?=
 =?utf-8?q?=29_-=09no=09sound_through_S/PDIF?=
Date: Thu, 13 Nov 2008 09:52:03 -0500
Message-ID: <45906fd26f62412a3c5030b12fead9dd@localhost>
References: <668af2a1e877d41c059f6c84fa462476@localhost>
	<1226564212.605116.29828@de> <s5htzacqbg8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B3A62457D
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 15:52:05 +0100 (CET)
In-Reply-To: <s5htzacqbg8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Nov 2008 09:25:43 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> Also, try sound-2.6.git tree instead.
>     git://git.kernel.org/pub/scm/linux/kernel/people/tiwai/sound-2.6.git

patch_realtek.c are identical and hda_intel.c show only minor differences
which don't look related in this and "alsa-kernel" get tree that I used. Do
you think I should still try it?

Is there some "official" method of debugging this: is it possible to see
what the driver is doing with the data stream fed to it (other than
inserting a bunch of printk's in the code)?

Thanks.
