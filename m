From: Paul Davis <pbd@op.net>
Subject: Re: [linux-audio-dev] dynamic linking
Date: Tue, 23 Apr 2002 14:26:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204231823.UAA19407@alsa.alsa-project.org>
References: <001501c1eaf8$d359ef00$0400a8c0@martijn>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA19407
	for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2002 20:23:32 +0200
In-Reply-To: Your message of "Tue, 23 Apr 2002 19:58:08 BST."
             <001501c1eaf8$d359ef00$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I'm working on a library for accessing MIDI hardware, which uses plugins
>to communicate with the hardware. Now I'm not sure how to compile
>these shared libraries. Should I use -Bsymbolic? This makes the linker
>give a warning when the library is not linked against all the shared
>libraries

although i hate it in so many ways, i would strongly suggest that you
use libtool. there are complexities associated with building shared
libs that its better to leave to other tools.

--p
