From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Intel HDA and Realtek ALC 260
Date: Mon, 6 Feb 2006 12:59:17 +1030 (CST)
Message-ID: <200602060229.k162THBb025229@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rq@akl.lt
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Rimas

> I'm one of the people affected by
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618. ... So I have
> a question for the maintainer of that module (I guess that's jwoithe)

Not to my knowledge - I've just provided the Fujitsu model and some other
more general patches to patch-realtek.c because I have a laptop with the
ALC260 in it and want it to work. :) Takashi would be the official
maintainer of this file AFAIK.

> would it be possible to add a "test" model, like in case of ALC880, which
> would have controls for all of the chipset pins available? I guess that
> would simplify things a lot...

I think that's possibly worth considering.  I'll have a look into this
tonight and see how much extra code it would add.  Since most of the
infrastructure is already present I suspect it won't be too bad.  Such a
feature would allow people to test new computers without having to patch
anything and as such would probably be quite useful, as you suggest.

Regards
  jonathan
y


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
