From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 00:55:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110260F.3090705@wildgooses.com>
References: <200408031732.i73HWTYg006521@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408031732.i73HWTYg006521@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>yes, the "hw" device requires 2 and only 2 periods. its a h/w design.
>  
>

Bugger.  Well, that's the issue then...

Mplayer assumes something like a small buffer size, and 8 
buffers/fragments.  When it meets the 9632 it obviously ends up with a 
smaller buffer, and hence latency, than the frequency it services the 
audio thread.

I have done some work on the audio output layer of mplayer to do a 
little bit of heuristics to increase the period size if it finds that 
the number of fragments are low.  Initial testing looks like this will 
do it.

However, quick question.  Is it possible to create a virtual device 
which will effectively change the default for period size if the app 
doesn't specifically ask for something different (some asound.conf 
magic?).  Also is it possible to influence the defaults for the OSS 
emulation...?

Thanks

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
