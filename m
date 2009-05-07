From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: 2.6.29 regression: left audio channel broken after
 resume from suspend with Intel HDA
Date: Thu, 07 May 2009 13:56:05 -0700
Message-ID: <1241729765.13392.2.camel@unix>
References: <20090420194659.GA11399@dose.home.local>
	<s5h8wluinon.wl%tiwai@suse.de> <20090421073219.GA5866@dose.home.local>
	<s5hfxg2cv6m.wl%tiwai@suse.de> <20090421183936.GA21935@dose.home.local>
	<s5hws9a5ewr.wl%tiwai@suse.de> <20090424142113.GA18668@dose.home.local>
	<s5hskjy5d2t.wl%tiwai@suse.de> <20090428002309.GA29572@x61>
	<20090506222753.GA6728@mac.home> <20090507072352.GA6513@mac.home>
	<s5hy6t92nuz.wl%tiwai@suse.de>
	<1241697280.19600.203.camel@nigel-laptop>
	<s5hr5z12jn5.wl%tiwai@suse.de>
	<1241728924.19600.208.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 4944A24826
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 22:56:04 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so735526rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 07 May 2009 13:56:03 -0700 (PDT)
In-Reply-To: <1241728924.19600.208.camel@nigel-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ncunningham-lkml@crca.org.au
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Tino Keitel <tino.keitel@gmx.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-05-08 at 06:42 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2009-05-07 at 14:16 +0200, Takashi Iwai wrote:
> > At Thu, 07 May 2009 21:54:40 +1000,
> > Nigel Cunningham wrote:
> > > 
> > > Hi.
> > > 
> > > On Thu, 2009-05-07 at 12:45 +0200, Takashi Iwai wrote:
> > > > The problem is that BIOS on your machine sets this pin both for
> > > > input and output.  Since it's set as input, the driver respects
> > > > the BIOS setup and skips to override.
> > > 
> > > 'scuse the ignorance, but this makes me ask: Are pins logically
> > > unrelated to jacks?
> > 
> > Yes, they are.
> > 
> > > I have a Dell M1530, and it has some jacks that can
> > > work as either inputs or outputs. Under M$, when I plug something in, a
> > > dialog box pops up asking me whether I connected a mic, line in or an
> > > output jack (I forget the details). Sounds like Tino's problem is what
> > > I'd expect from my BIOS. But I'm probably completely ignorant :)
> > 
> > The problem there is that the BIOS sets the current pin direction for
> > both input and output, but you can't play and record at the same time
> > on a jack.  It's not about the capability. 
> > 
> > BIOS is supposed to set all the pins properly ready for use, but it's
> > not so on Mac.
> 
> Thanks! :)
> 
> Nigel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

One thing that they did(which is nice)
is finally, if you mute or turn down the master
volume, once rebooting you don't have
that BONG or introduction noise.

Justin P. Mattock
