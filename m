From: Daniel Mack <daniel@caiaq.de>
Subject: Re: device underruns
Date: Mon, 27 Apr 2009 16:28:18 +0200
Message-ID: <20090427142818.GD10969@buzzloop.caiaq.de>
References: <20090331144603.GJ16811@buzzloop.caiaq.de>
	<20090425122338.GE23274@buzzloop.caiaq.de>
	<s5hk557wtlv.wl%tiwai@suse.de>
	<20090427100502.GC8196@buzzloop.caiaq.de>
	<s5hljpmh0ch.wl%tiwai@suse.de>
	<20090427101805.GE8196@buzzloop.caiaq.de>
	<s5hd4aygz7p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B0821038F6
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 16:28:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd4aygz7p.wl%tiwai@suse.de>
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

On Mon, Apr 27, 2009 at 12:36:42PM +0200, Takashi Iwai wrote:
> > >From d50433f1047b85b150737c2f2588763ead2096ce Mon Sep 17 00:00:00 2001
> > From: Daniel Mack <daniel@caiaq.de>
> > Date: Mon, 27 Apr 2009 12:14:23 +0200
> > Subject: [PATCH] ALSA: snd-usb-caiaq: fix reported elapsed periods
> > 
> > Reset the internal period position counter upon stream startup. This
> > fixes initial aplay underruns and problems related to latency picky
> > applications such as pulseaudio.
> > 
> > Bumped the version number to 1.3.14.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> 
> Thanks, applied now.

Thanks :)

As this is a serious bugfix, it should make it into 2.6.30.

Daniel
