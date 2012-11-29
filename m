From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/4] ASoC: firmware: Add support for FW
 based kcontrols.
Date: Thu, 29 Nov 2012 15:51:52 +0000
Message-ID: <50B78498.40406@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <s5hsj85qw1n.wl%tiwai@suse.de> <50B75032.2030502@ti.com>
 <s5h8v9kphi9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id D212E2650D0
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:51:56 +0100 (CET)
In-Reply-To: <s5h8v9kphi9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 29/11/12 15:15, Takashi Iwai wrote:
> At Thu, 29 Nov 2012 12:08:18 +0000,
> Liam Girdwood wrote:
>>
>> On 19/11/12 18:36, Takashi Iwai wrote:

>>>
>>> For the sound stuff, the patch is queued for 3.8 in for-next branch.
>>> Please rebase on it.
>>
>> Done, but I'm now seeing some type conflict errors when building my userspace
>> tools (i.e. after moving to include uapi/sound/asound.h from sound/asound.h).
>>
>> e.g.
>>
>> #include <stdlib.h>
>> #include <uapi/sound/asound.h>
>>
>> int main ()
>> {
>> }
>>
>> gives :-
>>
>> gcc uapi-test.c -I ~/source/linux.git/include
>
> Pass -I ~/source/linux.git/include/uapi
>
> then
>
> #include <sound/asound.h>
>

Ah, I did initially try this before emailing :-

gcc uapi-test.c -I ~/source/linux.git/include/uapi
In file included from /home/lrg/source/linux.git/include/uapi/sound/asound.h:26:0,
                  from uapi-test.c:2:
/home/lrg/source/linux.git/include/uapi/linux/types.h:9:2: warning: #warning 
"Attempt to use kernel headers from user space, see 
http://kernelnewbies.org/KernelHeaders" [-Wcpp]
In file included from 
/home/lrg/source/linux.git/include/uapi/linux/posix_types.h:4:0,
                  from /home/lrg/source/linux.git/include/uapi/linux/types.h:13,
                  from /home/lrg/source/linux.git/include/uapi/sound/asound.h:26,
                  from uapi-test.c:2:
/home/lrg/source/linux.git/include/uapi/linux/stddef.h:1:28: fatal error: 
linux/compiler.h: No such file or directory

adding -D__EXPORTED_HEADERS__ to gcc command line gets rid of the warning, but 
it seems we are missing compiler.h (even in todays linux-next).

If this works for you, it may be an issue at my end.

Thanks

Liam
