From: tapio.vihuri@nokia.com
Subject: [PATCH v7 0/2] input: Add support for ECI (multimedia)
	accessories
Date: Tue, 15 Feb 2011 15:11:58 +0200
Message-ID: <1297775520-1993-1-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id DA05510388C
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 14:12:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dmitry.torokhov@gmail.com
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, samu.p.onkalo@nokia.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

From: Tapio Vihuri <tapio.vihuri@nokia.com>

Thank you for comments.

Major reformat inspired by adxl34x implementation.

There is no more separate input and controller driver. They are combined
into one, and controller part is selectable via Kconfig. 

Driver is now called simply "ECI input driver"

I'm planning to introduce second controller later. Both controllers are
i2c-devices, but internal way of working is totally different.

Created against linux-2.6.38-rc4 at:
795abaf klist: Fix object alignment on 64-bit.

Please review.

--- v6 message ---

Thank you for comments.

ECI input driver changes:
- Add debuging config option with adequate "help" in Kconfig
- Clean out debug messages
- Clean out error messages
- Force all buttons up event when unplugging accessory

ECI controller driver changes:
- Remove unused debuging config option

Created against linux-2.6.38-rc2 at:
70d1f36 Merge branch 'for-linus' of git://git.infradead.org/ubi-2.6

Please review.

--- v5 message ---

Thank you for comments.

ECI input driver changes:

- Use sparse_keymap_setup() properly, remove unneeded input set_bits

ECI controller driver changes:

- Added "button" debugfs entry for input driver buttons handling testing

--- v4 message ---

Thank you for comments.

ECI input driver changes:

- Use driver name in debugfs
- reject accessory stating more than maximum 31 buttons
- clean out couple comments

ECI controller driver changes:

- name change, from ecibus to eci_xxx_ctrl
- location change, from drivers/ecibus to drivers/input/misc
- major rework from platform driver to i2c-driver
- removed mrst platform dependency

Checkpatch warn about Kconfig, but I think it is false positive, and I will
report it to the maintainer.

Platform code changes:

- medfield_ prefix changed to mrst_
- added ECI controller needed power control
- remover ECI controller platform driver stuff
- added i2c stuff for ECI controller driver

Created against linux-2.6.37-rc8 at:
a25cecc Merge branch 'next' of git://git.monstr.eu/linux-2.6-microblaze

--- v3 message ---

Thank you for comments.

ECI input driver changes:

- Makefile and Kconfig sorted alphabetically
- using sparse keymap library, much cleaner solution
- correct string aligment with 80 column
- debugfs initialization fix
- sysfs cable entry using just 0/1
- using cheaper __set_bit
- insane comments fixed
- remove unneeded misc device

Created against linux-2.6.37-rc8 at:
989d873 Merge master.kernel.org:/home/rmk/linux-2.6-arm

--- v2 message ---

Thank you for comments.

In series two there Kconfig dependency problem fixed, preventing compilation
if X86_MRST (Intel Moorestown) or INPUT_MISC is not selected.

Also created against linux-2.6.37-rc8

--- v1 message ---

Hi all

This patch set introduce Multimedia Headset Accessory support for
Nokia phones. Technically those are known as ECI (Enhancement Control Interface)
	
If headset has many buttons, like play, vol+, vol- etc. then it is propably ECI
accessory.

Among several buttons ECI accessories contains memory for storing several
parameters.

This ECI input driver provides the following features:
 - reading ECI configuration memory
 - ECI buttons as input events

Drive is constructed as follows:
 - ECI accessory input driver deals with headset accessory
 - ECI bus control driver deals the HW transfering data to/from headset
 - platform data match used HW

In the future accessory detection logic will be added using ALSA jack reporting.

Created against linux-2.6.37-rc6

Please review.

Tapio Vihuri (2):
  ECI: input: introduce ECI accessory input driver
  ECI: adding platform data for ECI driver

 arch/x86/platform/mrst/mrst.c     |   32 ++
 drivers/input/misc/Kconfig        |   47 ++
 drivers/input/misc/Makefile       |    3 +-
 drivers/input/misc/eci.c          |  851 +++++++++++++++++++++++++++++++++++++
 drivers/input/misc/eci_at20-i2c.c |  713 +++++++++++++++++++++++++++++++
 include/linux/input/eci.h         |  189 ++++++++
 6 files changed, 1834 insertions(+), 1 deletions(-)
 create mode 100644 drivers/input/misc/eci.c
 create mode 100644 drivers/input/misc/eci_at20-i2c.c
 create mode 100644 include/linux/input/eci.h
