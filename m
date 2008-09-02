From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 4/4] ALSA: add dummy function to support
	shared mmap in nommu Blackfin arch
Date: Tue, 2 Sep 2008 17:59:40 +0800
Message-ID: <386072610809020259hd61d8barec55e453579ade1a@mail.gmail.com>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-5-git-send-email-cooloney@kernel.org>
	<s5h4p559umn.wl%tiwai@suse.de>
	<0F1B54C89D5F954D8535DB252AF412FA029D5EC2@chinexm1.ad.analog.com>
	<s5hmyiqkhpr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C4AFB1037FB
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 11:59:41 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so1377145yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2008 02:59:40 -0700 (PDT)
In-Reply-To: <s5hmyiqkhpr.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 2, 2008 at 5:41 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 2 Sep 2008 11:16:37 +0800,
> Cai, Cliff wrote:
>>
>>
>> > @@ -3419,5 +3426,6 @@ const struct file_operations snd_pcm_f_ops[2] =
>> {
>> >             .compat_ioctl =         snd_pcm_ioctl_compat,
>> >             .mmap =                 snd_pcm_mmap,
>> >             .fasync =               snd_pcm_fasync,
>> > +           .get_unmapped_area =    dummy_get_unmapped_area,
>> >     }
>> >  };
>>
>> >I don't think adding this dummy get_unmapped_area unconditionally for
>> every driver is good.  This overrides the default
>> >mm->get_unmaped_area.
>> But without this dummy function,shared mmap on nommu arch would
>> fail,refer to validate_mmap_request() in mm/nommu.c.
>
> Yes, I know it's needed for nommu.  That's why I wrote
> "unconditionally" in the above.
>
>> May be we can add a kernel config item to include or not include this
>> function depending on non-mmu or mmu arch.
>
> Checking CONFIG_MMU may suffice?
>

Right, I post a v2 patch including this checking.

Thanks
-Bryan
