From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: RE: current CVS: compile error
Date: 07 Jan 2005 17:39:33 -0800
Message-ID: <1105148369.7230.21.camel@cmn37.stanford.edu>
References: <XFMail.20050107101953.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.Stanford.EDU (smtp3.Stanford.EDU [171.67.16.138])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C07E4243
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2005 02:39:39 +0100 (MET)
In-Reply-To: <XFMail.20050107101953.pochini@shiny.it>
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

On Fri, 2005-01-07 at 01:19, Giuliano Pochini wrote:
> On 07-Jan-2005 Fernando Lopez-Lezcano wrote:
> > I'm getting this error while building current CVS (one FC3):
> >
> > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:
> > In function `load_firmware':
> > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio.h:424:
> > sorry, unimplemented: inlining failed in call to 'free_firmware':
> > function body not available
> > /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:544: sorry, unimplemented: called from here
> 
> I'll check this ASAP. What gcc are you using ?

Standard gcc in fc3, gcc3.4 I believe (I don't have access to that
machine right now). 

-- Fernando




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
