From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: current CVS: compile error
Date: 09 Jan 2005 12:25:32 -0800
Message-ID: <1105302330.13237.27.camel@cmn37.stanford.edu>
References: <XFMail.20050107101953.pochini@shiny.it>
	 <1105148369.7230.21.camel@cmn37.stanford.edu>
	 <20050109180408.688a5a3d.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.Stanford.EDU (smtp1.Stanford.EDU [171.67.16.123])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1D6425F
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2005 21:25:38 +0100 (MET)
In-Reply-To: <20050109180408.688a5a3d.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-01-09 at 09:04, Giuliano Pochini wrote:
> On 07 Jan 2005 17:39:33 -0800
> Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > > > I'm getting this error while building current CVS (one FC3):
> > > >
> > > > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:
> > > > In function `load_firmware':
> > > > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio.h:424:
> > > > sorry, unimplemented: inlining failed in call to 'free_firmware':
> > > > function body not available
> > > > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:544: sorry, unimplemented: called from here
> > >
> > > I'll check this ASAP. What gcc are you using ?
> >
> > Standard gcc in fc3, gcc3.4 I believe (I don't have access to that
> > machine right now).
> 
> Some versions of GCC do not like inline functions to be defined after the
> point they are used. Gcc 2.95 and gcc 3.4.1 compile it without errors, so
> you probably have 3.3.x. Btw, the patch posted by tiwai should fix it.

Thanks, I have not had time to try it out yet (will soon, I hope). It
fails on gcc 3.4.2. 

-- Fernando




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
