From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Date: Wed, 19 Aug 2009 13:42:07 +0100
Message-ID: <20090819124206.GA20838@rakim.wolfsonmicro.main>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
	<20090819122801.GC20227@rakim.wolfsonmicro.main>
	<s5hvdkkasgl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3499F243F1
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 14:42:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvdkkasgl.wl%tiwai@suse.de>
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
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 19, 2009 at 02:39:06PM +0200, Takashi Iwai wrote:

> Note that it's snd_pcm_lib_malloc_pages(), not the kernel's standard
> one like alloc_pages().  The former frees the old buffer by itself
> when resized, so you don't need to call snd_pcm_lib_free_pages()
> (as long as it's called in hw_free callback).

Oh, so it does - I misread the code as only shrinking an existing
buffer.
