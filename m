From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: snd_ctl compiler warnings
Date: Fri, 7 Nov 2008 10:32:22 +0000
Message-ID: <200811071032.22917.gineera@aspect135.co.uk>
References: <200811070852.43936.gineera@aspect135.co.uk>
	<s5hprl7q2lv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-3.talktalk.net [62.24.128.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D9CC2415D
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 12:14:10 +0100 (CET)
In-Reply-To: <s5hprl7q2lv.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 07 November 2008 09:58, you wrote:
> At Fri, 7 Nov 2008 08:52:43 +0000,
> Alan Horstmann wrote:
> > The code I am working with at present includes unremarkable lines such
> > as:
> >
> > 		snd_ctl_elem_value_t *line_in_vol;
> > 		snd_ctl_elem_value_alloca(&line_in_vol);
> >
> > Building this with a cross compiler for arm based on gcc 4.2.1 gives this
> >
> > warning for the 2nd line:
> > : warning: the address of 'line_in_vol' will always evaluate as 'true'
> >
> > but an older compiler on the desktop does not show this.  Would this
> > warning be expected in these circumstances, or is the compiler being over
> > zealous? Am I missing something or is there a straightforward way to
> > avoid such warnings?  (Code runs OK).
>
> Try the later version of alsa-lib.
> This should have been already fixed.

Thanks very much.  You presumably refer to:

http://
git.alsa-project.org/?p=alsa-lib.git;a=commit;h=68e5771a6f7a2aae2dbd02a097719bcd25c6f307

Right now a rebuild of the working environment would be a bit tricky.  At the 
next opportunity I'll see if we can apply that patch to alsa-lib (I think it 
is 1.0.15 -based) and rebuild.  In the meantime the warnings are presumably 
fairly harmless?

Thanks again,

Alan
