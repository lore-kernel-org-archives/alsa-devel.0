From: Thomas Charbonnel <thomas@undata.org>
Subject: [RFC] hdsp plans and alsa integration
Date: Mon, 09 Feb 2004 12:58:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402775CC.9070902@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (pD9E0E9C4.dip.t-dialin.net [217.224.233.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA03817
	for <alsa-devel@alsa-project.org>; Mon, 9 Feb 2004 13:58:59 +0100
Received: from localhost ([127.0.0.1] helo=undata.org)
	by satellite.undata.org with esmtp (Exim 4.21)
	id 1AqAze-0007Ot-Ii
	for alsa-devel@alsa-project.org; Mon, 09 Feb 2004 13:58:30 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I've been thinking for some time now about allowing several applications 
to access the hsdp matrix mixer in a cooperative way. Basically I want 
several applications to share the current state of the matrix mixer and 
be aware of the changes being made to it.
The problem at the moment is that hdspmixer does not directly reflects 
the hardware because it adds a software attenuation stage on the 
physical outputs (the third row of faders). Any change on this row is 
interpreted tracking back all the signals routed to the specified 
output, applying the proper attenuation and converting this to standard 
mixer calls. This renders the alsa ctl callback mechanism useless, 
because if another application accesses the mixer ctl, hdspmixer will 
have no way to interpret it properly.
I first thought of implementing the output attenuation stage directly in 
the driver but I now believe it would be a very bad idea to do this in 
kernel space (heavy computation, particularly with the new hdsp madi 
cards). So I came up with the idea of writing a userspace daemon that 
will access the card's mixer and be the keeper of this extended mixer 
representation. I would also write a library to handle communication 
with the daemon, and provide a callback mechanism to warn all the 
clients of changes made to the extended mixer. The daemon could be 
controled also from the network, which would make the whole system very 
flexible. You could have hdspmixer running on a machine without any hdsp 
hardware, controling the mixer of different hdsp cards on different 
other machines on the network. You could easily control the mixer from a 
pd patch, or a ladspa plugin, or ardour through an enhanced set of jack 
monitoring calls. A nice point would also be to have the daemon provide 
an optional ramping mechanism on mixer changes to avoid zipper noises 
and make it usable in live mixing situations.

Now my question is does that fit within the scope of alsa ? Mabe the lib 
could be integrated to alsa-lib and the daemon to alsa-tools ?
Any comment on this is welcome.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
