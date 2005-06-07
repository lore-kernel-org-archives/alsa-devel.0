From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC:  Appropriate device detection for Wine
Date: Tue, 07 Jun 2005 09:25:46 -0500
Message-ID: <42A5AE6A.2070204@codeweavers.com>
References: <42A519E9.2000103@codeweavers.com> <Pine.LNX.4.58.0506070930180.1752@pnote.perex-int.cz> <42A592BA.7050505@codeweavers.com> <Pine.LNX.4.58.0506071445070.1752@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0506071445070.1752@pnote.perex-int.cz>
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

> Yes, but you should use the new API (use dlopen/dlsym for
> snd_names_list/snd_names_list_free to let your code work with older 
> alsa-lib) and provide fallback when the symbols don't exist or the list 
> of devices is empty.

Fair enough; is it now the case that snd_names_list is considered
the canonical list of Alsa devices?  If found, there is no need
to check environment variables or anything else?

Cheers,

Jeremy


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
