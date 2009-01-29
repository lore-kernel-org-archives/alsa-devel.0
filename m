From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] ess1688: fix OPL3 port setting
Date: Thu, 29 Jan 2009 15:55:27 +0100
Message-ID: <20090129155527.1abc61e4.krzysztof.h1@poczta.fm>
References: <20090125211031.32d37d66.krzysztof.h1@poczta.fm>
	<497CE243.5010400@gmail.com> <s5hbptu5rp6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 26F69103891
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 15:52:02 +0100 (CET)
In-Reply-To: <s5hbptu5rp6.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Jan 2009 10:42:29 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 25 Jan 2009 23:05:55 +0100,
> Rene Herman wrote:
> > 
> > On 25-01-09 21:10, Krzysztof Helt wrote:
> > 
> > > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > > 
> > > The ess1688 driver uses the same port
> > > for PCM audio (SB compatible) and OPL3
> > > synthesis. It is wrong so allow to
> > > choose a correct port for OPL3 synthesis.
> > 
> > Only a very quick reply -- generally, the low 2 SB ports are indeed OPL3 
> > compatible (or was it just OPL2? ...)
> 
> All devices have separate OPL3 I/O ports.  So there must be a
> reason...
> 

The ESS 688 datasheet states that FM chip select signal (FMCSB) 
is activated when one of the port ranges: 
388H-389H, 2x8H-2x9H, 2x0H-2x3H
is selected. The current code may work on on the ESS 688. 
However, it obviously does not work with the ESS 1688 (bug #282).
The bug report states that the OPL3 synthesis works with the
OSS driver which chooses the 0x388 port for the OPL3.

My patch adds a new port setting so it is still possible to set
the fm_port value the same as the port value. No change here.
However, it allows setting different values to the port and the
fm_port setting if needed.

Takashi, please consider applying my patch to the alsa tree.

Regards,
Krzysztof

----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019
