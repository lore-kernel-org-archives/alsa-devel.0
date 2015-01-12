From: Thanos Kyritsis <djart@linux.gr>
Subject: Re: Possible regression in patch_realtek.c
Date: Mon, 12 Jan 2015 21:17:46 +0200
Message-ID: <CAKovSWXLd9itNKYba-+81BU0e5WB1C-8w0LOYwyxE0hCFJcu-w@mail.gmail.com>
References: <CAKovSWXeXsCoCVOwe_srtKYLW6yPJfc_MihTSRGNT4iWS=e1yw@mail.gmail.com>
 <54B36AAA.3020905@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC48261298
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 20:17:47 +0100 (CET)
Received: by mail-oi0-f45.google.com with SMTP id x69so21984539oia.4
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 11:17:46 -0800 (PST)
In-Reply-To: <54B36AAA.3020905@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 12, 2015 at 8:33 AM, David Henningsson
<david.henningsson@canonical.com> wrote:
>
>
> On 2015-01-11 22:11, Thanos Kyritsis wrote:
>>
>> Hello,
>>
>> I hope it's ok to e-mail you directly instead of going through an
>> official bug tracker, sorry in advance otherwise.
>
>
> Ok. I have added alsa-devel to CC.
>
>
>> I'd like your opinion on a patch of yours that dates a year back:
>>
>>
>> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/sound/pci/hda/patch_realtek.c?id=b2c53e206967d01fd4fb6dd525f89ae738beb2e6
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1248116
>>
>> This patch has a negative impact for my hardware. I've completely lost
>> the kernel's front panel jack auto-mute functionality.
>>
>> In detail: my motherboard is Gigabyte Z68AP-D3, utilizing ALC889
>> chipset (http://www.gigabyte.com/products/product-page.aspx?pid=3897)
>> with PCI id: 0x1458, 0xa002.
>>
>> Without this patch (that is kernel up to 3.13.x), all is OK, when I
>> plug headphones via the front panel jack, the kernel auto-mutes the
>> speaker-phone jack.
>> With the patch (that is kernel 3.14.x and all later versions),
>> auto-mute does not work. Plugging headphones results on sound getting
>> through both jacks simultaneously.
>> I can, of course, control the volume/mute of these two jacks
>> independently via CLI alsamixer, but I think this is a regression. Do
>> you agree ? I'm noticing that the patch's purpose was to fix a
>> slightly different problem, though.
>> Is it possible to satisfy both requirements for both motherboards ?
>>
>> Can I do something to further help ? If you'd like me to comment on
>> bug #1248116, that will be no problem of course.
>>
>> Thank you in advance for your help and for your contribution towards a
>> better kernel and distros :-)
>
>
> Okay. So the real question is if there's a way we can tell the working and
> the faulty ones apart. Until we have found such a way, I'll be hesitant to
> revert the patch.
>
> Here's alsa-info for a faulty one:
> http://www.alsa-project.org/db/?f=435c404946687b445f6c60da5edc5c3f083bc1da
>
> Both Codec SSID and PCI SSID are 1458:a002 on that machine, codec vendor ID
> is 10ec:0899 - maybe we should only apply this quirk for certain codec
> vendor IDs, then?

Thanks for your help,

for the record, my alsa-info is:
http://www.alsa-project.org/db/?f=f5ae6038b7e27a1c1ab9c137f1ec64a806491145

SSID: 1458:a002
vendor ID: 10ec:0889

> Anyhow, you can bring back jack detection for yourself (as a workaround) by
> reconfiguring the codec. This is easiest done through hda-jack-retask
> (available in the alsa-tools repository). In hda-jack-retask click "advanced
> override", then make sure pin 0x1b has jack detect available.

Gosh, I hadn't realised it was so easy.

I did recompile my kernel with the quirk reverted, but obviously the
re-tasking setup is much more convenient and maintainable :-)

Keep up the good work!

>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
>
