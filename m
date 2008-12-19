From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Patch to /sound/soc/pxa/pxa2xx_pcm.c,
	WHO IS INTERESTED?
Date: Fri, 19 Dec 2008 12:32:13 +0000
Message-ID: <20081219123212.GK24129@sirena.org.uk>
References: <494A97CD.7070909@gmail.com> <20081219115737.GI24129@sirena.org.uk>
	<s5hljucwevk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A49CF243C8
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 13:32:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hljucwevk.wl%tiwai@suse.de>
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
Cc: nicolas pitre <nico@cam.org>, ALSA project mailing list <alsa-devel@alsa-project.org>, sware <microcontrolfreak@gmail.com>, liam girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 19, 2008 at 01:03:59PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > >  	kfree(prtd);
> > > +	runtime->private_data = NULL;
> > > +

> This looks superfluous.  The runtime instance will be anyway freed
> soon after the close callback.

Even if it wasn't the driver will overwrite it on open().  OTOH it
doesn't do any harm either.
