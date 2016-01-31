From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: The location of libhinawa and hinawa-utils for FireWire sound devices
	?
Date: Sun, 31 Jan 2016 20:27:24 +0900
Message-ID: <56ADEF9C.50303@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: hayashi@clear-code.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux1394-devel@lists.sourceforge.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

In this thread, I'd like to discuss about the location of 'libhinawa' and
'hinawa-utils'. Currently, I push them to github.com for my convenience,
while I also think it better to put them in git.alsa-project.org. Then, I
concern about some issues about packaging. Before discussing about the
issues, I'd like you to read my explaination about the aim of these
softwares. (Sorry to take a bit long story...)


This month I concentrated on userspace utilities for some devices
supported by ALSA firewire stack[0]. Today, I released libhinawa 0.7.0.
https://github.com/takaswie/libhinawa

As applications of libhinawa, I wrote some CUI tools as python3
modules/scripts and push them to 'hinawa-utils' repository.
https://github.com/takaswie/hinawa-utils

Currently, below scripts are available in the repository:
 * hinawa-bebob-parser
    * Plug structure parser for BeBoB firmware
 * hinawa-dg00x-cui
    * CUI tool for Digidesign Digi00x family
 * hinawa-dice-common-cui
    * CUI tool for Dice common functionalities
 * hinawa-fireworks-cui
    * CUI tool for Echo Audio Fireworks module
 * hinawa-griffin-firewave-cui
    * CUI tool for Griffin Firewave
 * hinawa-lacie-speakers-cui
    * CUI tool for Lacie FireWire speakers
 * hinawa-maudio-bebob-normal-cui
    * CUI tool for M-Audio FireWire series
 * hinawa-maudio-bebob-special-cui
    * CUI tool for M-Audio FireWire series with largely customized firmware
 * hinawa-oxfw-generic-cui
    * CUI tool for OXFW generic functionalities
 * hinawa-tascam-fireone-cui
    * CUI tool for Tascam FireOne
 * hinawa-tscm-fw-cui
    * CUI tool for Tascam FireWire series
 * hinawa-yamaha-go-cui
    * CUI tool for Yamaha GO series


The 'libhinawa' is I/O library of IEEE 1394 asynchronous transactions
to/from units on IEEE 1394 bus. The aim of this library is to assist
userspace applications to control the physical units. Additionally, this
library supports some ioctl commands which ALSA firewire stack has[1].

The library is written according to GLib/GObject[2] fashion, and supports
GObject Introspection[3] to allow each language implementation to handle
the library. For example, in python3, the library is available via
PyGObject[4]. Totally, the library supports developers to write userspace
applications with their preferable languages.


Well, let me to share my issues. At a beginning of this development, I
planned to merge them to 'alsa-tools.git'[5], and I've posted my first
RFCs as a part of alsa-tools.git. In this repository, there're some
stand-alone applications. But 'libhinawa' includes a shared library and
'hinawa-utils' includes python3 modules, python3 scripts. They're not a
single application.

When we put them to the repository, I can imagine some issues related to
packaging in Linux distribution side, especially, package dependency. The
libhinawa adds new build-dependency to:
 * automake
 * autoconf
 * libtool
 * libglib
 * gtk-doc-tools
 * gobject-introspection
 * libgirepository
Additionally, it adds new runtime-dependency to (not so cleared):
 * python3
 * python-gobject

They will be newly applied to 'alsa-tools' package. It seems to bring
package maintainers to harder work to satisfy the dependency to build
'alsa-tools' package. To me, it's worse cost-effectiveness.

So, currently, I think it better to maintain these two softwares in
github.com, or adds new repository to git.alsa-project.org. I'd like to
get your comments about this issue.

Regards

[0] under 'sound/firewire' of Linux kernel source.
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/firewire
[1] 'include/uapi/sound/firewire.h' of Linux kernel
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/firewire.h
[2] https://developer.gnome.org/gobject/stable/
[3] https://wiki.gnome.org/Projects/GObjectIntrospection
[4] https://wiki.gnome.org/Projects/PyGObject
[5] http://git.alsa-project.org/?p=alsa-tools.git;a=summary
[6] [RFC][PATCH 00/13] alsa-tools: libhinawa for control applications of
FireWire devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/086969.html


Takashi Sakamoto

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
