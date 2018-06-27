From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 00/13] Enable HDA Codec support on Intel
 Platforms
Date: Wed, 27 Jun 2018 16:04:57 -0700
Message-ID: <c69dbe7e-5b74-334d-abce-cd81da205fe2@linux.intel.com>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
 <s5h603136ni.wl-tiwai@suse.de>
 <1c445079-c5c6-8c70-ebcf-f1eabb7616e8@linux.intel.com>
 <s5hy3fuk6nw.wl-tiwai@suse.de> <s5ha7rhbc8k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 195412679A6
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 01:05:05 +0200 (CEST)
In-Reply-To: <s5ha7rhbc8k.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, rakesh.a.ughreja@intel.com, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/26/18 12:04 PM, Takashi Iwai wrote:
> On Mon, 04 Jun 2018 15:44:35 +0200,
> Takashi Iwai wrote:
>>
>> On Mon, 04 Jun 2018 15:27:18 +0200,
>> Pierre-Louis Bossart wrote:
>>>
>>> On 6/2/18 4:00 AM, Takashi Iwai wrote:
>>>> ... and these patches are touching both ASoC and HD-audio legacy, we'd
>>>> need the coordinated patch application.  That is, we'd need a topic
>>>> branch that will be merged to both Mark and my trees.  We can branch it
>>>> off after 4.18-rc1 release, for example, as a clean start point.
>>>
>>> ... And I am not sure I understand the topic branch merged in both
>>> directions. If we want to perform a non-regression with the first
>>> parts (without ASoC additions) then we may need to create a partial
>>> topic branch, then add the rest later?
>>
>> The topic branch is needed so that it can be merged in my tree and
>> Mark's tree directly and cleanly.  It has nothing to do with 'no
>> regression' rule, but rather only about the git merge mechanism.
>>
>> Usually a topic branch is created from a clean stub point, e.g.
>> Linus 4.18-rc1 release.  Then I'd merge your patches starting at this
>> point, so that these can be merged via git-merge to both my tree and
>> Mark's tree at the same time.  At later point, I'll merge whole Mark's
>> tree for 4.19 merge window.  And the merge will work cleanly since
>> these common changes have been already merged in my tree.
>>
>> The split of patches are helpful to ease reviews in general.  For this
>> kind of big mixture changes, some staged merges are preferred.  That
>> is, at first merge individual fixes, and merge preliminary / cleanup
>> patches that don't break any functionality.  These can be merged and
>> tested quickly, per nature.
>>
>> Then it follows the rest, the main change; this will need more careful
>> reviews and tests, and it'd be often requested to rewrite multiple
>> times.  When the preliminary patches have been already merged, you
>> don't have to resend the whole series again, and this will make the
>> mail thread a lot easer to read through.
> 
> Now I've put a few patches from the series into topic/hda-core-intel
> branch of sound git tree: namely,
> 
>     ALSA: hdac: ext: add wait for codec to respond after link reset
>     ALSA: hdac: Remove usage of struct hdac_ext_device and use hdac_device instead
>     ALSA: hdac: Remove usage of struct hdac_ext_bus and use hdac_bus instead
>     ALSA: hdac: Remove usage of struct hdac_ext_driver, use hdac_driver instead
>     ALSA: hda: split snd_hda_codec_new function
>     ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init
>     ALSA: hdac: add extended ops in the hdac_bus
> 
> corresponds to the patch 12 as a fix at first, followed by patches 1,
> 2, 3 as hdac_ext_* cleanup, and patches 8, 9, 10 for preparation of
> the further move.  All these should be only cleanups / refactoring
> (and one fix), hence no visible functional changes.
> 
> The branch isn't merged to for-next yet.  And it's cleanly based on
> v4.18-rc1 so that Mark can pull into his tree.  As far as I've
> checked, the merge can be done smoothly to the current asoc tree,
> too.
> 
> So, guys, please check / review whether these are all OK for now.
> 
> The rest are rather ASoC-intensive part and needs more careful
> reviews.

Great, thank you, I was about to resend a smaller series but you beat me 
to it. Will double-check the branch.
