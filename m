From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Fw: [Bug 76413] arts does not follow ALSA API
Date: Fri, 19 Mar 2004 20:30:13 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405B5855.3020604@superbug.demon.co.uk>
References: <20040319162344.2cd6363f.mista.tapas@gmx.net> <405B27B5.8070509@superbug.demon.co.uk> <Pine.LNX.4.58.0403192003010.2006@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403192003010.2006@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Florian Schmidt <mista.tapas@gmx.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 19 Mar 2004, James Courtier-Dutton wrote:
> 
> 
>>>------- You are receiving this mail because: -------
>>>You are a voter for the bug, or are watching someone who is.
>>>      
>>>http://bugs.kde.org/show_bug.cgi?id=76413      
>>>
>>>CCMAIL: 76413 bugs kde org
>>>CCMAIL: 70802 bugs kde org
>>>
>>>
>>>  M +110 -48   audioioalsa9.cc   1.6
>>>
>>
>>If there is a bug in alsa, we will fix it.
>>Can you post a small program to demonstrate the problem.
> 
> 
> It's not a bug, but this guy definitely wants to simplify his work.
> He uses file descriptors directly without 
> snd_pcm_poll_descriptors_revents(). The dmix plugin (and dshare)
> are first plugins which don't return POLLOUT for playback but POLLIN
> (because timer events are used as the event source).
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 

I read the thread:
 >>>http://bugs.kde.org/show_bug.cgi?id=76413

The guys there just don't understand what you told them. If they took 
the time to actually read what you said, they could easily fix their 
problem.

Summary: -
No bug in alsa.

Cheers
James




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
