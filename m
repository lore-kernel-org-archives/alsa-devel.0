From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] Echoaudio driver
Date: Mon, 8 Nov 2004 19:16:21 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411081906090.16893-100000@studcom.urz.uni-halle.de>
References: <20041106235352.72b20afa.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041106235352.72b20afa.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
> I don't see anything obviously wrong in the driver now.

AFAICS the MODULE_LICENSE is really "Dual BSD/GPL", apart from the
non-GPL (?) firmware which would belong into the alsa-firmware
package.

Does it compile on 2.4.x kernels?  On 2.2.x kernels?  >;-)
(I guess we can deactivate it if it's compiled on kernels without
request_firmware().)

> What have I to do to include it in alsa-driver yet ?

Make a big patch, then yell loudly until somebody includes it.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
