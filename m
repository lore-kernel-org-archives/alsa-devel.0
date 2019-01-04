From: Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 0/2] Add MICFIL DAI support
Date: Fri, 4 Jan 2019 09:17:36 +0000
Message-ID: <1546593445-10509-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 793C62679A1
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 10:17:37 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
Cc: Cosmin Samoila <cosmin.samoila@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

PDM is a popular way to deliver audio from microphones to the processor
in several applications, such as mobile telephones. However, current
digital-audio systems use multibit audio signal (also known as multibit
PCM) to represent the signal. For this purpose a set of FIR, CIC or/and
Half Band filters are usually implemented on DSPs or software. This block
implements the required digital interface to provide a 16-bit audio signal
from a PDM microphone bitstream in a configurable output sampling rate.
The implementation of this digital interface is based on the application
of digital signal processing techniques in hardware. The PDM Microphone
Interface architecture was designed to gate saving and minimal power
consumption. It implements a bunch of filters to transform a 1-bit PDM
bitstream to a 16-bit PCM signal in the audio band. To avoid aliasing
frequencies in passband, the overall filter has 80 dB stopband attenuation
and passband ripple less than 0.2dB.
The whole module is implemented to work in a multichannel mode. All
channels have the same configuration but each input channel could be turned
on/off independently.


Changes since v1:
- removed the hwvad support from patches since it is a separate functionality
and it needs some design rework. Will address HWVAD in later series of patches
after analyzing comunity feedback and design guildlines.
- removed clock source choice for clock driver and use the AudioPLL1 as clock
source. Having only one clock source it is sufficient for basic functionality.
- removed dma-names and status from dt-bindings
- changed volume control names and type to S_VALUE

Cosmin-Gabriel Samoila (2):
  ASoC: micfil: Add bindings for MICFIL DAI
  ASoC: Add MICFIL SoC Digital Audio Interface driver.

 .../devicetree/bindings/sound/fsl,micfil.txt       |  32 +
 sound/soc/fsl/Kconfig                              |   9 +
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_micfil.c                         | 895 +++++++++++++++++++++
 sound/soc/fsl/fsl_micfil.h                         | 283 +++++++
 5 files changed, 1221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt
 create mode 100644 sound/soc/fsl/fsl_micfil.c
 create mode 100644 sound/soc/fsl/fsl_micfil.h

-- 
2.7.4
