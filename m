From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA 1.0.17rc2 release
Date: Tue, 17 Jun 2008 16:42:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806171640330.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
	<200806171018.52879.gineera@aspect135.co.uk>
	<200806171116.27558.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0806171341290.1798@tm8103-a.perex-int.cz>
	<s5hfxrc9t98.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806171411290.1798@tm8103-a.perex-int.cz>
	<s5h8wx49q3j.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806171515540.1798@tm8103-a.perex-int.cz>
	<s5h63s89oie.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806171614060.1798@tm8103-a.perex-int.cz>
	<s5htzfs86u7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D2E3244E6
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 16:42:45 +0200 (CEST)
In-Reply-To: <s5htzfs86u7.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Jun 2008, Takashi Iwai wrote:

> Yeah, indeed.  Thanks.
> 
> Meanwhile, I cleaned it up too.

Yes, my patch was a bit complicated, because I assumed (not sure why) that 
second alloc_page uses same range as first one so the change to allocate 
page from lower area will be higher. But GFP_DMA takes page from another 
area so this "page hold" is not necessary. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
