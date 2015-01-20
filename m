From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] fm801: move to pcim_* and devm_* functions
Date: Tue, 20 Jan 2015 15:51:05 +0200
Message-ID: <CAHp75VdgNzx0AjvfcBrY3eKQTA8=DGEkiQGYRBOFWEcTtDpWSw@mail.gmail.com>
References: <1420587617-28521-1-git-send-email-andy.shevchenko@gmail.com>
 <s5h8uhfdq0g.wl-tiwai@suse.de>
 <CAHp75Veya0h7E_dDCXEsUvqFp+=LCk_4PDbV_REUMc1_Ro9W=Q@mail.gmail.com>
 <s5hoaqaygnt.wl-tiwai@suse.de>
 <CAHp75Ve-KigYCKP0oCz6E6ZmgTKf7+0Y5UtJjPUWyZoK5JBjMQ@mail.gmail.com>
 <s5hlhleybt7.wl-tiwai@suse.de>
 <CAHp75VdR3nU6K7abpzfUPZrG45R9j0YRYeUV8E4YBAq7Qi3sgA@mail.gmail.com>
 <s5hh9w2yawo.wl-tiwai@suse.de>
 <CAHp75Ve6+Gb5Cm+Xz04kaL6_jScQDAbH02QTA5Abb2mOyi5s1w@mail.gmail.com>
 <s5hd26qyacy.wl-tiwai@suse.de> <s5ha91uy9q8.wl-tiwai@suse.de>
 <CAHp75VcPM+Pz0+fTM7BOHJu1xohrMYvaPmrk2jyX8xkovviiRw@mail.gmail.com>
 <s5hzj9uwsa0.wl-tiwai@suse.de> <s5htwzlwrm8.wl-tiwai@suse.de>
 <CAHp75VcgywgTW0maJsxQv9gd=40Za-AE8uYkwaxehD42p4+=JQ@mail.gmail.com>
 <s5hmw5dwokt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com
 [209.85.160.174])
 by alsa0.perex.cz (Postfix) with ESMTP id C52042604D0
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 14:51:06 +0100 (CET)
Received: by mail-yk0-f174.google.com with SMTP id 131so4578753ykp.5
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 05:51:06 -0800 (PST)
In-Reply-To: <s5hmw5dwokt.wl-tiwai@suse.de>
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

On Tue, Jan 20, 2015 at 3:48 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 20 Jan 2015 15:46:13 +0200,
> Andy Shevchenko wrote:
>>
>> On Tue, Jan 20, 2015 at 2:42 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Wed, 07 Jan 2015 15:59:35 +0100,
>> > Takashi Iwai wrote:
>>
>> []
>>
>>
>> > I recalled finally why I didn't want this sort of changes.  Namely,
>> > devm_request_irq() can't be used safely for the shared PCI
>> > interrupts.
>> >
>> > There is a small open window between the driver's remove call
>> > (i.e. card's private_free or device free calls) and the call of
>> > devres_release_all().  The registered irq handler still remains during
>> > this window.  When an irq is triggered from another shared device
>> > during this, it goes to the remaining irq handler and accesses the
>> > hardware unexpectedly.  In the case of snd_fm801_interrupt(), it's not
>> > too bad, though.
>>
>> Don't we have interrupts disabled on ->remove() stage?
>
> It's a shared irq, so it doesn't help even if your device disables the
> irq.  The other device can trigger the irq line at any time.

Got it. We can call devm_free_irq() explicitly in the ->remove() then.

-- 
With Best Regards,
Andy Shevchenko
