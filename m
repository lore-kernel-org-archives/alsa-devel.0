From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA for Embedded Devices
Date: Mon, 8 Nov 2004 18:34:16 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411081832300.16893-100000@studcom.urz.uni-halle.de>
References: <50bc793304110309071394d803@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <50bc793304110309071394d803@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: postravi@gmail.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

postravi@gmail.com wrote:
> I am using the 2.6.8 flavor alright. But could you tell me is this
> a system where ALSA can be loaded.

Yes, ALSA is built in.

> Also I am not sure what the device nodes should be, is it enough
> if I run the ./snddevices script?

Yes.

> Also are there any modules required for the ALSA to run on this
> kernel to provide sound support.

The ALSA framework and the drivers can be compiled as modules or can
be compiled into the kernel, just like all the other drivers.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
