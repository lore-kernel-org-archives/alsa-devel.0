From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: If /dev/snd/controlCx EACCES vs. ENODEV mixup
Date: Mon, 26 Nov 2007 09:24:22 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711260922330.7571@tm8103.perex-int.cz>
References: <20071125210359.GB17108@tango.0pointer.de>
	<Pine.LNX.4.61.0711252240140.7688@tm8103.perex-int.cz>
	<20071125215300.GA22640@tango.0pointer.de>
	<s5hir3ppkeb.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0711260843120.7571@tm8103.perex-int.cz>
	<s5h7ik5phd7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A584924782
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 09:24:22 +0100 (CET)
In-Reply-To: <s5h7ik5phd7.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Nov 2007, Takashi Iwai wrote:

> At Mon, 26 Nov 2007 08:47:12 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > > BTW, regarding bugzilla vs mantis.  There are a few features that are
> > > missing in mantis.  For example, the below are what I'd love to have
> > > vastly:
> > > 
> > > - properly create a mail per entry
> > >   currently mantis mail notification is broken and useless
> > 
> > Seems that mantis developers are aware of this now:
> > 
> > http://www.mantisbt.org/wiki/doku.php/mantisbt:diff_emails_requirements
> 
> Well, it's not only about the diff mail.  In many cases, the mail is
> just empty but only with headers.  Maybe it became too long and cut
> out...  Anyway, if this gets fixed, it'd be a great step forward.
> Really.

You may limit max. count of notes and setup e-mail details in mantis 
preferences. But I do not exclude that it's an error in the mantis e-mail 
notification system. I'll try update mantisbt to 1.0.8 and immediately to 
1.1.0 (when available) then.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
