From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: amixer issues
Date: Wed, 05 Apr 2006 10:34:02 +0200
Message-ID: <20060405083402.GA11178@turing.informatik.uni-halle.de>
References: <1143907666.9228.31.camel@localhost.localdomain>
 <20060404161719.GB18884@turing.informatik.uni-halle.de>
 <1144168240.26668.6.camel@mindpipe>
 <20060404165606.GC18884@turing.informatik.uni-halle.de>
 <4432C745.3090306@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 95B15221
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 10:34:47 +0200 (MEST)
In-reply-to: <4432C745.3090306@pianodisc.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> Is there any place that the Alsa minor numbers are documented?  

In the source.  ;-)

Both alsa-kernel/include/minors.h and alsa-driver/snddevices know about
the minor numbers.

When CONFIG_SND_DYNAMIC_MINORS is enabled, minor numbers are random.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
