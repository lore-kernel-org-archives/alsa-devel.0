From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with fm-801 module
Date: Thu, 7 Apr 2005 13:33:04 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504071332310.25376-100000@studcom.urz.uni-halle.de>
References: <20050401040414.90279.qmail@web54204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050401040414.90279.qmail@web54204.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Evandro Veloso Gomes <gnome_gtk2000@yahoo.com.br>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Evandro Veloso Gomes wrote:
> sudo insmod/home/kurumin/alsa-driver-1.0.8/pci/snd-fm801.ko

Don't use insmod but modprobe:

modprobe snd-fm801


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
