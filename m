From: Horms <horms@debian.org>
Subject: via82C686 MPU detection problem
Date: Tue, 1 Nov 2005 15:06:05 +0900
Message-ID: <20051101060604.GA19674@verge.net.au>
References: <E1EWDEG-0001Go-DX@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A147E172
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 07:08:53 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <E1EWDEG-0001Go-DX@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vincent =?iso-8859-1?Q?L=F6nngren?= <bice77@malmo2.net>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org, 319789@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Hi Vincent,

sorry for the inaction on this problem for so long. I breifly played
around with on my via box, but the sound chip is the older
VT8233/A/8235/8237, so I don't get anywhere. I'm forwarding it to the
alsa maintainers for consideration, I suspect its just a problem of
identifying your card.


Jaroslav,

Just to recap what is at http://bugs.debian.org/319789/, which isn't
much. It seems that snd_via82xx isn't handling the MPU of a VIA82C686
as expected. The problem seems to have been around since at least 2.6.8
and has been confirmed in 2.6.14.

Regards

-- 
Horms


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
