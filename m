From: Alexandrov Stansilav <neko@nya.ai>
Subject: [PATCH v3 0/2] ASoC: Add support for rt5640 sound card
	found on HP Pavilion x2 10-p000 tablet.
Date: Fri,  6 Jan 2017 03:09:45 +0300
Message-ID: <cover.1483660468.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thorium.nya.ai (thorium.nya.ai [109.195.179.38])
 by alsa0.perex.cz (Postfix) with ESMTP id B989B266AA3
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 01:09:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Inside DSDT table there is record for this soundcard:

            Device (RTKC)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "10EC3276")  // _HID: Hardware ID
                Name (_CID, "10EC3276")  // _CID: Compatible ID
                Name (_DDN, "ALC3276")  // _DDN: DOS Device Name
                Name (_SUB, "103C827C")  // _SUB: Subsystem ID
                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0

original bugreport: https://bugzilla.kernel.org/show_bug.cgi?id=187621

v3: Fixed patch descriptions
v2: Splited patch to codec and sst parts


Alexandrov Stansilav (2):
  ASoc: rt5640: Add "10EC3276" ACPI ID
  ASoC: Intel: Atom: Add HP Pavilion x2 10 10-p000 machine entry

 sound/soc/codecs/rt5640.c           | 1 +
 sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.10.2
