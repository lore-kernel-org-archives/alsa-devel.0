From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/7] ALSA: HD-audio display power fixes
Date: Thu, 13 Dec 2018 08:37:10 -0600
Message-ID: <aa594440-2d51-cced-46dd-1ad975c259fe@linux.intel.com>
References: <20181211135341.11383-1-tiwai@suse.de>
 <s5hmup9u9fu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7032826789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 15:37:12 +0100 (CET)
In-Reply-To: <s5hmup9u9fu.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/13/18 2:17 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 14:53:34 +0100,
> Takashi Iwai wrote:
>> Hi,
>>
>> this patch a revised patchset for fixing possible HD-audio display
>> power unbalance.
>> Basically the "fix" is done by refactoring the whole relevant code.
>> It starts from the Intel HD-audio runtime PM refactoring, followed
>> by the display PM API change, and lots of code cleanups.
>>
>> Since it changes the display power API function, it hits both legacy
>> and ASoC drivers.
>>
>> The patches are kept in topic/hda-pm-refactor branch of my sound git
>> tree.  This will be an immutable branch once when merged to for-next,
>> so that it can be merged to ASoC tree if any conflicting change needs
>> to be applied.
> Now I merged the patchset to for-next branch, and I'll keep the
> topic/hda-pm-refactor immutable.
>
> Mark, if you happen to apply Intel ASoC patches that conflict with the
> recent changes, feel free to merge that branch into yours.
>
The next batch of SOF patches will depend on these changes, so having 
Takashi's topic/hda-pm-refactor merged into Mark's for-next branch would 
help. Thanks!
