From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [Bug #10679] 2.6.26-rc1
 regression:	e5e1d3cb20034a3cbcfff1f0bae12201aa2ce17e breaks artsd
Date: Sun, 18 May 2008 02:09:32 +0400
Message-ID: <482F579C.4090900@aknet.ru>
References: <hPXlJLjt4XG.A._lF.Jv1JIB@chimera>
	<88YBFoyd1CN.A._sF.Ov1JIB@chimera>
	<s5hskwmeb1h.wl%tiwai@suse.de> <20080514212011.GH7054@mit.edu>
	<s5hhcd0azv1.wl%tiwai@suse.de> <20080515130654.GC18825@mit.edu>
	<s5h8wybr0c2.wl%tiwai@suse.de>
	<20080517204725.GA11460@codemonkey.org.uk>
	<482F47DC.60505@aknet.ru>
	<20080517213231.GA31440@codemonkey.org.uk>
	<482F56A5.7000008@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 42E4610382E
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 00:09:49 +0200 (CEST)
In-Reply-To: <482F56A5.7000008@aknet.ru>
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

Stas Sergeev wrote:
> for the "movable" index. For example,
> the index -2 can mean "use the first
> free slot, but move to the next one
> when some other driver is registering
> with -1 or explicitly to that slot".
> Of course I have no idea whether this
> is possible and acceptable, but maybe
... and for the obvious reasons this can't
work.
