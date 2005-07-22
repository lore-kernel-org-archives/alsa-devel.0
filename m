From: Joern Seger <j.seger@gmx.de>
Subject: recording from ATI IXP150
Date: Fri, 22 Jul 2005 15:54:10 +0200
Message-ID: <200507221554.10806.j.seger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE [129.217.128.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7345F19F
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2005 15:56:44 +0200 (MEST)
Received: from [129.217.186.77] ([129.217.186.77])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.13.4/8.13.4) with ESMTP id j6MDtURr002135
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2005 15:55:35 +0200 (CEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

within my project, I recently decided to write an alsa driver.

I used some example code from the alsa pages (I request a descripor to rais=
e,=20
whenever x soundsamples are available and handle it in my select loop).=20
Everything works fine on almost all chipsets I have available.

However, the ATI IXP 150 seems to call the descriptor, even when there is n=
o=20
data available (this call will take place 20 times per ms!) so my app is=20
slowed down a bit :-/. Some samples are ok, but it's really not nice handli=
ng=20
hundreds of unneccessary calls.

Does anyone has had a similar problem? And: does anyone knows a workaround =
for=20
that problem?=20

BTW: My system is a Suse 9.3 (Kernel 2.6.4-11) alsa 1.0.9.

Thanks in advanced - J=F6rn



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
