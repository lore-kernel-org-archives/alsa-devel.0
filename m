From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Changing BIOS IRQs and I/O addresses
Date: Wed, 28 May 2003 12:49:49 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305281245410.8615-100000@studcom.urz.uni-halle.de>
References: <20030528100042.GA7426@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA16286
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2003 13:01:52 +0200
In-reply-to: <20030528100042.GA7426@ee.unsw.edu.au>
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
> Unfortunatly the IRQ is set up by the BIOS to be 0.
> This bios does not let the user alter the IRQs.

Usually, the BIOS has an option "PnP OS" or maybe "ACPI OS" to specify
whether the resources are to be allocated by the BIOS or by the OS.

If your BIOS doesn't support this, you have to configure the Linux kernel
to allocate the resources. I don't know if or how this is possible.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
