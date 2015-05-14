From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 0/4] ACPI: provide an override for _REV
Date: Thu, 14 May 2015 15:31:24 +0200
Message-ID: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: alsa-devel@alsa-project.org

As promised, here are a few patches which allow to override the _REV
(supported ACPI revision) setting of the ACPI implementation. With
this patch in place (and possibly with other quirks added to
drivers/acpi/osl.c -- Matthew mentioned the Inspiron 7437), the
patch b1ef29725865 can be applied again (or the revert of
b1ef29725865 be reverted).

Also throw in a re-ordering of the kernel-parameters Documentation.

Dominik Brodowski (4):
  acpi: use same type for acpi_predefined_names values as in definition
  acpi: allow for an override to set _REV
  acpi: add _REV quirk for Dell XPS 13 (2015)
  acpi: fix kernel-parameters ordering in Documentation

 Documentation/kernel-parameters.txt | 76 ++++++++++++++++++++++---------------
 drivers/acpi/Kconfig                | 15 ++++++++
 drivers/acpi/bus.c                  |  2 +
 drivers/acpi/internal.h             |  1 +
 drivers/acpi/osl.c                  | 60 ++++++++++++++++++++++++++++-
 include/acpi/acpiosxf.h             |  2 +-
 6 files changed, 123 insertions(+), 33 deletions(-)

-- 
2.1.4

