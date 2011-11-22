From: Dmitry Nezhevenko <dion@inhex.net>
Subject: Re: Commit d6cc9fabd58f33e829a3182aa856db0d57c726ef
 breaks built-in mic on ASUS F6A
Date: Tue, 22 Nov 2011 15:27:43 +0200
Message-ID: <20111122132743.GA4514@laptop.local>
References: <20111121192713.GA3677@laptop.local> <s5hr511iczy.wl%tiwai@suse.de>
	<20111121183816.GA23354@laptop.local>
	<s5hy5v83ai3.wl%tiwai@suse.de> <s5hwras3a6z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dion.org.ua (dion.org.ua [193.104.35.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 336B0243DD
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 14:27:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwras3a6z.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 08:09:24AM +0100, Takashi Iwai wrote:
> > OK, then pass model=auto option to snd-hda-intel module (and adjust
> > the mixer elements appropriately after that).  It seems that the
> > static model config  got broken, and it's no longer needed.
> > In 3.2 tree, these static setups have been already removed.

This way works great on 3.1. Thanks.
 
> Alternatively, try the patch below.  This will fix just the capture
> bug but anything else is untouched.  If it's confirmed to work, I'll
> send it to stable kernel separately since this can't be applied to the
> upstream tree any longer.

It doesn't work. Still produces noise but a bit louder.

-- 
WBR, Dmitry
