From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_ prefix for module options
Date: Sat, 12 Oct 2002 10:56:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210121055200.1975-100000@pnote.perex-int.cz>
References: <87ptugepnn.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87ptugepnn.fsf@sulphur.joq.us>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: Takashi Iwai <tiwai@suse.de>, Peter L Jones <peter@drealm.org.uk>, Karsten Wiese <annabellesgarden@yahoo.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 11 Oct 2002, Jack O'Quin wrote:

> 
> > Jack O'Quin wrote:
> > > Can someone please explain what terrible problem we're trying to solve
> > > that justifies introducing *any* breakage at all?
> >  
> > > ALSA is part of the 2.5 kernel now.  It is mainstream Linux software,
> > > good technology, needed by many users.  Isn't it about time to start
> > > thinking and acting that way?
> 
> Takashi Iwai <tiwai@suse.de> writes:
> 
> > this is the very reason why "now" i asked.
> > since the ALSA is now on the official kernel tree, we must follow to
> > the standard rules, too.  and the snd_ prefix is obviously ugly from
> > this perspective.
> > 
> > if we live alone as external, then we don't have to care - we could do
> > as we like.  but the mainstream means that such exception has to be
> > excluded, too, at least before 2.5 turns into the "real mainstream",
> > i.e. 2.6 (or 3.0).
> 
> Are you saying that the "snd_" prefix violates standard Linux kernel
> rules for device driver options?  Did the kernel developers request
> this change?

Well, they had objections but not major to disallow inclusion of ALSA to 2.5.
I think that it would be good to follow standard kernel rules in this 
case.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
