From: Daniel James <daniel@64studio.com>
Subject: Re: crash/reboot with rawmidi on ice1712 dual opteron
Date: Tue, 24 Apr 2007 15:23:52 +0100
Message-ID: <462E12F8.3090005@64studio.com>
References: <461FD727.8080400@bome.com>
	<s5hfy6zcmtc.wl%tiwai@suse.de>	<4626361D.3080801@bome.com>
	<s5hmz0y0w6m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heisenberg.zen.co.uk (heisenberg.zen.co.uk [212.23.3.141])
	by alsa0.perex.cz (Postfix) with ESMTP id D780E24906
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2007 16:24:36 +0200 (CEST)
In-Reply-To: <s5hmz0y0w6m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Florian <alsa@bome.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi, hi Florian,

I found a similar MIDI crashing bug on a dual Opteron machine in 2005, 
even with only one processor installed, which I reported at the time on 
alsa-devel. The card was an M-Audio Audiophile 24/96, normally reliable.

I couldn't replicate this problem on an Asus single processor Opteron 
board, so I concluded it was a quirk of my dual socket Tyan S2875 
motherboard:

http://article.gmane.org/gmane.linux.alsa.devel/24682/
http://article.gmane.org/gmane.linux.alsa.devel/25323/

Last time I tested it, earlier this year I think, the bug was still 
there. I even flashed the BIOS of the Tyan board in case it was a BIOS 
bug, but it made no difference. I installed a 32-bit distro and that 
made no difference either.

Maybe there is something more generally wrong here, which only affects 
dual-processor AMD64 hardware. I can make the Tyan machine available 
over SSH if that helps, it has a fixed IP address.

Cheers!

Daniel
