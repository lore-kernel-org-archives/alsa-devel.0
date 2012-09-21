From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: Infinite loop in snd_pcm_hw_htimestamp() for
 capture	PCMs?
Date: Fri, 21 Sep 2012 11:15:59 -0500
Message-ID: <20120921161559.GI4615@foghorn.codeweavers.com>
References: <20120921155343.GH4615@foghorn.codeweavers.com>
 <s5ha9wjpdog.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DD6265DB1
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 18:16:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha9wjpdog.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Eikum <aeikum@codeweavers.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 21, 2012 at 06:02:07PM +0200, Takashi Iwai wrote:
> At Fri, 21 Sep 2012 10:53:43 -0500,
> Andrew Eikum wrote:
> > I've found some unexpected behavior in alsa-lib. The attached program
> > uses 100% CPU in an infinite loop, when I'd expect it to return either
> > an error or a valid htimestamp. I believe the loop occurs in
> > <src/pcm/pcm_hw.c:snd_pcm_hw_htimestamp()>. Am I not supposed to call
> > htimestamp() on this type of PCM? Is the PCM still in an invalid state
> > when htimestamp() is called?
> 
> Indeed, it's a bug in dmix/dsnoop/dshare plugins.
> Fixed now in git tree.
> 

Thanks for the fix.

Andrew
