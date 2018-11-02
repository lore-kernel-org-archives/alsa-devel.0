From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH v2 0/1] Introduce dmic mode switch delay
	parameter
Date: Fri,  2 Nov 2018 13:00:46 +0530
Message-ID: <1541143847-30450-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 138742677E4
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 08:30:57 +0100 (CET)
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
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Some DMICs need clock to be running for a specified duration as per the
DMIC spec to complete the mode transition like sleep to normal, off to normal
etc.

v1: First patch set
v2: 
1). Removed ACPI device entry since a) The DMIC vendor doesn't have an ACPI vendor
ID b) The ACPI enumeration creates one more device and conflicts with the existing
skl.c dmic platform device registration.
2). Updated commit message


Jenny TC (1):
  ASoC: dmic: Introduce mode switch delay

 sound/soc/codecs/dmic.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

-- 
1.9.1
