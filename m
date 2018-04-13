From: Mark Hills <mark@xwax.org>
Subject: Re: Avoiding wordexp prevents environment variables
	being used
Date: Fri, 13 Apr 2018 12:58:56 +0100 (BST)
Message-ID: <1804131247290.26341@stax.localdomain>
References: <1804081611300.19491@stax.localdomain>
 <s5h6050irw7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 by alsa0.perex.cz (Postfix) with ESMTP id E886A267079
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:59:01 +0200 (CEST)
In-Reply-To: <s5h6050irw7.wl-tiwai@suse.de>
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
Cc: Natanael Copa <ncopa@alpinelinux.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Apr 2018, Takashi Iwai wrote:

> On Sun, 08 Apr 2018 18:13:43 +0200,
> Mark Hills wrote:
> > 
> > I just came up against the patch below; it prevents useful snippets of 
> > alsa-conf like this:
> > 
> >   @hooks [
> >       {
> >           func load
> >           files [
> >               "~/.asoundrc-$HOSTNAME"
> >           ]
> >           errors false
> >        }
> >   ]
> > 
> > as the evalutation of all but "~" has been removed.
> > 
> > Seems like removal of a perfectly good feature in the name of security; 
> > because wordexp()
> > 
> > 1) is not used (and should not be used) on data originating from an 
> >    untrusted source
> > 
> > 2) is already used with WRDE_NOCMD, which the same POSIX spec documents 
> >    as:
> > 
> >     "The WRDE_NOCMD flag is provided for applications that, for security 
> >      or other reasons, want to prevent a user from executing shell 
> >      commands."
> > 
> > 3) on glibc can be seen (with strace) not to execute other commands 
> > 
> > If one is to treat the POSIX doc as gospel (as cited by the patch) the 
> > cause of firefox (circa July 2017) not working would actually be that musl 
> > does not honour WRDE_NOCMD to the letter. I agree the spec of wordexp() 
> > could be more useful, though.
> > 
> > Also, hypothesising the attacks of an already-compromised application 
> > would get into a sticky conversation about the thread safety of 
> > getenv("HOME") (and associated buffer wrangling)  vs. a library function 
> > being used for its intended purpose.
> > 
> > In practice, Firefox may have moved on here (no ALSA support anymore) so 
> > should quirks of its sandbox be driving this?
> 
> What's wrong with you building the alsa-lib with --with-wordexp if you
> prefer having that behavior?

Practically, I must build custom packages for all machines (some I do not 
control, eg. my employer's)

My case here is both that the default behaviour should not have changed; 
and that the security rationale offered here is misleading.

-- 
Mark
