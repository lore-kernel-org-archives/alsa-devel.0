From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: current CVS: compile error
Date: Sun, 9 Jan 2005 18:04:08 +0100
Message-ID: <20050109180408.688a5a3d.pochini@shiny.it>
References: <XFMail.20050107101953.pochini@shiny.it>
	<1105148369.7230.21.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vsmtp14.tin.it (vsmtp14.tin.it [212.216.176.118])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 10973256
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2005 19:47:35 +0100 (MET)
In-Reply-To: <1105148369.7230.21.camel@cmn37.stanford.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07 Jan 2005 17:39:33 -0800
Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > > I'm getting this error while building current CVS (one FC3):
> > >
> > > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:
> > > In function `load_firmware':
> > > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio.h:424:
> > > sorry, unimplemented: inlining failed in call to 'free_firmware':
> > > function body not available
> > > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:544: sorry, unimplemented: called from here
> >
> > I'll check this ASAP. What gcc are you using ?
>
> Standard gcc in fc3, gcc3.4 I believe (I don't have access to that
> machine right now).

Some versions of GCC do not like inline functions to be defined after the
point they are used. Gcc 2.95 and gcc 3.4.1 compile it without errors, so
you probably have 3.3.x. Btw, the patch posted by tiwai should fix it.


--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
