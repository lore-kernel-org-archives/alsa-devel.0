From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH alsa-lib v4 0/4] alsa-lib: ASoC: topology:
 Improve hw_configs
Date: Fri, 20 Apr 2018 19:29:47 +0200
Message-ID: <7a539a66-b2a8-6cf2-20bc-8006cf572703@gmail.com>
References: <20180416182641.30312-1-k.marinushkin@gmail.com>
 <s5ho9iepc7i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF732673D8
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 19:28:53 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id f14-v6so24919247wre.4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 10:28:53 -0700 (PDT)
In-Reply-To: <s5ho9iepc7i.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/20/18 09:29, Takashi Iwai wrote:
> On Mon, 16 Apr 2018 20:26:37 +0200,
> Kirill Marinushkin wrote:
>> Hello Takashi,
>>
>> This patch series waits since 20th of February, because it modifies UAPI headers
>> and should be done in sync with Linux and ALSA. I see that previously there was
>> no clear understanding, how to do this in sync.
>>
>> We discussed with you on 02 Apr 2018, and you suggested the following steps:
>>
>> Step 1. A person from Intel, who knows the topic (Pierre), adds his
>> "Reviewed-by" or "Acked-by" tags
>> Step 2. I clarify with Mark to apply the Linux part (different patch series)
>> Step 3. After that, I clarify with you to apply the ALSA part (this patch
>> series)
>>
>> The step 1 is done. Old patches are reviewed by Pierre, so they have his
>> "Reviewed-by" tag. New patches are suggested by him, and we agreed on the
>> implementation, so they have his "Acked-by" tag.
>>
>> The step 2 is done. Mark applied the corresponding part to his Linux tree [1].
>>
>> Now we are on the step 3. If you don't have anything against this patch series,
>> please apply it to ALSA.
> Ideally, Mark should send the pull request for the uapi changes he
> applied so that they are "fixated" before going further to user-space
> patches.
>
> But this topology change is no intrusive ABI breakage, so I applied
> now as is.

Thank you

>
>
> thanks,
>
> Takashi
