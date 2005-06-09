From: "Tehn-Yit Chin" <Tehn-Yit.Chin@greyinnovation.com>
Subject: about the alsa i2c interface
Date: Thu, 9 Jun 2005 13:09:47 +1000
Message-ID: <9AEDBAA573BBD346BCF9637D80097D9119E60A@greysvr02.GreyInnovation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9140E1FB
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 05:12:22 +0200 (MEST)
Received: from greyinnovation.com (246.063.dsl.mel.iprimus.net.au [211.27.107.246])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 34E3777289
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 05:12:21 +0200 (MEST)
Content-class: urn:content-classes:message
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

Hi,

We are trying to provide support for the CS43L43 device under the ALSA
architecture on an embedded platform.

During my early investigation, I noticed that ALSA has its own i2c code.
What is this required, and why doesn't it use the mainline i2c support?
On our platform, there are one other devices on the i2c bus, so I would
like to use the mainline i2c code.

Any pointers would be appreciated.

Tehn Yit Chin
Software Engineer, Grey Innovation Pty. Ltd.


-------------------------------------------------------------
Tehn Yit Chin     Software Engineer
-------------------------------------------------------------
Grey Innovation Pty. Ltd.           Dir +613 9692 6909
42 Charles Street                   Ph  +613 9692 6999
Prahran                             Fx  +613 9692 6998
Victoria 3181                       Mail: PO Box 452
Australia                           Prahran 3181

mailto:tehn-yit.chin@greyinnovation.com
http://www.greyinnovation.com
-------------------------------------------------------------
This e-mail and any attachments to it is confidential and is=20
for the use only of the intended recipient. It may contain=20
copyright material of Grey Innovation Pty Ltd or any of its=20
related entities or of third parties. If you are not the=20
intended recipient, please notify the sender immediately by
return e-mail, delete the email and any attachments, and do
not read, copy, print, retransmit store or act in reliance
on the contents. Any views expressed are those of the
individual sender only, unless expressly stated to be those=20
of Grey Innovation Pty Ltd. Grey Innovation Pty Ltd does not=20
guarantee the integrity of the contents, or that it is free=20
from errors, viruses or interference.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
