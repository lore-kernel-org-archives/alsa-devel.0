From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re:
Date: Thu, 6 Sep 2012 08:02:20 +0200
Message-ID: <20120906060220.GA252@x4>
References: <s5hmx1526mg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hmx1526mg.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2012.09.04 at 16:40 +0200, Takashi Iwai wrote:
> ----------------------------------------------------------------
> Sound fixes for 3.6-rc5
> 
> There are nothing scaring, contains only small fixes for HD-audio and
> USB-audio:
> - EPSS regression fix and GPIO fix for HD-audio IDT codecs
> - A series of USB-audio regression fixes that are found since 3.5 kernel
> 
> ----------------------------------------------------------------
> Daniel Mack (4):
>       ALSA: snd-usb: Fix URB cancellation at stream start
>       ALSA: snd-usb: restore delay information
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
The commit fbcfbf5f above causes the following lines to be printed
whenever I start a new song:

delay: estimated 0, actual 352
delay: estimated 353, actual 705

(44.1 * 8 = 352.8)

This happens with an USB-DAC that identifies itself as "C-Media USB
Headphone Set".

-- 
Markus
