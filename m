From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: The ALSA Situation
Date: Fri, 12 Nov 2004 16:06:41 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411121559200.16196-100000@studcom.urz.uni-halle.de>
References: <20041112082446.GA16172@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041112082446.GA16172@rhlx01.fht-esslingen.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andi@lisas.de
Cc: alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@usm.cl>
List-Id: alsa-devel@alsa-project.org

Andreas Mohr wrote:
> Don't we have a problem here??
> ...
> d) H/W (1/4) * S/W (1/4) each == S/W (1/16) each !!
>
> which clearly has a different volume (1/16 of total output) than each
> of the H/W-mix-only channels (1/4).

dmix simply adds (and clips), so this isn't a problem.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
