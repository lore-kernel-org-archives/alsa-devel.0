From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/4] ASoC: firmware: Add support for FW
 based kcontrols.
Date: Thu, 29 Nov 2012 17:39:38 +0000
Message-ID: <50B79DDA.4090406@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <s5hsj85qw1n.wl%tiwai@suse.de> <50B75032.2030502@ti.com>
 <s5h8v9kphi9.wl%tiwai@suse.de> <50B78498.40406@ti.com>
 <50B786D5.1010003@ti.com> <s5hmwy0nwgl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id A44892651D5
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 18:39:42 +0100 (CET)
In-Reply-To: <s5hmwy0nwgl.wl%tiwai@suse.de>
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

On 29/11/12 17:35, Takashi Iwai wrote:
> At Thu, 29 Nov 2012 16:01:25 +0000,
> Liam Girdwood wrote:
>>
>> On 29/11/12 15:51, Liam Girdwood wrote:

>> In fact adding the old include path at the end works, but is probably an
>> interim fix until the uapi work is completed.
>>
>>    gcc uapi-test.c -I ~/source/linux.git/include/uapi -D__EXPORTED_HEADERS__ -I
>> /home/lrg/source/linux.git/include/
>
> Well, actually the content of uapi/sound/asound.h won't be changed.
>

Sorry, I was meaning the other uapi includes here. Like compiler.h

> Looking at this issue more closely, I found that glibc package also
> provides the copy of linux kernel headers as well, but they are
> stripped.  And the stripped form is almost what we have now in
> include/uapi/*.  The difference is that all ifdef KERNEL will be
> stripped, thus the check of non-kernel access in linux/types.h is also
> stripped.
>
> That being said, once when kernel uapi things get merged to glibc,
> everything will be fine....  Well, I hope.
>

Hehe, I hope too.

Thanks

Liam
