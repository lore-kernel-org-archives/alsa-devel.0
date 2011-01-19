From: tapio.vihuri@nokia.com
Subject: [PATCH v4 0/3] input: Add support for ECI (multimedia)
	accessories
Date: Wed, 19 Jan 2011 14:06:53 +0200
Message-ID: <1295438816-27937-1-git-send-email-tapio.vihuri@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 218352442D
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:07:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dmitry.torokhov@gmail.com, peter.ujfalusi@nokia.com
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, ilkka.koskinen@nokia.com, linux-kernel@vger.kernel.org, samu.p.onkalo@nokia.com
List-Id: alsa-devel@alsa-project.org

From: Tapio Vihuri <tapio.vihuri@nokia.com>

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


Tapio Vihuri (3):
  ECI: input: introduce ECI accessory input driver
  ECI: introducing ECI controller driver
  ECI: adding platform data for ECI driver

 arch/x86/platform/mrst/mrst.c      |   49 ++
 drivers/input/misc/Kconfig         |   60 +++
 drivers/input/misc/Makefile        |    3 +-
 drivers/input/misc/eci.c           |  946 ++++++++++++++++++++++++++++++++++++
 drivers/input/misc/eci_at20_ctrl.c |  533 ++++++++++++++++++++
 include/linux/input/eci.h          |  179 +++++++
 6 files changed, 1769 insertions(+), 1 deletions(-)
 create mode 100644 drivers/input/misc/eci.c
 create mode 100644 drivers/input/misc/eci_at20_ctrl.c
 create mode 100644 include/linux/input/eci.h
