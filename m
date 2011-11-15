From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] hda - delayed ELD repoll
Date: Tue, 15 Nov 2011 10:25:00 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740805DE1@HQMAIL01.nvidia.com>
References: <20111115143155.GA28175@localhost>
	<20111115143315.GA28561@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id CF6F324349
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 19:25:08 +0100 (CET)
In-Reply-To: <20111115143315.GA28561@localhost>
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
To: Wu Fengguang <fengguang.wu@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Wu Fengguang wrote at Tuesday, November 15, 2011 7:33 AM:
> The Intel HDMI chips (ironlake at least) are found to have ~250ms delay
> between the ELD_Valid=1 hotplug event is send and the ELD buffer becomes
> actually readable. During the time the ELD buffer is mysteriously all 0.
> 
> Fix it by scheduling a delayed work to re-read ELD buffer after 300ms.

Any idea why; is the graphics driver writing the ELD data to the audio HW
after triggering the unsolicited even rather than before, or something
like that? 250mS almost sounds like it's setting ELDV in the audio HW,
then going and reading the EDID, then writing the EDID to the audio HW;
perhaps the graphics driver is accidentally setting PRESENT+ELDV when it's
meant to be setting just PRESENT, and later setting ELDV?

-- 
nvpublic
