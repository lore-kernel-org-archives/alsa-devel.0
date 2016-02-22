From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/1] ALSA: hda - Use acpi_dev_present()
Date: Mon, 22 Feb 2016 08:18:15 -0600
Message-ID: <56CB18A7.3000207@linux.intel.com>
References: <cover.1452790983.git.lukas@wunner.de>
 <s5hmvs7l6ys.wl-tiwai@suse.de> <20160220224724.GA19638@wunner.de>
 <s5h1t86xyt1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F74260673
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 15:18:49 +0100 (CET)
In-Reply-To: <s5h1t86xyt1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Lukas Wunner <lukas@wunner.de>
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/21/2016 02:17 AM, Takashi Iwai wrote:
> On Sat, 20 Feb 2016 23:47:24 +0100,
> Lukas Wunner wrote:
>>
>> Hi Takashi,
>>
>> On Fri, Jan 15, 2016 at 06:58:19AM +0100, Takashi Iwai wrote:
>>> On Thu, 14 Jan 2016 22:05:03 +0100, Lukas Wunner wrote:
>>>> Hi Takashi,
>>>>
>>>> the acpi_dev_present() API has now landed in Linus' tree.
>>>> Thus, after Linus' tree gets merged back into yours,
>>>> it would be possible to use the API in the Thinkpad hda drivers
>>>> as per the following patch.
>>>>
>>>> I've also pushed it to GitHub in case anyone prefers
>>>> perusing it in a browser:
>>>> https://github.com/l1k/linux/commit/a1473d726b57eaf97c4de8812c5967603068e261
>>>>
>>>> An ack for this patch was kindly provided by Hui Wang with:
>>>> Message-ID: <5653C291.9090607@canonical.com>
>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100962.html
>>>
>>> A back merge is ugly and I'd like to avoid it.
>>> This is no urgent fix but rather a cleanup, right?  If so, I'd
>>> postpone this to 4.6.
>>
>> I've noticed this patch isn't in one of your trees, so it looks
>> like it's not queued for 4.6 yet. If there are objections against
>> it please let me know. If there aren't, I'd like to gently remind
>> of the patch's existence.
> 
> Sorry for the delay, it's merged now.
 
heads-up: we've identified that the ACPI subsystem reports devices as present even if they are explicitly disabled in the BIOS _STA routine. we have a couple of WIP patches to work around this issue that is blocking for some CHT-T devices, and they pretty much amount to a revert and addition of an explicit presence test
-Pierre
