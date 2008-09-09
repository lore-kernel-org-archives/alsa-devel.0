From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problems with pulseaudio / asla on PS3
Date: Tue, 9 Sep 2008 10:53:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0809091051310.1221@tm8103.perex-int.cz>
References: <200809050842.08596.kevin952@tpg.com.au>
	<s5hwshrt84y.wl%tiwai@suse.de>
	<200809052102.06534.kevin952@tpg.com.au>
	<20080908202135.GA5221@tango.0pointer.de>
	<s5hmyihu2yr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A3F722454A
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:53:09 +0200 (CEST)
In-Reply-To: <s5hmyihu2yr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Sep 2008, Takashi Iwai wrote:

> At Mon, 8 Sep 2008 22:21:36 +0200,
> Lennart Poettering wrote:
> > 
> > On Fri, 05.09.08 21:02, Kevin Gilbert (kevin952@tpg.com.au) wrote:
> > 
> > > 
> > > Hi Takashi,
> > > 
> > > On Fri, 5 Sep 2008, Takashi Iwai opined:
> > > > Well, it's no bug in softvol, at least.  The softvol doesn't do any
> > > > format or layout conversions.  The layout conversion is done via plug
> > > > plugin applied onto the softvol.
> > > 
> > > OK (not that I fully understand what you have said) but where does that leave 
> > > me? Is there something that I should try? Some ALSA or kernel configuration 
> > > option that might be in error?
> > 
> > Takashi, as Kevin wrote originally, the problem is not that softvol
> > doesn't do any format/layout conversions, but that it claims it
> > does. PA asks softvol for INTERLEAVED samples, softvol agrees to
> > that -- and actually hands us only NONINTERLEAVED samples because it
> > doesn't reformat the from the underlying layer.
> > 
> > So, it *is* a bug in softvol. However, you are right that it doesn't
> > do any conversions.
> 
> Does it happen only with softvol?  For example, try to put any
> other conversion, such as, linear plugin instead of softvol.
> Could you check whether it works?
> 
> Basically softvol does nothing special, just like other normal plugins.
> So I don't think this is specific to softvol.

Also, output from snd_pcm_dump() after initialization (before samples r/w) 
might help us to determine the problem. I'll try to reproduce this 
behavior with the snd-dummy module.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
