From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [patch] snd-pcsp: put back the compatibility code
Date: Fri, 16 May 2008 20:20:02 +0200
Message-ID: <482DD052.80201@keyaccess.nl>
References: <hPXlJLjt4XG.A._lF.Jv1JIB@chimera>	<88YBFoyd1CN.A._sF.Ov1JIB@chimera>	<s5hskwmeb1h.wl%tiwai@suse.de>	<20080514212011.GH7054@mit.edu>	<s5hhcd0azv1.wl%tiwai@suse.de>	<20080515130654.GC18825@mit.edu>	<s5h8wybr0c2.wl%tiwai@suse.de>
	<482DCE53.1000406@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 72EFC249FC
	for <alsa-devel@alsa-project.org>;
	Fri, 16 May 2008 20:18:05 +0200 (CEST)
In-Reply-To: <482DCE53.1000406@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Theodore Tso <tytso@mit.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Roberto Oppedisano <roberto.oppedisano@infracom.it>
List-Id: alsa-devel@alsa-project.org

On 16-05-08 20:11, Stas Sergeev wrote:

> The attached patch adds back the
> compatibility code, allowing the
> driver to work with older alsa-libs.
> The removal was premature, it breaks
> the real-life configs, I am sorry
> about that.
> 
> Takashi, could you please apply?
> It is a straight-forward revert of:
> http://hg-mirror.alsa-project.org/alsa-kernel/diff/26b0243ab4fa/drivers/pcsp/pcsp_lib.c

Thanks. Probably .26 material; many people will likely just disable the 
driver upon not seeing it work (and not re-enable it later also, meaning 
it might be a very largely unused driver) otherwise.

Rene.
