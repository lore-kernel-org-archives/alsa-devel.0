From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [patch] Indigo DJx
Date: Fri, 9 Jan 2009 22:56:06 +0100
Message-ID: <20090109225606.a44e8c56.pochini@shiny.it>
References: <20081224091129.GA14883@x>
	<s5haba3uyus.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out114.alice.it (smtp-out114.alice.it [85.37.17.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 9809A1037F9
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 23:02:14 +0100 (CET)
In-Reply-To: <s5haba3uyus.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, carmen <_@whats-your.name>
List-Id: alsa-devel@alsa-project.org

On Wed, 07 Jan 2009 12:42:03 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 24 Dec 2008 04:11:29 -0500,
> carmen wrote:
> > 
> > the old Indigo DJ driver worked after a few tweaks...
> > 
> > tested w/ jack, cmus, mplayer
> > 
> > mapping/virtual-outs seem good..
> > 
> > 
> > this is a diff on alsa-kernel.git. copied the old firmware and
> > amazed it works, although something seems wonky with the samplerate
> > registers. going to email echo about an updated firmware .. no noise
> > bursts or ear destruction tho!
> 
> Thanks for the patch.
> 
> Giuliano, what do you think?  If you can give an ack, I'm willing to
> merge it for the next kernel release (2.6.30).

Argh! I completely overlooked that message.

I have no infos about those cards (yes, they are two: IOx and DJx). It is
possible that the hardware, connector apart, is the same as the old IO and
DJ cards. In that case the Carmen's patch is fine, because she just copied
indigoio.c and indigoio_dsp.c and she changed the name of the card. I guess
it's better to avoid that, making indigoio.c able to work with both cards.
Anyway, I'm going to write to the developer support @echoaudio. Before
merging a buggy driver I would try to fix that "something seems wonky with
the samplerate register" problem (whatever does it actually mean).


--
Giuliano.
