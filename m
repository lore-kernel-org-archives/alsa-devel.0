From: Paul Davis <pbd@op.net>
Subject: format specification problem
Date: Wed, 24 Apr 2002 20:55:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204250055.g3P0tu908360@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA27127
	for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2002 02:52:38 +0200
Received: from op.net (maxtnt06-128.phlpa.fast.net [209.92.102.128])
	by post2.fast.net (8.11.2/8.9.3) with ESMTP id g3P0qOP07539
	for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2002 20:52:24 -0400 (EDT)
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


 [ those of you on jack-dev will have seen this coming ]

ALSA doesn't seem to provide a way for a driver to way "i provide
samples in the native format of the processor". The specific case in
point that I'm noticing is the Hammerfall, where we currently say that
it supports S32_LE. This is not strictly true. It supports S32_LE when
it has the x86-friendly EPROM, and S32_BE when it has the ppc-friendly
EPROM. But it can't support them both at the same time. Moreover,
there isn't any way to find out which EPROM it has - its assumed that
the user is sufficiently smart not to have installed a PPC version on
an x86 system (I actually had a user recently who had this problem and
didn't realize it - they spent days trying to figure why their samples
were byte-swapped).

If an application wants to ask for S32 in "native" format, it can do
that, but <alsa/asoundlib.h> will convert that into either S32_LE or
S32_BE, and when we get down the driver level, it will fail on some
systems. 

How can we address this? I doubt that the Hammerfall is the only card
with this problem ...

--p
