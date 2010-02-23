From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.31.x vs. rme vs. alsa 1.0.22?
Date: Tue, 23 Feb 2010 00:20:49 +0000
Message-ID: <1266884449.3704.214.camel@localhost.localdomain>
References: <1266371882.3361.40.camel@localhost.localdomain>
	<1266882689.3704.178.camel@localhost.localdomain>
	<1266884215.3704.208.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.stanford.edu (smtp1.Stanford.EDU [171.67.219.81])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E182103876
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 01:21:38 +0100 (CET)
In-Reply-To: <1266884215.3704.208.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev@lists.linuxaudio.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-02-23 at 00:16 +0000, Fernando Lopez-Lezcano wrote:
> On Mon, 2010-02-22 at 23:51 +0000, Fernando Lopez-Lezcano wrote:
> > On Tue, 2010-02-16 at 17:58 -0800, Fernando Lopez-Lezcano wrote:
> > > Hey, has anyone been seeing strange behavior from this combination?
> > > 
> > >   kernel 2.6.31.x rt20 + alsa 1.0.22 userland
> > >   RME card (pcmcia card + multiface)
> > > 
> > > hdspmixer is not doing the right thing (does not initialize the card in
> > > a way in which playback works), it does not see the hwdep interface (or
> > > something like that) and disables metering,
> [MUNCH]
> > I have been trying to see if I can figure _anything_ out of this...
> > 
> > A diff of 2.6.29 (last known working) against 2.6.31.12 reveals
> > something that might have an influence on the problem:
> > 
> > in snd_hdsp_create_hwdep there are two lines added:
> > 
> > + hw->ops.open = snd_hdsp_hwdep_dummy_op;
> 
> Hmmm, looks like snd_hdsp_hwdep_dummy_op is not passing back the
> hdsp->hwdep structure to the open call at all (returning 0 is not enough
> from the description of the alsa api). That would explain what is
> happening, most probably no ioctls are found...
> 
> Am I on the right track?

Argh. I was looking at the diff backwards (DOH!). The ops.open and
ops.release ioctl calls are _missing_ in the 2.6.31.12 tree. 

-- Fernando


> >   hw->ops.ioctl = snd_hdsp_hwdep_ioctl;
> > + hw->ops.release = snd_hdsp_hwdep_dummy_op;
> > 
> > And snd_hdsp_hwdep_dummy_op just returns 0...
> > 
> > Other differences between the two files (not that many) seem irrelevant
> > to me. 
> > 
> > I imagine this is what is causing the difference in behavior (hwdep
> > fails). Any suggestions on what I could try to fix this?
> > 
> > Thanks for any help!
