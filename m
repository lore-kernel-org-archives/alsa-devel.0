From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 00/10] Enable HDA Codec support on Intel
 Platforms (Series2)
Date: Fri, 1 Dec 2017 13:45:54 -0600
Message-ID: <23319967-3571-9e8c-3077-94200bff813f@linux.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hh8tajy3r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C4602670B0
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 20:45:57 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On 12/1/17 8:56 AM, Takashi Iwai wrote:
> On Fri, 01 Dec 2017 10:13:58 +0100,
> Rakesh Ughreja wrote:
>>
>> Many Intel platforms (SKL,KBL) etc. in the market supports enahanced
>> audio capabilities which also includes DSP processing. This patch carry
>> forwads the works that is done in the previous series to enable HD Audio
>> codecs on such platforms.
>>
>> This patch series adds ASoC HDA codec driver for Intel platforms. It is
>> written by reusing the legacy HDA ALSA codec driver. Intention is to
>> maximize the reuse and minimize the changes in the legacy HDA codec driver.
>>
>> I would like to receive feedback before proceeding further on this
>> direction.
> 
> First of all, I appreciate this kind of work finally happening, so
> that ASoC HD-audio can go forward to a wider usage.  However...
> 
> 
>> TODO:
>>
>> - This series is tested on KBL based product (Dell XPS 13).
>> - Basic playback is working with headset and speakers.
>> - Capture operation is not tested.
>> - More platforms and use cases coverage can be added once we have basic
>>    agreement in terms of the overall approach.
> 
> One big thing that is unclear to me is what about the complex I/O
> configuration although we provide only a single machine driver, and
> what happens if the (legacy) codec driver allows the jack retasking.
> I know that nowadays the number of jacks are reduced than before, but
> still there will be desktop boxes with individual front and rear I/O
> jacks.
> 
> 
>> FIXME:
>> - KConfig changes does not look right, but I could not think of any proper
>>    way without making changes into legacy HDA codec driver. So need some
>>    help on this topic.
> 
> And this is another big issue.  As long as you don't allow build both,
> it never flies with distros, and it means no dramatic improvement of
> the situation, either.
> 
> IOW, we have to make the codec driver working on both controller/bus
> implementations, and it essentially means to rewrite the HD-audio
> codec plumbing code.  Currently, it's a kind of half-baked state, and
> we need to cast to unified form.

Before going into codec support, should we first deal with the selection 
of the ASoC/Legacy mode for the controller side of things? Even with 
basic HDMI/iDisp cases, we don't have a clean solution today. When I 
worked on the late Joule platform, there was no fallback mode which 
forced a recompilation depending on BIOS settings.
My understanding is that there is no support for multiple drivers 
registering for the same PCI ID, I believe we'll have to define a 
top-level wrapper which arbitrates internally based on BIOS settings and 
user/distro preferences which mode is selected.

> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
