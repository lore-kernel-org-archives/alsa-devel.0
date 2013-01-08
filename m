From: Maurizio Avogadro <mavoga@gmail.com>
Subject: Re: [3.6.9 -> 3.7.1 regression] sound: snd_hda_intel codec probing
 issue?
Date: Tue, 08 Jan 2013 09:55:58 +0100
Message-ID: <50EBDF1E.2060505@gmail.com>
References: <1356704740.3953.26.camel@lamella> <s5hvcber5cz.wl%tiwai@suse.de> <50EBD772.3090008@gmail.com> <s5htxqsyt7g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htxqsyt7g.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vincent Blut <vincent.debian@free.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

08/01/2013 09:28 Takashi Iwai wrote:
> [...]
> 
> BTW, the problem is related rather with the controller chip, not the
> codec chip.  In Vincent's case, it's 8086:1e20,
>   Intel Corporation 7 Series/C210 Series Chipset Family High
>   Definition Audio Controller (rev 04)

Here I have

00:1b.0 0403: 8086:1c20 (rev 05)
00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
Family High Definition Audio Controller (rev 05)

Thanks


Maurizio
