From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [Bug #10679] 2.6.26-rc1
 regression:	e5e1d3cb20034a3cbcfff1f0bae12201aa2ce17e breaks artsd
Date: Thu, 22 May 2008 08:38:08 +0400
Message-ID: <4834F8B0.3080409@aknet.ru>
References: <hPXlJLjt4XG.A._lF.Jv1JIB@chimera>	<88YBFoyd1CN.A._sF.Ov1JIB@chimera>	<s5hskwmeb1h.wl%tiwai@suse.de>	<20080514212011.GH7054@mit.edu>	<s5hhcd0azv1.wl%tiwai@suse.de>	<20080515130654.GC18825@mit.edu>	<s5h8wybr0c2.wl%tiwai@suse.de>	<20080517204725.GA11460@codemonkey.org.uk>	<482F9EC3.8010907@aknet.ru>
	<s5hr6c0kq5q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id A55FD246E8
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 06:38:17 +0200 (CEST)
In-Reply-To: <s5hr6c0kq5q.wl%tiwai@suse.de>
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

Hello.

Takashi Iwai wrote:
> You can better use slots option for snd module instead of specifying
> index in each driver for 2.6.25 or later kernels.  That is,
> 	options snd slots=snd-intel8x0,snd-hda-intel
Thanks.
How about this:
	options snd slots=!snd-pcsp
I guess implementing something like
this, is asking for a troubles, but
maybe this can be a chip solution
for the snd-pcsp problem...
