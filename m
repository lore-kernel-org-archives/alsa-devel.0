From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fixups of ALSA memory maps
Date: Mon, 16 Nov 2009 18:06:41 +0100
Message-ID: <20091116170641.GD14948@linux-mips.org>
References: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eddie.linux-mips.org (eddie.linux-mips.org [78.24.191.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FB6F1038EB
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 18:06:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33615 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493432AbZKPRGi (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Mon, 16 Nov 2009 18:06:38 +0100
Content-Disposition: inline
In-Reply-To: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Wu Zhangjin <wuzj@lemote.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2009 at 12:48:14AM +0800, Wu Zhangjin wrote:

> Seems this is MIPS specific, but it's not that easy to move this patch
> into the arch/mips part, So, any better solution?
> 
> Thanks & Regards,
>        Wu Zhangjin
> 
> ------------------------
> 
> The user application mmap audio dma regions must be dma-coherent. This
> patch fix it.
> 
> Without this patch, artsd will fail on boot, and mplayer will exit with
> "Segmentation fault". (this happens on YeeLoong netbook, fuloong2f
> mini pc with snd_cs5535 audio card)
> 
> This is originally from the to-mips branch of
> http://dev.lemote.com/code/linux_loongson, and contributed by Yanhua
> from Lemote Inc.
> 
> Reported-by: qiaochong <qiaochong@gmail.com>
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>

This issue is an old ghost still around, see:

   http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060124.132832.37533152.nemoto%40toshiba-tops.co.jp

which is a superset of your proposed patch and which itself is refering to
an even older posting from 2003:

   http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20030523215935.71373.qmail%40web11901.mail.yahoo.com

The #ifdef'ed solution doesn't cut it for sure.  Let's see what better we
can find ...

  Ralf
