From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 00/12] snd-aoa: add snd-aoa
Date: Wed, 07 Jun 2006 15:09:09 +0200
Message-ID: <20060607130909.584205000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26E7B169
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 15:11:44 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: linuxppc-dev@ozlabs.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org

The following patches would add snd-aoa to the Linux source tree. I'm
posting them here now for some last round of review before I finally
post them with a Signed-Off-By and Changelog for inclusion. As you
previously asked about this, I don't think it makes sense to commit
these patches one by one, but the first one removing layout-id support
from snd-powermac might be worth singling out.
Please let me know either way so that I provide either one or two
changelog entries.

snd-aoa currently handles all Apple machines that have a layout-id
property in the sound node in the device-tree and doesn't attempt to
handle any others yet, a bunch of layout-ids are untested by users,
support for those was added based on the Info.plist file OSX has.

The only thing that still needs to be done is getting it to work on the
PowerMac7,2/7,3 where the device tree has a bug that apparently prevents
the i2sbus module from working properly.

Also, the DRC feature of the tas3004 codec should be exposed like
snd-powermac exposes it, so there'll probably be one more round of
patches before I will finally ask for inclusion.

Other than that, it replaces snd-powermac for all layout-id machines, and
handles many more already, so I have also added a patch to snd-powermac
to this patchset that removes support for any machines with a layout-id
it, allowing snd-aoa to take over for those machines even if both are
compiled in. On affected machines, snd-powermac will also give the hint
that snd-aoa should be used instead, but if snd-aoa is compiled as modules
it will load automatically.

Thanks for previous review, I hope I have incorporated all suggestions.
Over the previous version, the major change is adding the file
core/snd-aoa-gpio-feature.c which contains GPIO access routines for
those machine that don't have platform functions for it.

Any further comments are appreciated.

For the curious (like me :) ) here's a diffstat for the whole series:
 sound/Kconfig                                   |    2 
 sound/Makefile                                  |    2 
 sound/aoa/Kconfig                               |   17 
 sound/aoa/Makefile                              |    4 
 sound/aoa/aoa-gpio.h                            |   81 +
 sound/aoa/aoa.h                                 |  131 ++
 sound/aoa/codecs/Kconfig                        |   32 
 sound/aoa/codecs/Makefile                       |    3 
 sound/aoa/codecs/snd-aoa-codec-onyx.c           | 1113 ++++++++++++++++++++++++
 sound/aoa/codecs/snd-aoa-codec-onyx.h           |   76 +
 sound/aoa/codecs/snd-aoa-codec-tas-gain-table.h |  209 ++++
 sound/aoa/codecs/snd-aoa-codec-tas.c            |  653 ++++++++++++++
 sound/aoa/codecs/snd-aoa-codec-tas.h            |   47 +
 sound/aoa/codecs/snd-aoa-codec-toonie.c         |  140 +++
 sound/aoa/core/Makefile                         |    5 
 sound/aoa/core/snd-aoa-alsa.c                   |   98 ++
 sound/aoa/core/snd-aoa-alsa.h                   |   16 
 sound/aoa/core/snd-aoa-core.c                   |  156 +++
 sound/aoa/core/snd-aoa-gpio-feature.c           |  392 ++++++++
 sound/aoa/core/snd-aoa-gpio-pmf.c               |  246 +++++
 sound/aoa/fabrics/Kconfig                       |   12 
 sound/aoa/fabrics/Makefile                      |    1 
 sound/aoa/fabrics/snd-aoa-fabric-layout.c       | 1096 +++++++++++++++++++++++
 sound/aoa/soundbus/Kconfig                      |   14 
 sound/aoa/soundbus/Makefile                     |    3 
 sound/aoa/soundbus/core.c                       |  250 +++++
 sound/aoa/soundbus/i2sbus/Makefile              |    2 
 sound/aoa/soundbus/i2sbus/i2sbus-control.c      |  192 ++++
 sound/aoa/soundbus/i2sbus/i2sbus-control.h      |   37 
 sound/aoa/soundbus/i2sbus/i2sbus-core.c         |  387 ++++++++
 sound/aoa/soundbus/i2sbus/i2sbus-interface.h    |  187 ++++
 sound/aoa/soundbus/i2sbus/i2sbus-pcm.c          | 1017 +++++++++++++++++++++
 sound/aoa/soundbus/i2sbus/i2sbus.h              |  112 ++
 sound/aoa/soundbus/soundbus.h                   |  202 ++++
 sound/aoa/soundbus/sysfs.c                      |   43 
 sound/ppc/Makefile                              |    2 
 sound/ppc/pmac.c                                |   44 
 sound/ppc/pmac.h                                |    3 
 sound/ppc/powermac.c                            |    7 
 sound/ppc/toonie.c                              |  378 --------
 40 files changed, 6987 insertions(+), 425 deletions(-)


--
