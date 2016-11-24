From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Subject: [PATCH v4 4/4] Documentation: ABI: Add ASoC Intel SST
	Atom sysfs description
Date: Thu, 24 Nov 2016 09:49:22 +0100
Message-ID: <20161124084922.9623-5-sebastien.guiriec@intel.com>
References: <20161124084922.9623-1-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C437A266A4E
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 09:53:26 +0100 (CET)
In-Reply-To: <20161124084922.9623-1-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org
Cc: Sebastien Guiriec <sebastien.guiriec@intel.com>
List-Id: alsa-devel@alsa-project.org

For ASoC Intel SST Atom based devices a sysfs entry is created
in order to track FW version. The FW version is useful in order to
check the different Version of LPE DSP FW across Intel SoCs.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-sst-atom | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-sst-atom

diff --git a/Documentation/ABI/testing/sysfs-platform-sst-atom b/Documentation/ABI/testing/sysfs-platform-sst-atom
new file mode 100644
index 0000000..abb131e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-sst-atom
@@ -0,0 +1,18 @@
+What:		/sys/devices/platform/8086%x:00/firmware_version
+Date:		November 2016
+KernelVersion:	4.10
+Contact:	"Sebastien Guiriec" <sebastien.guiriec@intel.com>
+Description:
+		LPE Firmware version for SST driver on all atom
+		plaforms (BYT/CHT/Merrifield/BSW).
+		If the FW has never been loaded it will display:
+			"FW not yet loaded"
+		If FW has been loaded it will display:
+			"v01.aa.bb.cc"
+		aa: Major version is reflecting SoC version:
+			0d: BYT FW
+			0b: BSW FW
+			07: Merrifield FW
+		bb: Minor version
+		cc: Build version
+
-- 
2.9.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
