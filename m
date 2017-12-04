From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC 00/10] Enable HDA Codec support on Intel
 Platforms (Series2)
Date: Mon, 4 Dec 2017 10:43:33 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AC5BB1@BGSMSX104.gar.corp.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hh8tajy3r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id CD909267252
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 11:43:40 +0100 (CET)
In-Reply-To: <s5hh8tajy3r.wl-tiwai@suse.de>
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
>Sent: Friday, December 1, 2017 8:26 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul,
>Vinod <vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [RFC 00/10] Enable HDA Codec support on Intel Platforms
>(Series2)
>
>On Fri, 01 Dec 2017 10:13:58 +0100,
>Rakesh Ughreja wrote:
>>
>> Many Intel platforms (SKL,KBL) etc. in the market supports enahanced
>> audio capabilities which also includes DSP processing. This patch carry
>> forwads the works that is done in the previous series to enable HD Audio
>> codecs on such platforms.
>>
>> This patch series adds ASoC HDA codec driver for Intel platforms. It is
>> written by reusing the legacy HDA ALSA codec driver. Intention is to
>> maximize the reuse and minimize the changes in the legacy HDA codec
>driver.
>>
>> I would like to receive feedback before proceeding further on this
>> direction.
>
>First of all, I appreciate this kind of work finally happening, so
>that ASoC HD-audio can go forward to a wider usage.  However...

Thank you for encouragement and prompt feedback.

>
>
>> TODO:
>>
>> - This series is tested on KBL based product (Dell XPS 13).
>> - Basic playback is working with headset and speakers.
>> - Capture operation is not tested.
>> - More platforms and use cases coverage can be added once we have basic
>>   agreement in terms of the overall approach.
>
>One big thing that is unclear to me is what about the complex I/O
>configuration although we provide only a single machine driver, and
>what happens if the (legacy) codec driver allows the jack retasking.
>I know that nowadays the number of jacks are reduced than before, but
>still there will be desktop boxes with individual front and rear I/O
>jacks.

At this point of time, I was thinking that we should have a single machine
Driver with machine specific changes, possibly with quicks or DMIs 
or anything which works.

Single machine driver is for a case when we have one HDA codec 
and one iDisp (HDMI/DP) codec.
When we have other peripherals e.g. SoC DMICs or I2S codecs in addition
to HDA codec, we should have another machine driver.

>
>
>> FIXME:
>> - KConfig changes does not look right, but I could not think of any proper
>>   way without making changes into legacy HDA codec driver. So need some
>>   help on this topic.
>
>And this is another big issue.  As long as you don't allow build both,
>it never flies with distros, and it means no dramatic improvement of
>the situation, either.

Yes, I agree. At the moment I didn't want to do any changes in the
codec driver. Now I got your attention and so we will have a better
solution.

>
>IOW, we have to make the codec driver working on both controller/bus
>implementations, and it essentially means to rewrite the HD-audio
>codec plumbing code.  Currently, it's a kind of half-baked state, and
>we need to cast to unified form.

Yes, exactly, if we make some changes in the legacy codec driver
we can solve this problem. But I didn't want to do it without 
understanding your thinking process. That's why I just kept it as
open in the current series.

Regards,
Rakesh
