From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC:  Appropriate device detection for Wine
Date: Tue, 7 Jun 2005 14:48:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0506071445070.1752@pnote.perex-int.cz>
References: <42A519E9.2000103@codeweavers.com> <Pine.LNX.4.58.0506070930180.1752@pnote.perex-int.cz>
 <42A592BA.7050505@codeweavers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A592BA.7050505@codeweavers.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy White <jwhite@codeweavers.com>
Cc: alsa-devel@lists.sourceforge.net, Robert Reif <reif@earthlink.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Jun 2005, Jeremy White wrote:

> Jaroslav Kysela wrote:
> > On Mon, 6 Jun 2005, Jeremy White wrote:
> > 
> > 
> >>Thoughts?  Comments?  Tactfully worded puncturing of
> >>my delusions <grin>?
> > 
> > 
> > The right way is to use snd_names_list() and snd_names_list_free()
> > functions (available from 1.0.9). Simply look for words like Playback
> > Capture and Duplex in the comment member to determine the stream direction.
> 
> I don't think we can mandate 1.0.9 of Alsalib; that's more
> modern than what most users have.
> 
> Further, given that I have yet to run into a system
> with a properly set up alsa.conf, I find it highly
> unlikely that people will have well configured asound.names
> files any time soon.

Yes, but you should use the new API (use dlopen/dlsym for
snd_names_list/snd_names_list_free to let your code work with older 
alsa-lib) and provide fallback when the symbols don't exist or the list 
of devices is empty.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
