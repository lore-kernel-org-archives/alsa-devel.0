From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH] ALSA: usb: Work around CM6631 sample rate
 change bug
Date: Mon, 4 Mar 2013 22:29:19 +0100
Message-ID: <20130304212919.GF4452@pvv.ntnu.no>
References: <20130302130403.GD4452@pvv.ntnu.no> <5131FAC1.30007@gmail.com>
 <20130303192922.GE4452@pvv.ntnu.no> <s5hlia3ilzx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 320B6265160
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 22:29:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hlia3ilzx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 04, 2013 at 09:53:54AM +0100, Takashi Iwai wrote:
> At Sun, 3 Mar 2013 20:29:22 +0100,
> Torstein Hegge wrote:
> > While this does fix the sample rate change problem, it introduces a new
> > problem. With at least one media player application (xbmc) this patch
> > causes the usb sound card to not output sound when starting a video
> > file. Skipping forward or backward in the video stream restores audio
> > output.
> > 
> > I haven't yet been able to look into why this happens, or why xbmc
> > behaves different from mplayer and vlc.
> 
> If the reset of interface is needed only when *changing* SRC, we can
> check the current rate against the previous rate and skip the reset?

That's right. I tried that, and it appears to have solved the issue with
xbmc. I'll clean up that code and send an updated patch.

Thanks.

Torstein
