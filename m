From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC:  Appropriate device detection for Wine
Date: Tue, 07 Jun 2005 07:27:38 -0500
Message-ID: <42A592BA.7050505@codeweavers.com>
References: <42A519E9.2000103@codeweavers.com> <Pine.LNX.4.58.0506070930180.1752@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0506070930180.1752@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net, Robert Reif <reif@earthlink.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 6 Jun 2005, Jeremy White wrote:
> 
> 
>>Thoughts?  Comments?  Tactfully worded puncturing of
>>my delusions <grin>?
> 
> 
> The right way is to use snd_names_list() and snd_names_list_free()
> functions (available from 1.0.9). Simply look for words like Playback
> Capture and Duplex in the comment member to determine the stream direction.

I don't think we can mandate 1.0.9 of Alsalib; that's more
modern than what most users have.

Further, given that I have yet to run into a system
with a properly set up alsa.conf, I find it highly
unlikely that people will have well configured asound.names
files any time soon.

Cheers,

Jeremy


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
