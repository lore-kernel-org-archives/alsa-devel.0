From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [ALSA - driver 0001494]: Intel HDA audio "scratchy" on Fujitsu S7020D unless position_fix=1 used
Date: Thu, 2 Mar 2006 09:52:21 +1030 (CST)
Message-ID: <200603012322.k21NMLL3020188@auster.physics.adelaide.edu.au>
References: <20060301150301.838F712D95@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060301150301.838F712D95@sc8-sf-spam2.sourceforge.net> from "alsa-devel-request@lists.sourceforge.net" at Mar 01, 2006 07:02:07 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Coming to the party a bit late here (I should have paid more attention
a few days ago when this last came up).

> Audio on a Fujitsu Lifebook S7020D (snd-hda-intel with a Realtek ALC260) is
> distorted and choppy unless position_fix=1 is used as a module parameter. 
> :
> ----------------------------------------------------------------------
>  Paul Walmsley - 03-01-06 10:48 
> ----------------------------------------------------------------------
> Just tested 1.0.11rc3; it works fine without an explicit position_fix
> parameter on this hardware.

I must admit that I haven't tried without this parameter for quite some
time - it's in my /etc/modules.conf and I keep forgetting about it.  I'll
explicitly test it on my hardware tonight to be sure, but if Paul reports
the issue resolved I'm happy with that for the moment.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
