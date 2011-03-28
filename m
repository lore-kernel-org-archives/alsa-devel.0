From: Svante Signell <svante.signell@telia.com>
Subject: Bug#613979: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Mon, 28 Mar 2011 23:54:36 +0200
Message-ID: <1301349276.21366.44.camel@hp.my.own.domain>
Reply-To: Svante Signell <svante.signell@telia.com>, 613979@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.613979.B613979.13013496654299@bugs.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: alsa-devel@alsa-project.org
Cc: 619034@bugs.debian.org, 613979@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Trying again to get this message to the alsa-devel list, as recommended
by the Debian maintainer of the kernel, without being subscribed. Does
alsa not have a bug report page?

Booting kernel 2.6.38  hangs at:
During boot of kernel 2.6.38 (and 2.6.37) udev bugs out:
Waiting for /dev to be fully populated
BUG: Unable to handle kernel paging request at ffffc90013cd8000
axz_probe+ ... [snd_hda_intel]
...lots of output lost...
udevadm timeout 180 sec ...
udevd[390]: worker [439] failed while handling
'/devices/pci0000:80/0000:80:01.0'

No sound card is recognized after the timeout of the boot as shown above.
According to the /proc/asound/cards there are no sound cards

See bug Debian bug #619034 for more information.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=619034

This problem was also reported as Debian bug #613979, as kernel ticket

https://bugzilla.kernel.org/show_bug.cgi?id=30552

and sent to this mailing list in February 2011.

snd_hda_intel works properly with 2.6.32-5-amd64 (and earlier kernels).
