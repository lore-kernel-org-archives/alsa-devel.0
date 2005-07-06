From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to aquire headphone jack sense
Date: Wed, 6 Jul 2005 16:03:37 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507061601040.20265-100000@studcom.urz.uni-halle.de>
References: <4F7EC8DB-D872-4C1A-A850-3E49959F8FA2@hermstedt.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4F7EC8DB-D872-4C1A-A850-3E49959F8FA2@hermstedt.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Bernd_L=F6hr?= <B.Loehr@hermstedt.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bernd L=F6hr wrote:
> how can I find out (via libalsa) if a headphone is plugged in?

Currently not at all.

> I'm using an embedded system with AC97 / AD1981B sound device
> which supports jack sensing. The only thing: How can I access that
> info via ALSA.

You could try to read the codec registers in
/proc/asound/card0/codec97#0/ac97#0-0.

It might be possible to add an hardware dependent device to ALSA for
this information.

> Is it also possible, to use the OSS emulation layer to get this
> info?

OSS doesn't define any IOCTL for this.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
