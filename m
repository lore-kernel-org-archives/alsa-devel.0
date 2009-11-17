From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fixups of ALSA memory maps
Date: Tue, 17 Nov 2009 14:50:03 +0100
Message-ID: <20091117135003.GB27085@linux-mips.org>
References: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com>
	<20091116170641.GD14948@linux-mips.org>
	<s5hbpj2ie8p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eddie.linux-mips.org (eddie.linux-mips.org [78.24.191.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A65810384D
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 14:49:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36331 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492919AbZKQNt6 (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Tue, 17 Nov 2009 14:49:58 +0100
Content-Disposition: inline
In-Reply-To: <s5hbpj2ie8p.wl%tiwai@suse.de>
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Wu Zhangjin <wuzhangjin@gmail.com>, linux-kernel@vger.kernel.org, Wu Zhangjin <wuzj@lemote.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 16, 2009 at 06:14:14PM +0100, Takashi Iwai wrote:

> > > Seems this is MIPS specific, but it's not that easy to move this patch
> > > into the arch/mips part, So, any better solution?
> > > 
> > > Thanks & Regards,
> > >        Wu Zhangjin
> > > 
> > > ------------------------
> > > 
> > > The user application mmap audio dma regions must be dma-coherent. This
> > > patch fix it.
> > > 
> > > Without this patch, artsd will fail on boot, and mplayer will exit with
> > > "Segmentation fault". (this happens on YeeLoong netbook, fuloong2f
> > > mini pc with snd_cs5535 audio card)
> > > 
> > > This is originally from the to-mips branch of
> > > http://dev.lemote.com/code/linux_loongson, and contributed by Yanhua
> > > from Lemote Inc.
> > > 
> > > Reported-by: qiaochong <qiaochong@gmail.com>
> > > Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
> > 
> > This issue is an old ghost still around, see:
> > 
> >    http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060124.132832.37533152.nemoto%40toshiba-tops.co.jp
> > 
> > which is a superset of your proposed patch and which itself is refering to
> > an even older posting from 2003:
> > 
> >    http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20030523215935.71373.qmail%40web11901.mail.yahoo.com
> > 
> > The #ifdef'ed solution doesn't cut it for sure.  Let's see what better we
> > can find ...
> 
> Indeed.  My preference option is to deploy dma_mmap_coherent() to
> possible architectures and use it commonly in the ALSA core code.
> 
> But, as a temporary workaround, I'm fine with ifdef until the API is
> defined...

There is a MIPS platform which may be based on a variety of system
controllers only one of which supports cache coherency.  So we want to
deciede at runtime not at compile time.

  Ralf
