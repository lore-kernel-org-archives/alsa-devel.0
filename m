From: "Larry D. Pyeatt" <pyeatt@cs.ttu.edu>
Subject: alsa-lib not installing plugins
Date: Sat, 20 Oct 2007 11:06:28 -0500
Message-ID: <471A2784.6000205@cs.ttu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from redwood.cs.ttu.edu (redwood.cs.ttu.edu [129.118.162.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 16A382437F
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Oct 2007 18:03:19 +0200 (CEST)
Received: from [129.118.248.102] (unknown [129.118.248.102])
	by redwood.cs.ttu.edu (Postfix) with ESMTP id 873228738
	for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2007 11:03:17 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,
  I wrote a new plugin for alsa-lib.  After running make, there
are .o and .lo files in src/pcm.  However, when I run make
install, nothing gets put into /usr/lib/alsa-lib.

  I first tried installing alsa-lib-1.0.15rc3. Then I tried
alsa-lib-1.0.13rc3 and alsa-lib-1.0.14rc4.  All of them did the
same thing.  Am I missing something obvious?

  Since they are all doing the same thing, it must be either
that I just don't know what I'm doing, or something else
in my system is not working.  I would appreciate any suggestions
on what could cause this behavior.

Thanks,


-- 
Larry D. Pyeatt, PhD.
pyeatt@cs.ttu.edu
http://www.cs.ttu.edu/~pyeatt
