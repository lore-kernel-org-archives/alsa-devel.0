From: Josh Green <jgreen@users.sourceforge.net>
Subject: [Fwd: mixer problem with ymfpci]
Date: 28 Apr 2002 10:24:03 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1020014651.1588.6.camel@flippin.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-y1XSW4njP2y4FUAvYY2M"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from C9Mailgw02.amadis.com (c9mailgw.ctmail.com [216.163.188.201] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA01538
	for <alsa-devel@alsa-project.org>; Sun, 28 Apr 2002 19:26:39 +0200
Received: from c9service12.amadis.com (10.9.0.1)  
        id 3CBB75AC00189881 for alsa-devel@alsa-project.org; Sun, 28 Apr 2002 10:23:10 -0700
Received: from flippin.localdomain (148.63.217.107) by c9service12.amadis.com (NPlex 6.5.012)
        id 3CB463BA00015FD4 for alsa-devel@alsa-project.org; Sun, 28 Apr 2002 10:23:10 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-y1XSW4njP2y4FUAvYY2M
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I sent this email before without realizing I wasn't a member of the list
(I am now), it appears to be stuck in the moderation loop :) So I'm
sending it again, please excuse a double posting, thanks.
	Josh Green

--=-y1XSW4njP2y4FUAvYY2M
Content-Disposition: inline
Content-Description: Forwarded message - mixer problem with ymfpci
Content-Type: message/rfc822

Subject: mixer problem with ymfpci
From: Josh Green <jgreen@users.sourceforge.net>
To: alsa-devel@alsa-project.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 25 Apr 2002 12:10:14 -0700
Message-Id: <1019761829.1660.54.camel@flippin.localdomain>
Mime-Version: 1.0

I'm currently have a problem setting mixer controls with alsactl and the
ymfpci driver (Yamaha YMF-744B on a laptop). This problem started with
alsa 0.9.0beta12 and is present in rc1 as well. I've removed the
/etc/asound.state file and did a `alsactl store' which has no problems.
`alsactl restore' on the other hand gives me the following message:

alsactl: set_control:876: Cannot write control '0,0,0,,0': Invalid
argument

Although it does restore all the control settings, it fails to restore
my mixer settings on boot. /etc/rc.d/init.d/alsa is part of initscripts
on Mandrake 8.1. I haven't quite figured out why it doesn't but that
also started with beta12 so I suspect its the same problem. Cheers!
	Josh Green

P.S. Nice job on the web site. The documentation section is more
complete now. I notice that the "Documentation" and "API" page both
contain the same content. Seems like it might make sense just to merge
all of it into one page. Then have a heading for User Documentation and
Developer Documentation or something.

--=-y1XSW4njP2y4FUAvYY2M--
