From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] ALSA: add dummy function to support
	shared mmap in nommu Blackfin arch (v2)
Date: Wed, 3 Sep 2008 16:35:32 +0800
Message-ID: <386072610809030135y7d8762dg713897101b3242bd@mail.gmail.com>
References: <1220349522-17995-1-git-send-email-cooloney@kernel.org>
	<8bd0f97a0809020637n2c7e29bexe87bd3dca50cee88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f24.google.com (mail-gx0-f24.google.com
	[209.85.217.24]) by alsa0.perex.cz (Postfix) with ESMTP id E0C90243F0
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 10:35:33 +0200 (CEST)
Received: by gxk5 with SMTP id 5so2414397gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 03 Sep 2008 01:35:32 -0700 (PDT)
In-Reply-To: <8bd0f97a0809020637n2c7e29bexe87bd3dca50cee88@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 2, 2008 at 9:37 PM, Mike Frysinger <vapier.adi@gmail.com> wrote:
> On Tue, Sep 2, 2008 at 5:58 AM, Bryan Wu wrote:
>> From: Cliff Cai <cliff.cai@analog.com>
>>
>> v1-v2:
>>  - only adding this dummy function in nommu arch
>>
>> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>> ---
>>  sound/core/pcm_native.c |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index c49b9d9..1e88cde 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> @@ -3391,6 +3391,14 @@ out:
>>  }
>>  #endif /* CONFIG_SND_SUPPORT_OLD_API */
>>
>> +#ifndef CONFIG_MMU
>> +unsigned long dummy_get_unmapped_area(struct file *file, unsigned long addr,
>> +                                     unsigned long len, unsigned long pgoff, unsigned long flags)
>> +{
>> +       return 0;
>> +}
>> +#endif
>
> if you had:
> #else
> # define dummy_get_unmapped_area NULL
> #endif
> then you could avoid #ifdef in the rest of the file ...
> -mike
>

Right, I will refresh this patch.

-Bryan
