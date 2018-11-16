From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH v3 0/2] Introduce dmic mode switch delay
	parameter
Date: Fri, 16 Nov 2018 16:40:07 +0530
Message-ID: <1542366609-18861-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ED8B267949
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 12:10:18 +0100 (CET)
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
etc. This  series add a mode-switch delay which will prevent the clock from
being turned off without complying with manufacturer timing
specifications. Also introduces a module parameter for the wakeup_delay parameter.

v1: First patch set
v2: 
1). Removed ACPI device entry since a) The DMIC vendor doesn't have an ACPI vendor
ID b) The ACPI enumeration creates one more device and conflicts with the existing
skl.c dmic platform device registration.
2). Updated commit message

v3: Updated commit message and introduced module param for wakeup_delay


Jenny TC (2):
  ASoC: dmic: introduce mode switch delay
  ASoC: dmic: introduce module_param wakeup_delay

 sound/soc/codecs/dmic.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

-- 
1.9.1
