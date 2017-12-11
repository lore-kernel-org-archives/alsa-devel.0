From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v2 00/11] Enable HDA Codec support on Intel
 Platforms (Series2)
Date: Mon, 11 Dec 2017 15:10:32 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AD2978@BGSMSX104.gar.corp.intel.com>
References: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hbmj5mrts.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id EA3CF266EDD
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 16:10:38 +0100 (CET)
In-Reply-To: <s5hbmj5mrts.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Monday, December 11, 2017 4:53 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul, Vinod
><vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [RFC v2 00/11] Enable HDA Codec support on Intel Platforms
>(Series2)
>
>On Mon, 11 Dec 2017 11:52:52 +0100,
>Rakesh Ughreja wrote:
>>
>> Many Intel platforms (SKL, KBL) etc. in the market supports enhanced
>> audio capabilities which also includes DSP processing. This patch carry
>> forwards the works that is done in the previous series to enable HD Audio
>> codecs on such platforms.
>>
>> This patch series adds ASoC HDA codec driver for Intel platforms. It is
>> written by reusing the legacy HDA ALSA codec driver. Intention is to
>> maximize the reuse and minimize the changes in the legacy HDA codec driver.
>>
>> I would like to receive feedback before proceeding further on this
>> direction.
>>
>> INFO:
>> - This series is tested on KBL based product (Dell XPS 13).
>> - Basic playback is working with headset and speakers.
>> - HDMI playback is working.
>> - Capture operation is not tested.
>> - More platforms and use cases coverage can be added once we have basic
>>   agreement in terms of the overall approach.
>>
>> Changes in v2:
>> - Using Topology framework to create DAIs and DAI Links
>> - Moved most commonly used functions into a separate file for machine driver
>> - Implemented separate Realtek ASoC HDA Driver driver for Realtek HDA
>codecs.
>>   It is just a driver registration wrapper which reuses the legacy HDA codec
>>   driver. This allows the removes the limitation that was present in v1.
>> - Implemented the review feedback.
>
>Looking through the patchset quickly, I have a mixed feeling with it.
>I see you're trying to get it working with minimal changes, which is

Thanks once again for the quick feedback.

>good in one side.  OTOH, it is unacceptably messy, in special, because
>the device creation and registration phases are mixed up.

I am not sure if I understand this fully. "Device creation and registration
phases are mixed up". If you can explain bit more, I can try to improve
it.

>
>And exporting each codec table doesn't look nice.  We need to find a
>better way...

Do you think accessing the codec table via some EXPORT function
is a better way ?

>
>
>thanks,
>
>Takashi
