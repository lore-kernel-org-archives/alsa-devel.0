From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: snd_pcm_poll_descriptors() error return
Date: Tue, 2 Oct 2018 21:28:26 +0100
Message-ID: <201810022128.26602.gineera@aspect135.co.uk>
References: <201810012223.09054.gineera@aspect135.co.uk>
 <c078e4c7-68a0-62d8-5df4-2d687efafbc8@sakamocchi.jp>
 <s5hwor0qryq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 1.smtp.34sp.com (1.smtp.34sp.com [46.183.9.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 816572676A7
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 22:27:19 +0200 (CEST)
Received: from smtpauth5.mailarray.34sp.com (lvs5.34sp.com [46.183.13.73])
 by 1.smtp.34sp.com (Postfix) with ESMTPS id C2358762455
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 21:27:00 +0100 (BST)
In-Reply-To: <s5hwor0qryq.wl-tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 October 2018 16:38, Takashi Iwai wrote:
> On Tue, 02 Oct 2018 01:32:10 +0200,
>
> Takashi Sakamoto wrote:
> > Hi,
> >
> > On Oct 02 2018 06:23, Alan Horstmann wrote:
> > > A user of the Portaudio library is reporting that from Alsa version
> > > 1.1.4 the function snd_pcm_poll_descriptors() can return -32 (Broken
> > > Pipe), and this fails an assert within Portaudio.  Earlier 1.1.3 does
> > > not seem to  show this issue.  For more details, see
> > > https://app.assembla.com/spaces/portaudio/support/tickets/268.
> > >
> > > The Alsa docs don't mention any possible negative error code from this
> > > function - has the behaviour changed, or is it likely something else is
> > > triggering the difference?
> >
> > Return values from a call of 'snd_pcm_poll_descriptors()' varies
> > depending on implementation of PCM plugins for used PCM node. Therefore
> > it's impossible to cover all of the values in documentation.
> >
> > In a design of alsa-lib, 'snd_pcm_poll_descriptors()' is a thin wrapper
> > of '.poll_descriptors' callback of internal/external structure of PCM
> > plugins, therefore its behaviour is dynamically different depending on
> > each implementation.
> >
> > For example, when using 'hw' PCM node directly, a call of this function
> > can returns '-ENOMEM' or '2':
> > http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_hw.c;h=5
> >9a242009e9f5f1098759305499eaa27bef6c1ab;hb=HEAD#l227
> >
> > When using 'dmix' PCM node, '-EIO', '0', '-EPIPE' and '1':
> > http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_direct.c
> >;h=2b07eff90ff6e12200e27a0d40378f29a7bf0d24;hb=HEAD#l668
> >
> > When using PCM node with external PCM plugins such as 'pulse',
> > 'snd_pcm_ioplug_create()' is called to instantiate plugin structure,
> > and a call of 'snd_pcm_poll_descriptors()' can return '-EIO', '0', '1',
> > and value depending on plugin implementation.
> > http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_ioplug.c
> >;h=881a1a85adaf09b4732375e2161b0a1ebb53900f;hb=HEAD#l772
> >
> > When having good discussion to investigate cause, discover solution for
> > this kind of issues, you need to identify which PCM node triggers the
> > issue, at least.
>
> Yes, this function may return an error code, and it's the defined
> behavior from the beginning.  So, please fix the error handling in the
> application side.

OK, thanks for that info - so we will have to check the function return more 
carefully than at present!  I appreciate the input from both of you on this.

Regards

Alan
