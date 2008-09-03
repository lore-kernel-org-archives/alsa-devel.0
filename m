From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] ALSA: add dummy function to support
	shared mmap in nommu Blackfin arch (v3)
Date: Wed, 3 Sep 2008 18:07:03 +0800
Message-ID: <386072610809030307q30ccdbacv2fb4d88db3242a2d@mail.gmail.com>
References: <1220431134-7797-1-git-send-email-cooloney@kernel.org>
	<s5hd4jlpol8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DC61243EC
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 12:07:05 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so356609ywk.2
	for <alsa-devel@alsa-project.org>; Wed, 03 Sep 2008 03:07:03 -0700 (PDT)
In-Reply-To: <s5hd4jlpol8.wl%tiwai@suse.de>
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
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 3, 2008 at 5:26 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed,  3 Sep 2008 16:38:54 +0800,
> Bryan Wu wrote:
>>
>> From: Cliff Cai <cliff.cai@analog.com>
>>
>> v2-v3:
>>  - when it is mmu arch, we define the dummy function to NULL
>>
>> v1-v2:
>>  - only adding this dummy function in nommu arch
>>
>> Cc: Mike Frysinger <vapier.adi@gmail.com>
>> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>
> Thanks, applied now with a slight fix of coding style.
>
>

Thanks a lot. But I found the author of this patch was me not Cliff in
the sound-2.6.git.
Could you please change the author to Cliff, cause he is the original bug fixer.

-Bryan
