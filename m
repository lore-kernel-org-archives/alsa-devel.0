From: "Jack O'Quin" <joq@io.com>
Subject: Re: snd_ prefix for module options
Date: 11 Oct 2002 14:33:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87ptugepnn.fsf@sulphur.joq.us>
References: <s5hfzvh2fid.wl@alsa2.suse.de>
	<DAELIEGDPLDDCIJPAICBEENLCDAA.annabellesgarden@yahoo.de>
	<s5hwuor29tv.wl@alsa2.suse.de>
	<200210091937.05652@advent.drealm.org.uk>
	<87u1juxoit.fsf@sulphur.joq.us> <s5hd6qhcb98.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6qhcb98.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter L Jones <peter@drealm.org.uk>, Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> Jack O'Quin wrote:
> > Can someone please explain what terrible problem we're trying to solve
> > that justifies introducing *any* breakage at all?
>  
> > ALSA is part of the 2.5 kernel now.  It is mainstream Linux software,
> > good technology, needed by many users.  Isn't it about time to start
> > thinking and acting that way?

Takashi Iwai <tiwai@suse.de> writes:

> this is the very reason why "now" i asked.
> since the ALSA is now on the official kernel tree, we must follow to
> the standard rules, too.  and the snd_ prefix is obviously ugly from
> this perspective.
> 
> if we live alone as external, then we don't have to care - we could do
> as we like.  but the mainstream means that such exception has to be
> excluded, too, at least before 2.5 turns into the "real mainstream",
> i.e. 2.6 (or 3.0).

Are you saying that the "snd_" prefix violates standard Linux kernel
rules for device driver options?  Did the kernel developers request
this change?

If so, I withdraw my objection.  

I thought the change was merely cosmetic.  :-)

Regards,
-- 
  Jack O'Quin
  Austin, Texas, USA



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
