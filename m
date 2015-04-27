From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Tue, 28 Apr 2015 00:17:01 +0200
Message-ID: <553EB55D.4060701@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
 <553E7B34.2080501@gmx.com> <s5h4mo14d72.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B17FA260815
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 00:16:40 +0200 (CEST)
Received: from [192.168.69.6] ([79.44.224.230]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MMTZa-1YebCT4Bnq-008LJq for
 <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 00:16:40 +0200
In-Reply-To: <s5h4mo14d72.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27/04/2015 20:51, Takashi Iwai wrote:
> At Mon, 27 Apr 2015 20:08:52 +0200,
> Gabriele Martino wrote:
>> !!Advanced information - PCI Vendor/Device/Subsystem ID's
>> !!-------------------------------------------------------
>>
>> 00:03.0 0403: 8086:0c0c (rev 06)
>> 	Subsystem: 1028:0685
>> --
>> 00:1b.0 0403: 8086:8c20 (rev 05)
>> 	Subsystem: 1028:0685
> PCI SSID is 1028:0685.
>
>> Codec: Creative CA0132
>> Address: 0
>> AFG Function Id: 0x1 (unsol 1)
>> Vendor Id: 0x11020011
>> Subsystem Id: 0x10280685
> Codec SSID is also 1028:0685.
I couldn't find any occurrence of SND_PCI_QUIRK() to mess up with in
patch_ca0132.c.
I gave a look at patch_realtek.c and got something like:

enum {
    CA0132_FIXUP_CORE3D_EX
}

static const struct hda_fixup ca0132_fixups[] = {
    [CA0132_FIXUP_CORE3D_EX] = {
        .type = HDA_FIXUP_PINS,
        .v.pins = (const struct hda_pintbl[]) {
            { 0x0f, 0x032110f0 }, /* headphones */
            { }
        }
    },
    {}
}

static const struct snd_pci_quirk alc861_fixup_tbl[] = {
    SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", CA0132_FIXUP_CORE3D_EX),
    {}
};

But I don't know how to load this on ca0132.
It there any simple documentation about quirks? I fear this is beyond my
capabilities.

Regards,
Gabriele
