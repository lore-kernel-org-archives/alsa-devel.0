From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 09:01:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408041301.i74D1omu022274@localhost.localdomain>
References: <4110D9FF.0@wildgooses.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 04 Aug 2004 13:43:43 BST."
             <4110D9FF.0@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm not sure what you are saying here.  I have the source code in front 
>of me in an editor, but I physically can't set the options correctly - 
>the driver just rejects them?

you've got things the wrong way around - you get to *ask* for a
specific h/w setup, the driver gets to accept or reject them. 

>The issue is the heuristic - I appear to have to try for the period size 
>first, then set the number of periods (fails if I do it the other way 
>around), 

yes, it is heuristic. this is a problem caused mostly by the 
range of designs in contemporary audio interfaces. ALSA could hide
this from you by adding buffering in the way Takashi described, but
that would add latency and/or complications. 

>         however, if I then discover the number of periods * period size 
>is lower than I would like, I cant go and adjust these settings (alsa 
>returns errors).

it is possible to start over with a new h/w parameter setup, but you
will have to reinitiatize the settings structure and start from the top.
otherwise, you're still working with the rest of the values that
you've already set.

>Latest mplayer has jack support via the bio2jack library.

Yeah, but bio2jack is a (working) hack and half. And it doesn't
support lowlatency work properly either, because the thread that
*really* does audio isn't scheduled as part of the JACK graph and
doesn't get SCHED_FIFO status. I see this in xmms all the time when I
do a multiway compile - JACK has no (or almost no) xruns, but the
audio in xmms skips because the "feeder" thread doesn't get scheduled
in time to fill the intermediate buffer.

>#define CONFIG_SND_VERSION "1.0.5"

hmm, should be fine. I am not sure what would be causing that
error. In what order are you trying to set the h/w parameters?

--p


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
