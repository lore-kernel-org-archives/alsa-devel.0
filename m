From: Paul Davis <pbd@op.net>
Subject: hammerfall dsp controls (again)
Date: Fri, 8 Mar 2002 08:39:05 -0500
Message-ID: <200203081339.g28Dd5x16550@op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA25505
	for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2002 14:41:49 +0100
Received: from op.net (maxtnt04-117.phlpa.fast.net [209.92.96.117]) by renoir.op.net (o1/$Revision: 1.18 $) with ESMTP id IAA23995 for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2002 08:41:44 -0500 (EST)
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

well, since nobody responded to a 100% open question on how to support
the 1500 or so mixer controls that exist on the H-DSP, i'll offer up
an explicit solution and see if anyone can comment on that.

since no generic ALSA program is going to be able to usefully present
all those mixer controls, and since they all represent variations on a
theme, i propose to offer a single control that includes:

       data source
       data destination
       gain

it will be up to applications to get/set whatever combinations of
these they are interested in. there will be no single control that can
be read to get, say, the gain for a specific data destination, since
no such value can really be said to exist in the H-DSP - gain values
always apply to a combination of a source and a destination.

any comments on this?

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
