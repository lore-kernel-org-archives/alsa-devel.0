From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Input/output error while playing a file using aplay
Date: Tue, 26 Jun 2007 15:17:58 +0200
Message-ID: <1182863878.22603.1197116759@webmail.messagingengine.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
	<1182769239.15228.1196888507@webmail.messagingengine.com>
	<61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
	<61445c750706250635i61be8752lbf7a7b1930a8ca79@mail.gmail.com>
	<61445c750706251138r290c2a7br6b911be6da7e53ce@mail.gmail.com>
	<1182842511.3512.1197069785@webmail.messagingengine.com>
	<61445c750706260351v2ef766bbrb8685275a0451cec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 26701103816
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2007 15:17:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706260351v2ef766bbrb8685275a0451cec@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
>                 src = omap_get_dma_src_pos(s->lch[s->dma_q_head]);
>                 offset = src - runtime->dma_addr;
>                 printk("src is %u and offset is %u\n",dest,offset);
> 
> src is 3246792928 and offset is 3304194048
> Returning pos = 20742144
> ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x13c8000, buffer size = 0x4000, period size = 0x800

dma_addr = 0xFC9420E0 (is this correct?)
src      = 0xC18620E0
offset   = 0xC4F20000

Apparently, the return value of omap_get_dma_src_pos() is wrong.
Should this value be 16 bits?


Regards,
Clemens
