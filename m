From: Peter Niemayer <niemayer@isg.de>
Subject: Re: spdif/iec958 outputs at VT1708S not recognized
Date: Fri, 08 May 2009 11:21:54 +0200
Message-ID: <4A03F9B2.2020904@isg.de>
References: <gt9gvo$ocq$1@ger.gmane.org>
	<s5hmy9zfqhn.wl%tiwai@suse.de>	<4A001971.5020803@isg.de>
	<s5hbpq52e1h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 187781038B9
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 11:22:09 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M2MHP-0004Hu-Km
	for alsa-devel@alsa-project.org; Fri, 08 May 2009 09:22:07 +0000
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 09:22:07 +0000
Received: from niemayer by barriere.frankfurter-softwarefabrik.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 May 2009 09:22:07 +0000
In-Reply-To: <s5hbpq52e1h.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
 > Could you try the patch below?  It's against the latest sound git tree,
 > but likely applicable to a bit older one, too.

 > diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c

Your patch to patch_via.c was applicable (with a little manual
help from my side) to the 2.6.29 sources, but it seems to depend on
an earlier git commit of yours regarding multi-digital-out support,
and that patch (which I found in a git browser on the web) is
not applicable to the 2.6.29 sources, there are lots of rejections.

Is there a way to pull just the sound/pci/hda subdirectory from
your repository (without cloning the whole 150MB repository)?
Or can you just mail me a .tar.bz2 of the relevant kernel source
subdirectory?

Thanks a lot for your efforts!

Regards,

Peter Niemayer
