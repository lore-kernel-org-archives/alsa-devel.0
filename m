From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/4] Driver for RME MADI FX
Date: Sat,  8 Aug 2015 18:23:33 +0200
Message-ID: <1439051017-15401-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <5537C5FF.6070607@spectralbird.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5537C5FF.6070607@spectralbird.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Adrian Knoth <aknoth@google.com>
List-Id: alsa-devel@alsa-project.org

From: Adrian Knoth <aknoth@google.com>

Hi!

As discussed before, here's the current driver for the RME MADI FX for
mainline inclusion. So far, only the PCIe version is supported, not the
USB3.0 counterpart.

Adrian Knoth (4):
  ALSA: madifx - Makefile entries for RME MADI FX
  ALSA: Add RME MADI FX Kconfig entries
  ALSA: madifx - Expose preliminary userspace interface
  ALSA: madifx - Add support for RME MADI FX

 include/uapi/sound/madifx.h |  165 ++
 sound/pci/Kconfig           |   21 +
 sound/pci/rme9652/Makefile  |    2 +
 sound/pci/rme9652/madifx.c  | 3659 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 3847 insertions(+)
 create mode 100644 include/uapi/sound/madifx.h
 create mode 100644 sound/pci/rme9652/madifx.c

-- 
2.1.0
