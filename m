From: Stephen Warren <swarren@nvidia.com>
Subject: Missing 4-channel support on older NVIDIA MCP HW
Date: Mon, 30 Aug 2010 10:11:09 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FEF39906@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C04D243FF
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 19:11:13 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
Cc: Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

It looks like even though some NVIDIA MCPs have min/max channel of 2/8, not
all HW supports the intermediate # channels (4 and 6) over HDMI. Various
combinations are supported on various HW: 2, 2/8, 2/6/8, 2/4/6/8.

At present, when an application uses an unsupported number of channels,
playback appears to operate correctly, but the HW doesn't actually send the
audio data over HDMI.

Is it possible for patch_nvhdmi.c to simply program codec the HW in 8-channel
mode even though the controller is only sending 4-/6-channel data? I'm not
sure if this would cause the codec to get out of sync with the controller's
data stream. Would the controller end up grabbing 8 channels worth of data
from the stream at a time, have no way to synchronize to the start of each
sample, and hence end up packing e.g. 2 complete 4 channel samples into a
single 8 channel sample?

If not, it seems that patch_nvhdmi.c should be modified so that each codec's
_open() function returns an error for unsupported rates. I can code that up
if we need.

Unfortunately, it doesn't look like it's possible for applications to query
this information from ALSA, since a hw_params_t exposes just a min/max
channel count rather than a mask.

-- 
nvpublic
