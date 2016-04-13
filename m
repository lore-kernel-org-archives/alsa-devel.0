From: Hsin-yu Chao <hychao@chromium.org>
Subject: Re: [PATCH v4] ucm: add cset-tlv
Date: Wed, 13 Apr 2016 18:15:45 +0800
Message-ID: <CANyK0S=Fx0JLT-udCSWr6z0NGk=sQEvEt=KQNz5x7bSks=m_FA@mail.gmail.com>
References: <1460528817-25598-1-git-send-email-hychao@chromium.org>
 <20160413085740.GK2274@localhost> <s5hvb3l6d39.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AB7802604D6
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 12:15:46 +0200 (CEST)
Received: by mail-oi0-f43.google.com with SMTP id y204so57397429oie.3
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 03:15:46 -0700 (PDT)
In-Reply-To: <s5hvb3l6d39.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 13, 2016 at 6:02 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 13 Apr 2016 10:57:40 +0200,
> Vinod Koul wrote:
>>
>> On Wed, Apr 13, 2016 at 02:26:57PM +0800, Hsin-Yu Chao wrote:
>> > +   sz_read = read(fd, *res, sz);
>> > +   if (sz_read < 0 || (size_t)sz_read != sz) {
>> > +           err = -EIO;
>> > +           free(*res);
>> > +           *res = NULL;
>> > +   }
>> > +   /* Check if the tlv file specifies valid size. */
>> > +   tlv = (unsigned int *)(*res);
>> > +   if (tlv[1] + 2 * sizeof(unsigned int) != sz) {
>>
>> why not use snd_ctl_tlv(), my assumption is that you are expecting a type,
>> length and values in the buffer
>
> Actually this implicitly checks the endianess of the read data.
>
>
> Takashi
Thanks for this useful info!
I read the comment regarding the length of this snd_ctl_tlv struct,
saying that "in bytes aligned to 4", but I don't see anywhere in the
tlv_write path asserts this.
Should I also add a check here that files size is a multiple of 4?

Hsin-yu
