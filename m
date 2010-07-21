From: Wei Ni <wni@nvidia.com>
Subject: Support MCP89 hdmi audio
Date: Wed, 21 Jul 2010 19:45:09 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C29D065C70@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EFA52459F
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 13:45:13 +0200 (CEST)
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
To: 'Takashi Iwai' <tiwai@suse.de>, Wu Fengguang <fengguang.wu@intel.com>
Cc: 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'linux-kernel' <linux-kernel@vger.kernel.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

Hi, all
I'm an Nvidia engineer, I maintain the nvidia linux hdmi audio driver.

An end-user report a problem with his TV attached to an MCP89.
ALSA won't send audio to it, because
PD=0:
HDMI hot plug event: Pin=5 Presence_Detect=1 ELD_Valid=0
HDMI hot plug event: Pin=5 Presence_Detect=0 ELD_Valid=1

As you know, in linux driver patch_hdmi.c, it use (pind && eldv)
in unsolicited events. So the driver can't detect the monitor.

>From the HAD specification
(http://download.intel.com/standards/hdaudio/pdf/HDA036.pdf):

Original text for Unsolicited Response PD bit:

Presence Detect: When this bit is set, sense measurement has
changed on the pin widget and software can use the pin sense
control verb to determine the current pin sense data state.
For analog pin widgets, this UR means that Presence Detect or
Impedance has changed on the pin widget.
For digital pin widgets, including HDMI pin widgets, this means
that presence detect (and optionally ELD valid bit) has
**changed**. [my emphasis]

Updated text for Unsolicted Response PD bit:

Presence Detect: This bit reflects the **present** [my
emphasis] state of the Pin Sense Presence Detect bit when the
unsolicited response is triggered. Software can optionally use
the pin sense control verb to determine the latest pin sense
data state. This bit implementation is only required for
digital display pin widget. Non digital display pin widget is
optional to implement this bit.

For our MCP89, the values indicates the change of status of PD, not the actual value of PD,
which follows older description of UR for PD bit.

So could we add a workaround for MCP89? We could use Pin Sense to determine again in
unsolicited events. If it return 0xc0000000, it means PD=1 and ELVD=1.
Or do you have any suggestions?

Thanks
Wei.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
