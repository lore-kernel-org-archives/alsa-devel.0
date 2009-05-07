From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: 2.6.29 regression: left audio channel broken after
 resume from suspend with Intel HDA
Date: Thu, 07 May 2009 00:40:37 -0700
Message-ID: <1241682037.1864.4.camel@unix>
References: <20090420194659.GA11399@dose.home.local>
	<s5h8wluinon.wl%tiwai@suse.de> <20090421073219.GA5866@dose.home.local>
	<s5hfxg2cv6m.wl%tiwai@suse.de> <20090421183936.GA21935@dose.home.local>
	<s5hws9a5ewr.wl%tiwai@suse.de> <20090424142113.GA18668@dose.home.local>
	<s5hskjy5d2t.wl%tiwai@suse.de> <20090428002309.GA29572@x61>
	<20090506222753.GA6728@mac.home>  <20090507072352.GA6513@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C87524795
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 09:40:37 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so455734rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 00:40:35 -0700 (PDT)
In-Reply-To: <20090507072352.GA6513@mac.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tino Keitel <tino.keitel@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-05-07 at 09:23 +0200, Tino Keitel wrote:
> On Thu, May 07, 2009 at 00:27:53 +0200, Tino Keitel wrote:
> > On Tue, Apr 28, 2009 at 02:23:09 +0200, Tino Keitel wrote:
> > 
> > [...]
> > 
> > > I just saw another, major problem: line in doesn't work anymore with
> > > 2.6.29 and also 2.6.30-rc3 (no usable input level). It works with
> > > 2.6.27.20.
> > 
> > FYI: I just tried 2.6.28 and line-in was still broken. So the last
> > working kernel is 2.6.27.
> 
> I tried this:
> 
> git bisect start v2.6.28 v2.6.27 sound/pci/hda/patch_sigmatel.c
> 
> The result is commit 4f1e6bc3646ab50b8181555ab7e6eeab68b8632a.
> 
> I can't use git revert because of conflicts, so I crafted the attached
> patch against 2.6.30-rc4-00288-g413f81e, and now line-in works.
> 
> Regards,
> Tino

It's funny you mention left audio broken
with hda(testing out the imac91.patch,
works good, but as soon as I boot into osx
the left audio speaker sounds blown out)
nice... ehhh...

(probably nothing of the sort, but
you never know)

Justin P. Mattock
