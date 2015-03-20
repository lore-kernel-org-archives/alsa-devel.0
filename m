From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [FFADO-devel] [RFC][PATCH 00/13] alsa-tools: libhinawa for control
	applications of FireWire devices
Date: Fri, 20 Mar 2015 20:28:10 +1100
Message-ID: <550BE82A.7090901@gmail.com>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Folks,

Why can't we just use the proven alsa-mixer control system for all this?

It seems like you are reinventing the wheel just to save a little extra
code in the kernel.

Some of the benefits are that for pro-audio devices, you can use alsactl
save and restore to preserve internal sound card configuration between
bootups.  Also things like gnome-mixer just work out of the box.
Timing of when to send the commands is automatically solved, and the
problem of which sound card is which is already solved when multiple
sound cards are used.

Some of the sound cards don't have internal mixer matrices, and so for
these devices only the clock source control would be necessary.

Surely this is not too much of a burden to add to the kernel for the
benefits it provides?

Damien

On 25/01/15 22:34, Takashi Sakamoto wrote:
> This is RFC for a new library into alsa-tools.
> 
> ALSA in Linux 3.16 or later extends a support for FireWire sound devices.
> Currently ALSA drivers supports streaming functionality only, while
> most of these devices require software implementation to control its
> internal DSP. The way to achieve this is to transfer byte sequence to
> the unit and wait byte sequence which the unit transfers if required.
> 
> This library, libhinawa, just support these operations, nothing others. The
> supported types of transactions are:
>  - IEEE 1394 read transaction
>  - IEEE 1394 write transaction
>  - IEEE 1394 lock transaction
>  - IEC 61883-1 FCP transaction
>  - Echo Fireworks transaction (with a help of snd-fireworks kernel driver)
>  - Dice notification (with a help of snd-dice kernel driver)
> 
> To help new developers, this library supports GObject Introspection for
> language bindings. The main logic of applications can be written with
> preferred languages such as Python, Ruby, Perl and so on. In the end of
> this patchset, some Python scripts with Gtk+, Qt4 and Qt5 are committed as
> samples.
> 
> This is my first development with GNU Autotools, GLib/GObject and GObject
> Introspection. Furthermore, I'm a beginner of FireWire subsystem programming.
> I'm happy to receive your comments, especially:
>  - the way to write Linux version dependency in configure.ac
>  - the way of libtool versioning
>  - the value of poll timeout in fw_unit/snd_unit
>  - the value of thread condition timeout in fw_fcp/snd_dice/snd_efw
>  - improvements of 'unit_query' object
>  - any programming mistakes (threading and so on...)
> 
> Regards
> 
> Takashi Sakamoto (13):
>   libhinawa: add build definitions
>   libhinawa: add hinawa context
>   libhinawa: support GTK-Doc to generate references
>   libhinawa: add 'fw_unit' object as a listener for FireWire unit
>   libhinawa: support GObject Introspection for language bindings
>   libhinawa: add 'fw_resp' object as a responder for FireWire
>     transaction
>   libhinawa: add 'fw_req' object as requester for FireWire transaction
>   libhinawa: add 'fw_fcp' object as a helper of FCP transaction
>   libhinawa: add 'snd_unit' object as a listener for ALSA FireWire
>     devices
>   libhinawa: add 'snd_dice' object as a helper for Dice notification
>   libhinawa: add 'snd_efw' object as a helper for EFW transaction
>   libhinawa: add 'unit_query' as a query for ALSA FireWire devices
>   libhinawa: add sample scripts
> 
>  Makefile                                 |   2 +-
>  libhinawa/AUTHORS                        |   1 +
>  libhinawa/COPYING                        | 504 ++++++++++++++++++++++++++++
>  libhinawa/ChangeLog                      |   5 +
>  libhinawa/Makefile.am                    |   6 +
>  libhinawa/NEWS                           |   0
>  libhinawa/README                         |  30 ++
>  libhinawa/autogen.sh                     |  11 +
>  libhinawa/configure.ac                   |  68 ++++
>  libhinawa/doc/Makefile.am                |   2 +
>  libhinawa/doc/reference/Makefile.am      |  46 +++
>  libhinawa/doc/reference/hinawa-docs.sgml |  47 +++
>  libhinawa/doc/reference/version.xml.in   |   1 +
>  libhinawa/samples/gtk3.py                | 190 +++++++++++
>  libhinawa/samples/qt4.py                 | 206 ++++++++++++
>  libhinawa/samples/qt5.py                 | 192 +++++++++++
>  libhinawa/samples/run.sh                 |  15 +
>  libhinawa/src/Makefile.am                |  97 ++++++
>  libhinawa/src/backport.h                 |  41 +++
>  libhinawa/src/fw_fcp.c                   | 282 ++++++++++++++++
>  libhinawa/src/fw_fcp.h                   |  58 ++++
>  libhinawa/src/fw_req.c                   | 265 +++++++++++++++
>  libhinawa/src/fw_req.h                   |  56 ++++
>  libhinawa/src/fw_resp.c                  | 232 +++++++++++++
>  libhinawa/src/fw_resp.h                  |  51 +++
>  libhinawa/src/fw_unit.c                  | 343 +++++++++++++++++++
>  libhinawa/src/fw_unit.h                  |  52 +++
>  libhinawa/src/hinawa_context.c           |  60 ++++
>  libhinawa/src/hinawa_context.h           |  10 +
>  libhinawa/src/internal.h                 |  31 ++
>  libhinawa/src/snd_dice.c                 | 195 +++++++++++
>  libhinawa/src/snd_dice.h                 |  53 +++
>  libhinawa/src/snd_efw.c                  | 315 ++++++++++++++++++
>  libhinawa/src/snd_efw.h                  |  54 +++
>  libhinawa/src/snd_unit.c                 | 548 +++++++++++++++++++++++++++++++
>  libhinawa/src/snd_unit.h                 |  69 ++++
>  libhinawa/src/unit_query.c               | 116 +++++++
>  libhinawa/src/unit_query.h               |  48 +++
>  38 files changed, 4301 insertions(+), 1 deletion(-)
>  create mode 100644 libhinawa/AUTHORS
>  create mode 100644 libhinawa/COPYING
>  create mode 100644 libhinawa/ChangeLog
>  create mode 100644 libhinawa/Makefile.am
>  create mode 100644 libhinawa/NEWS
>  create mode 100644 libhinawa/README
>  create mode 100755 libhinawa/autogen.sh
>  create mode 100644 libhinawa/configure.ac
>  create mode 100644 libhinawa/doc/Makefile.am
>  create mode 100644 libhinawa/doc/reference/Makefile.am
>  create mode 100644 libhinawa/doc/reference/hinawa-docs.sgml
>  create mode 100644 libhinawa/doc/reference/version.xml.in
>  create mode 100755 libhinawa/samples/gtk3.py
>  create mode 100755 libhinawa/samples/qt4.py
>  create mode 100755 libhinawa/samples/qt5.py
>  create mode 100755 libhinawa/samples/run.sh
>  create mode 100644 libhinawa/src/Makefile.am
>  create mode 100644 libhinawa/src/backport.h
>  create mode 100644 libhinawa/src/fw_fcp.c
>  create mode 100644 libhinawa/src/fw_fcp.h
>  create mode 100644 libhinawa/src/fw_req.c
>  create mode 100644 libhinawa/src/fw_req.h
>  create mode 100644 libhinawa/src/fw_resp.c
>  create mode 100644 libhinawa/src/fw_resp.h
>  create mode 100644 libhinawa/src/fw_unit.c
>  create mode 100644 libhinawa/src/fw_unit.h
>  create mode 100644 libhinawa/src/hinawa_context.c
>  create mode 100644 libhinawa/src/hinawa_context.h
>  create mode 100644 libhinawa/src/internal.h
>  create mode 100644 libhinawa/src/snd_dice.c
>  create mode 100644 libhinawa/src/snd_dice.h
>  create mode 100644 libhinawa/src/snd_efw.c
>  create mode 100644 libhinawa/src/snd_efw.h
>  create mode 100644 libhinawa/src/snd_unit.c
>  create mode 100644 libhinawa/src/snd_unit.h
>  create mode 100644 libhinawa/src/unit_query.c
>  create mode 100644 libhinawa/src/unit_query.h
> 

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
