From: Svante Signell <srs@kth.se>
Subject: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Tue, 29 Mar 2011 12:24:40 +0200
Message-ID: <1301394280.3906.29.camel@s1499.it.kth.se>
Reply-To: srs@kth.se
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-2.sys.kth.se (smtp-2.sys.kth.se [130.237.32.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 324091038EB
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 12:24:43 +0200 (CEST)
Received: from mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91])
	by smtp-2.sys.kth.se (Postfix) with ESMTP id ED9ED14D7E0
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 12:24:42 +0200 (CEST)
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

Now I'm subscribed to the list. It does not seem possible to get a
message in without subscription. Would be nice if alsa had and used bug
reporting pages outside the mailing list.

> Trying again to get this message to the alsa-devel list, as recommended
> by the Debian maintainer of the kernel, without being subscribed. Does
> alsa not have a bug report page?
> 
> Booting kernel 2.6.38  hangs at:
> During boot of kernel 2.6.38 (and 2.6.37) udev bugs out:
> Waiting for /dev to be fully populated
> BUG: Unable to handle kernel paging request at ffffc90013cd8000
> axz_probe+ ... [snd_hda_intel]
> ...lots of output lost...
> udevadm timeout 180 sec ...
> udevd[390]: worker [439] failed while handling
> '/devices/pci0000:80/0000:80:01.0'
> 
> No sound card is recognized after the timeout of the boot as shown above.
> According to the /proc/asound/cards there are no sound cards
> 
> See bug Debian bug #619034 for more information.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=619034
> 
> This problem was also reported as Debian bug #613979, as kernel ticket
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=30552
> 
> and sent to this mailing list in February 2011.
> 
> snd_hda_intel works properly with 2.6.32-5-amd64 (and earlier kernels).
> 
