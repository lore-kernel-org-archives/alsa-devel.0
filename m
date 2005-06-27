From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-bt87x
Date: Mon, 27 Jun 2005 16:07:20 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506271605270.1958-100000@studcom.urz.uni-halle.de>
References: <200506270017.12541.averne@pld-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200506270017.12541.averne@pld-linux.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcin =?iso-8859-2?q?Doli=F1ski?= <averne@pld-linux.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Marcin Doli=F1ski wrote:
> Hi, i have FlyVideo98 TV card. There's no pciid for it in ALSA.
> I've checked it:
> pciid: 109e:0878

Thanks, but these are the vendor/device IDs of the chip itself.  We
need the subvendor/subdevice IDs to be able to identify this card.

Please show the output of "lspci -nv" for this card.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
