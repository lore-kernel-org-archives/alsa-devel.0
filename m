From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: [patch] patch_cm9880.c to support multi-channel
Date: Fri, 25 Mar 2005 01:53:06 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6C6@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EE2C22A1
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 20:09:42 +0100 (MET)
Content-Class: urn:content-classes:message
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


Summary: <fix multi-channel for model=3D=3Dfull>
Signed-off-by: ChenLi Tien<cltien@cmedia.com.tw>


Hi,

The patch_cm9880.c can't play side/C/B channels from front panel jacks. =
I fixed it by adding select pin.

I also added controls in the allout_init array. I wonder what this model =
for because it is the same as basic_init except the line-in is used as =
output in allout_init.

I plan to add controls for 5/6 stacks ,  which lacks front panel but has =
rear 5/6 jacks. Any idea?

Sincerely,
ChenLi Tien


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
