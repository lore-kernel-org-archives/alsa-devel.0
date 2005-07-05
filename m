From: Manuel Jander <manuel.jander@gmail.com>
Subject: Unresolved symbol
Date: Tue, 5 Jul 2005 14:04:55 +0200
Message-ID: <21ed1c3705070505042d503a58@mail.gmail.com>
Reply-To: Manuel Jander <manuel.jander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DC731A7
	for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2005 14:04:56 +0200 (MEST)
Received: by rproxy.gmail.com with SMTP id z35so837584rne
        for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2005 05:04:55 -0700 (PDT)
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

Building a pure USB alsa-driver set, I encountered the following
situation (ARM target):

The function snd_compat_strlcpy() does sometimes not get build when
only USB devices (no memory_wrapper.o being build). I guess this
function should go elsewhere.

The result: unresolved symbols: snd_compat_strlcpy()


Best Regards,
--=20
Manuel Jander


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
