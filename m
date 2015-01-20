From: Arun Raghavan <arun@accosted.net>
Subject: Re: alsa-lib support for compress offload
Date: Tue, 20 Jan 2015 12:51:16 +0530
Message-ID: <CACuU-+jJL4kbw=j-_sgev+bihf-PSwqjDaPqj-eAwgMfAdTz7g@mail.gmail.com>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
 <54B8F485.7090603@imgtec.com> <54B9413F.805@linux.intel.com>
 <54BD3D7F.6020105@imgtec.com> <54BD8036.5070405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 9999D261A1A
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 08:21:37 +0100 (CET)
Received: by mail-qa0-f52.google.com with SMTP id x12so26924634qac.11
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 23:21:37 -0800 (PST)
In-Reply-To: <54BD8036.5070405@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Qais Yousef <qais.yousef@imgtec.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 20 January 2015 at 03:37, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 1/19/15 11:23 AM, Qais Yousef wrote:
>>
>> On 01/16/2015 04:50 PM, Pierre-Louis Bossart wrote:
>>>
>>>
>>> Since there is no allowed processing/reformatting/reshuffling of
>>> compressed data, all the plugin system needs to be bypassed and you'd
>>> be looking at an alsa-lib API that interfaces directly with the
>>> ioctls, essentially replicating what tinycompress does. I agree it's
>>> not great to have independent packages, the decision to maintain
>>> tinycompress separately was driven by licensing concerns, not
>>> technical ones.
>>> -Pierre
>>>
>>
>> I'm not sure how dual licensing work. Is it ok to base alsa-lib support
>> for compress API on tinycompress then?
>
>
> no idea, and what is the objective really? it's not clear what you are
> trying to achieve and what would be the merits of enhancing alsa-lib with
> compressed audio support?

If the same API can be reused/extended, it'd mean allowing code reuse
and not having to write entirely separate support for compressed
devices in projects that use alsa-lib already. I don't know if that's
actually feasible with the way the ALSA API works, though.

-- Arun
