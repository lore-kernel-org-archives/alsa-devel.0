From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: fix hdmi codec driver contest in
 S3
Date: Tue, 26 Mar 2019 08:46:31 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19527FB2CE@SHSMSX103.ccr.corp.intel.com>
References: <1553235896-8185-1-git-send-email-libin.yang@intel.com>
 <s5hpnqjp9es.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527F9BB6@SHSMSX103.ccr.corp.intel.com>
 <s5hh8bvb5ba.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527F9D9F@SHSMSX103.ccr.corp.intel.com>
 <s5hbm22psfz.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FAAA5@SHSMSX103.ccr.corp.intel.com>
 <s5h4l7r9shp.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FAE2A@SHSMSX103.ccr.corp.intel.com>
 <s5hbm1z81em.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527FB1A0@SHSMSX103.ccr.corp.intel.com>
 <s5hr2aum6i5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18B01F801D9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 09:46:36 +0100 (CET)
In-Reply-To: <s5hr2aum6i5.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi

>
>In the case of legacy HD-audio, we "fixed" the problem by avoiding the trigger
>of async work at resume, but let it be triggered from runtime resume.  In ASoC
>case, however, it's no option.
>
>Maybe a possible solution in the sound driver side would be to move from
>system suspend/resume to ASoC component suspend/resume.  The runtime
>suspend/resume can be kept as is, and call pm_runtime_force_suspend and
>resume from the component suspend/resume callbacks.  Since the
>component callbacks are certainly processed before DAPM events, this should
>assure the order.

I tried to move display power setting from runtime suspend/resume to 
component suspend/resume. I found there may be another issue:
playback will NOT call component suspend/resume.
This  means we will never have chance to set the display power if
we don't do the S3.

Regards,
Libin

>
>
>thanks,
>
>Takashi
