From: Dmitry Nezhevenko <dion@inhex.net>
Subject: Re: Commit d6cc9fabd58f33e829a3182aa856db0d57c726ef
 breaks built-in mic on ASUS F6A
Date: Wed, 23 Nov 2011 13:36:38 +0200
Message-ID: <20111123113638.GA3338@laptop.local>
References: <20111121192713.GA3677@laptop.local> <s5hr511iczy.wl%tiwai@suse.de>
	<20111121183816.GA23354@laptop.local>
	<s5hy5v83ai3.wl%tiwai@suse.de> <s5hwras3a6z.wl%tiwai@suse.de>
	<20111122132743.GA4514@laptop.local> <s5h1ut0i8u4.wl%tiwai@suse.de>
	<20111122142736.GA29369@castle.dion.org.ua>
	<s5hfwhggj5s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dion.org.ua (dion.org.ua [193.104.35.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 1806C2440E
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 12:36:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfwhggj5s.wl%tiwai@suse.de>
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

On Tue, Nov 22, 2011 at 06:29:35PM +0100, Takashi Iwai wrote:
> > Attaching it (snd_hda_intel was loaded without any parameters)
> 
> Thanks.  I found another bug that happens almost only with static
> configs.  Try the patch below in addition to the previous one.
> 

It looks like now I'm more lucky. Two patches fixes my issue without
model=auto.

Thanks a lot!.
-- 
WBR, Dmitry
