From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [Bug #10679] 2.6.26-rc1
 regression:	e5e1d3cb20034a3cbcfff1f0bae12201aa2ce17e breaks artsd
Date: Sun, 18 May 2008 07:13:07 +0400
Message-ID: <482F9EC3.8010907@aknet.ru>
References: <hPXlJLjt4XG.A._lF.Jv1JIB@chimera>
	<88YBFoyd1CN.A._sF.Ov1JIB@chimera>
	<s5hskwmeb1h.wl%tiwai@suse.de> <20080514212011.GH7054@mit.edu>
	<s5hhcd0azv1.wl%tiwai@suse.de> <20080515130654.GC18825@mit.edu>
	<s5h8wybr0c2.wl%tiwai@suse.de>
	<20080517204725.GA11460@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C5FF103807
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 01:13:16 +0200 (CEST)
In-Reply-To: <20080517204725.GA11460@codemonkey.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello.

Dave Jones wrote:
> More seriously, it doesn't seem that there's any way we can build
> this driver modular without it screwing up already working systems
Actually, I have just upgraded
f8->f9, and guess what? Lost the
sound... And not because of snd-pcsp,
but rather because snd-hda-intel
started to take the first slot
and snd-intel8x0 takes the second.
On f8 snd-hda-intel have never been
loaded for me at all. I don't need
it, it finds a HDA chip on an ATI
video board, which it never did before.

So... it doesn't look like this
problem is specific to snd-pcsp.
Anyone can get into that trouble
it seems.
