From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No sound with alsa and intel8x0 on Intel ICH5R
Date: Thu, 15 Jan 2004 17:08:30 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401151705460.14174-100000@studcom.urz.uni-halle.de>
References: <1074170953.17555.10.camel@p4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1074170953.17555.10.camel@p4>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joel Metelius <joel.metelius@home.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Joel Metelius wrote:
> I have a Gigabyte GA-8IK1100 motherboard with an onboard ICH5R chip and
> the AC97 CODEC.

What codec? (see first line of /proc/asound/card0/codec97#0/ac97#0-0)

> With ALSA I get no sound at all and with OSS I get sound but at
> wrong frequency (playing too slow).

ALSA has a bug in connection with ALC655/658 codecs.
Please try to reconfigure the audio jacks with alsamixer.

> When trying to compile alsa-drivers separately it complains about
> linux/arch/x86 not existing (and it doesn't).

You need the kernel sources to compile ALSA.  See the --with-kernel
option of configure.


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
