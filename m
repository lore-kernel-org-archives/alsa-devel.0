From: Vedran Rodic <vedran@quark.fsb.hr>
Subject: Re: [Alsa-devel] trouble with dosemu and alsa oss emulation (and a fix for alsa)
Date: Mon, 8 Sep 2003 16:45:30 +0200
Sender: linux-msdos-owner@vger.kernel.org
Message-ID: <20030908144530.GA24131@quark.fsb.hr>
References: <20030906200943.GA5128@quark.fsb.hr> <Pine.LNX.4.53.0309080913350.30087@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-msdos-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309080913350.30087@pnote.perex-int.cz>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net, linux-msdos@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2003 at 09:14:40AM +0200, Jaroslav Kysela wrote:
> On Sat, 6 Sep 2003, Vedran Rodic wrote:
> 
> > Hi.
> >
> > I'm having trouble with latest ALSA and oss emulation. I'm using dosemu to
> > play some DOS games and I've noticed that sound in DOS apps stops playing
> > after short time (depending on the app).
> >
> >
> > I'm regulary updating both alsa and dosemu, I suspected dosemu first, since
> > I had no problems whatsoever with alsa oss emulation.
> >
> > It turned out that this was not dosemu problem, but alsa oss emulation problem.
> > I've tracked it down to a change in  alsa-kernel/core/oss/pcm_oss.c.
> > The change is here:
> > http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/alsa/alsa-kernel/core/oss/pcm_oss.c.diff?r1=1.40&r2=1.41
> 
> Please, try patch bellow.

It solved the problem. Thanks

Vedran
