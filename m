From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Finding xruun sources in cs46xx
Date: Mon, 8 Nov 2004 19:07:11 +0100
Message-ID: <20041108190711.6363d48c@mango.fruits.de>
References: <20041108184356.6cdb742a@mango.fruits.de>
	<Pine.HPX.4.33n.0411081846480.16893-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id C07642A0
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 19:06:59 +0100 (MET)
In-Reply-To: <Pine.HPX.4.33n.0411081846480.16893-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Nov 2004 18:52:36 +0100 (MET)
Clemens Ladisch <clemens@ladisch.de> wrote:

> Not for me.  Are you using a threaded interrupts?
> 
> Try asking on LKML.

Oh well, actually it does make no difference wrt the # of xruns whether i
use threaded irq handlers or not [but seemingly to the debug output :)]. I
will build a normal VP kernel tomorrow where i can unthread the cs46xx irq

flo


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
