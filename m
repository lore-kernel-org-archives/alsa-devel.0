From: Ed Wildgoose <lists@wildgooses.com>
Subject: RME9632 Precise Pointer option problem (attn Thomas Charbonnel)
Date: Mon, 27 Sep 2004 10:20:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4157DB53.2030801@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi folks,

I haven't been able to get in touch with Thomas with this question, but 
perhaps someone here can help (or perhaps he will see it?)

With this driver the free space call returns only an approximate value, 
however, the "precise pointer" module option returns apparently garbage 
(and there are notes in the source to say this).  Looking at the code 
it's just returning the value from a register, so it's hard to see that 
the driver is doing anything bad.

Does anyone have any insight on whether it's possible to get a good 
value for free space in the buffers?  From a design point of view is it 
sensible to add some kind of fixup which counts ticks to estimate free 
space in the buffers at the driver level, or should stuff like that 
exist only at userspace level, probably in the app?  I realise that we 
can't do this perfectly, but it occurs to me that we can probably remain 
quite accurate estimating the current point location based on counting 
ticks since we started and noting when we add new data, etc.

Any thoughts?

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
