From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: SiS7012 hang alsa version 0.9.3c
Date: Mon, 26 May 2003 10:44:31 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305261041530.24202-100000@studcom.urz.uni-halle.de>
References: <20030524170852.GB15643@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA02207
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2003 10:56:08 +0200
In-reply-to: <20030524170852.GB15643@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Flax <flatmax@pgb.unsw.edu.au>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Matt Flax wrote:
> When I try to load the intel alsa module I get a hang state, with this
> output :
> PCI: Enabling device 00:02.7 (0000 -> 0001)
> PCI: No IRQ known for interrupt pin C of device 00:02.7. Please try
> using pci=biosirq.
> ALSA ../alsa-kernel/pci/intel8x0.c:2249: unable to grab IRQ 0
>
> So I appended that to the lilo.conf file and ran lilo, upon reboot -
> same problem.

Apparently, your BIOS didn't allocate an interrupt for the AC'97 device.
Try changing some PnP-related settings in the BIOS setup.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
