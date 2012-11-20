From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/4] ASoC: dapm: Standardise ASoC DAPM
	messages
Date: Tue, 20 Nov 2012 11:43:04 +0000
Message-ID: <50AB6CC8.6080704@ti.com>
References: <1353335955-5249-1-git-send-email-lrg@ti.com>
 <20121120003108.GB4483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 85E9B265343
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 12:43:10 +0100 (CET)
In-Reply-To: <20121120003108.GB4483@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20/11/12 00:31, Mark Brown wrote:
> On Mon, Nov 19, 2012 at 02:39:12PM +0000, Liam Girdwood wrote:
>> Currently ASoC has a mixture of message prefixes e.g. "ASoC", "asoc"
>> or none and message types e.g. pr_debug or dev_dbg.
>>
>> Make sure all ASoC core messages use the same "ASoC" prefix and
>> convert any component device specific messages to use dev_dbg
>> instead of pr_debug.
>
> So, the reason we used to have the prefixes was that we didn't have dev_
> versions of the macros - I'd been going the other way and stripping out
> the prefixes for ASoC: because they seemed noisy and out of line with
> most other subsystems which either use dev_ or put a prefix in but not
> both.
>

Ok, my thinking here was that it was quite useful when debugging the new FW 
code. e.g. I knew if it was a core or driver related issue.

However, I'm easy on it going completely and I'll redo in favour of removing 
the pr_ and printk for device specific errors.

LLiam
