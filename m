From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Possible regression in patch_realtek.c
Date: Mon, 12 Jan 2015 07:33:14 +0100
Message-ID: <54B36AAA.3020905@canonical.com>
References: <CAKovSWXeXsCoCVOwe_srtKYLW6yPJfc_MihTSRGNT4iWS=e1yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A34682605E4
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 07:33:09 +0100 (CET)
In-Reply-To: <CAKovSWXeXsCoCVOwe_srtKYLW6yPJfc_MihTSRGNT4iWS=e1yw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thanos Kyritsis <djart@linux.gr>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2015-01-11 22:11, Thanos Kyritsis wrote:
> Hello,
>
> I hope it's ok to e-mail you directly instead of going through an
> official bug tracker, sorry in advance otherwise.

Ok. I have added alsa-devel to CC.

> I'd like your opinion on a patch of yours that dates a year back:
>
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/sound/pci/hda/patch_realtek.c?id=b2c53e206967d01fd4fb6dd525f89ae738beb2e6
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1248116
>
> This patch has a negative impact for my hardware. I've completely lost
> the kernel's front panel jack auto-mute functionality.
>
> In detail: my motherboard is Gigabyte Z68AP-D3, utilizing ALC889
> chipset (http://www.gigabyte.com/products/product-page.aspx?pid=3897)
> with PCI id: 0x1458, 0xa002.
>
> Without this patch (that is kernel up to 3.13.x), all is OK, when I
> plug headphones via the front panel jack, the kernel auto-mutes the
> speaker-phone jack.
> With the patch (that is kernel 3.14.x and all later versions),
> auto-mute does not work. Plugging headphones results on sound getting
> through both jacks simultaneously.
> I can, of course, control the volume/mute of these two jacks
> independently via CLI alsamixer, but I think this is a regression. Do
> you agree ? I'm noticing that the patch's purpose was to fix a
> slightly different problem, though.
> Is it possible to satisfy both requirements for both motherboards ?
>
> Can I do something to further help ? If you'd like me to comment on
> bug #1248116, that will be no problem of course.
>
> Thank you in advance for your help and for your contribution towards a
> better kernel and distros :-)

Okay. So the real question is if there's a way we can tell the working 
and the faulty ones apart. Until we have found such a way, I'll be 
hesitant to revert the patch.

Here's alsa-info for a faulty one: 
http://www.alsa-project.org/db/?f=435c404946687b445f6c60da5edc5c3f083bc1da

Both Codec SSID and PCI SSID are 1458:a002 on that machine, codec vendor 
ID is 10ec:0899 - maybe we should only apply this quirk for certain 
codec vendor IDs, then?

Anyhow, you can bring back jack detection for yourself (as a workaround) 
by reconfiguring the codec. This is easiest done through hda-jack-retask 
(available in the alsa-tools repository). In hda-jack-retask click 
"advanced override", then make sure pin 0x1b has jack detect available.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
