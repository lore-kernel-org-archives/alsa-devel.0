From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH v7] media: Add stk1160 new driver
Date: Mon, 06 Aug 2012 09:42:25 -0300
Message-ID: <501FBBB1.1030802@redhat.com>
References: <1343485133-11090-1-git-send-email-elezegarcia@gmail.com>
 <CALF0-+XEStNrfdqYecKQHr=qkcFPtC5CyDC4DWWy_7+_oA0h=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id F31C2265CB9
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 14:12:44 +0200 (CEST)
In-Reply-To: <CALF0-+XEStNrfdqYecKQHr=qkcFPtC5CyDC4DWWy_7+_oA0h=g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>, alsa-devel@alsa-project.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 06-08-2012 09:28, Ezequiel Garcia escreveu:
> Hi Mauro,
> 
> On Sat, Jul 28, 2012 at 11:18 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>> This driver adds support for stk1160 usb bridge as used in some
>> video/audio usb capture devices.
>> It is a complete rewrite of staging/media/easycap driver and
>> it's expected as a future replacement.
>>
>> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
>> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
>> ---
>>
> 
> Did you take a look at this?

Patchwork didn't get it[1]. Maybe the patch got mangled?
If so, could you please re-post?

[1] http://patchwork.linuxtv.org/project/linux-media/list/?state=*&q=stk1160

Thanks!
Mauro

> 
> Perhaps we can discuss now you're previous comments:
> 
> 1. Place for ac97 code: media or alsa? (see Takashis' comments)
> 2. current_norm usage (see Hans' comments)
> 3. vb2_dqbuf and O_NONBLOCK flag (also see Hans' comments)
> 
> I know it's a big patch*, so there is no need to rush.
> I just wanted to discuss a bit about this before my brain-cache
> flushes completely :-)
> 
> Thanks,
> Ezequiel.
> 
> * Actually it's huge (12k lines) since I'm removing staging/easycap.
> 
