From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] pcm: fix wrong document references to PCM
 APIs which perform direct memory access with frame copying
Date: Tue, 13 Dec 2016 08:06:56 +0900
Message-ID: <acda020e-47d2-f1a2-603e-a16999355324@sakamocchi.jp>
References: <20161211113138.32468-1-o-takashi@sakamocchi.jp>
 <s5hy3zkzv63.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 7C181266C96
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 00:07:02 +0100 (CET)
In-Reply-To: <s5hy3zkzv63.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 13 2016 06:36, Takashi Iwai wrote:
> On Sun, 11 Dec 2016 12:31:38 +0100,
> Takashi Sakamoto wrote:
>>
>> In a design of ALSA PCM interface, for PCM frame transmission to/from
>> kernel space, applications can select from two options; direct memory access
>> or ioctl(2). Available options are decided depending on device capacity and
>> machine architecture. Applications can get available options by the first
>> entry of 'struct snd_pcm_hw_params.masks'.
>>
>> When the mask includes 'SNDRV_PCM_ACCESS_MMAP_xxx', applications can use
>> direct memory access. For this use case, userspace library has two types
>> of PCM API. One is to expose a pointer over the memory to start
>> reading/writing PCM frames. Another is to copy PCM frames between the
>> memory and a given buffer.
>>
>> Current documentation includes wrong references to these APIs to describe
>> their advantages/disadvantages. This confuses application developers
>> because the references indicate PCM APIs to execute ioctl(2) operation to
>> read/write PCM frames.
>>
>> This commit fixes the bug.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> Applied, thanks.

Thanks.

Additionally, I'm pleased if you apply below patches to fix some 
compiler warnings which topology features recently got. I guess Intel 
developers are under their holidays.

[alsa-devel] [PATCH][alsa-lib] topology: fix sign-compare warning 
introduced to set_link_hw_config() and tplg_add_link_object()
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115245.html

[alsa-devel] [PATCH][alsa-lib] topology: fix unused-variable warnings 
introduced to build_link()
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115246.html

[alsa-devel] [PATCH][alsa-lib] topology: fix unused-const-variable warning
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115247.html


Regards

Takashi Sakamoto
