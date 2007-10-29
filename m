From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: Sample format coversion bug?
Date: Mon, 29 Oct 2007 11:47:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0710291141280.16052@shell4.speakeasy.net>
References: <4721E932.5090603@ums.usu.ru> <s5hpryyny19.wl%tiwai@suse.de>
	<4725BD78.6040709@ums.usu.ru> <s5hk5p6nveb.wl%tiwai@suse.de>
	<4725F66F.10805@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail5.sea5.speakeasy.net (mail5.sea5.speakeasy.net
	[69.17.117.7]) by alsa0.perex.cz (Postfix) with ESMTP id 7709E24529
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 19:47:35 +0100 (CET)
In-Reply-To: <4725F66F.10805@ums.usu.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Oct 2007, Alexander E. Patrakov wrote:
> Even though mmap seems to be supported in the driver source (judging
> from .info = SNDRV_PCM_INFO_MMAP | other flags), I could not figure out
> the parameters that work. Moreover, the driver seems to accept the same
> hardware parameters without the mmap, and I could not find parameters
> that the driver accepts for mmap.

I do not think the saa7134-alsa driver supports mmap.  The cx88-alsa driver
also claimed to support mmap, but it never worked until I fixed it.  It's
pretty clear that the code in saa7134-alsa was based on the same code as
cx88-alsa, so it's likely it has the same bug.

> One more question: since plug doesn't work at all on devices without
> mmap available, does this mean that I should scrap my original idea
> about using plug to convert everything into S24?

Does plug require mmap?  It does it just require that devices which claim
to support mmap actually work in mmap mode?
