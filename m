From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Question on USB Audio delay calculations
Date: Fri, 6 Nov 2015 08:48:48 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60552A94614@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 77B31265A2D
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 09:48:56 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I have a question regarding reporting of the "delay" in the USB audio driver.

While starting the endpoint from "prepare" (snd_usb_endpoint_start) for playback operation, it submits 
empty URBs but it doesn't take them into account for "delay". When the start comes from user, the new 
URB won't get submitted until the previous one completes, so shouldn't we increment the delay when
we submit the empty URBs before the actual start has come, because it does contribute to "delay".

I can submit the patch, if my understanding is right.

Regards,
Rakesh



 
