From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 0x10b9:0x5461 not supported?
Date: Thu, 21 Jul 2005 10:48:33 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507211046210.19476-100000@studcom.urz.uni-halle.de>
References: <42DE990A.6020702@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42DE990A.6020702@gmx.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk <noisyb@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dirk wrote:
> The mainboard description
> (http://www.asus.com/prog/spec.asp?m=P5RD1-V&langs=01) says it's a
> Realtek ALC 861... but "lspci -n" identifies (0x10b9) ALi and not
> RealTek... :-/

The PCI device is an HDA controller, the Realtek chip is an HDA codec.
HDA is a specification for a bus to connect these two.


It has been confirmed that the controller isn't compatible with the
Intel HDA controller, so you don't need to try to get it to compile.
We have to try to get documentation from ALi.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
