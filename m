From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: current CVS: compile error
Date: Fri, 07 Jan 2005 10:19:53 +0100 (CET)
Message-ID: <XFMail.20050107101953.pochini@shiny.it>
References: <1105064170.26216.102.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 173DC22E
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 10:19:57 +0100 (MET)
In-Reply-To: <1105064170.26216.102.camel@cmn37.stanford.edu>
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


On 07-Jan-2005 Fernando Lopez-Lezcano wrote:
> I'm getting this error while building current CVS (one FC3):
>
> /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:
> In function `load_firmware':
> /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio.h:424:
> sorry, unimplemented: inlining failed in call to 'free_firmware':
> function body not available
> /usr/src/rpm/BUILD/alsa-driver-1.0.8rc2/pci/echoaudio/echoaudio_dsp.c:5=
44: sorry, unimplemented: called from here


I'll check this ASAP. What gcc are you using ?



--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
