From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Wed, 17 Jul 2013 08:06:02 +0200
Message-ID: <51E6344A.6030303@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
 <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
 <s5hwqoycu0y.wl%tiwai@suse.de> <51DDD53A.8040502@gmail.com>
 <s5hbo69vf4z.wl%tiwai@suse.de> <51DE7B63.7060708@gmail.com>
 <s5hfvvlcs4o.wl%tiwai@suse.de> <51DE9D18.6010304@gmail.com>
 <51E4FD95.2080500@gmail.com> <s5hsizflykp.wl%tiwai@suse.de>
 <51E4FF18.2050208@gmail.com> <s5hoba2n9ve.wl%tiwai@suse.de>
 <51E59331.5000200@gmail.com> <s5hehaymho4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
 [74.125.82.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 6667E2652B7
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 08:06:04 +0200 (CEST)
Received: by mail-we0-f180.google.com with SMTP id w56so1374989wes.39
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 23:06:04 -0700 (PDT)
In-Reply-To: <s5hehaymho4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Adam Williamson <awilliam@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 16/07/13 21:24, Takashi Iwai wrote:
> At Tue, 16 Jul 2013 20:37:19 +0200,
> Tormen wrote:
>> On 16/07/13 11:15, Takashi Iwai wrote:
>>> It doesn't look like the driver patched properly.
>>> Try to put some printk() in the patched code path to confirm that
>>> you're really testing the patched driver.
>>>
>>>
>>> Takashi
>> I am not 100% sure if it was or not, because I had applied the patch not
>> with "quilt"
>> ... but now I am:
>> I put in some printk()'s and it still shows speaker_outs=0 :(
> This doesn't matter at all from the beginning.
> You see a line "line_outs=1 (type: speaker)" before that.  So, the
> speaker output is assigned as the primary output there.
>
> The problem is, instead, that the primary DAC (thus its selector
> widget) is assigned to the headphone.  Check whether NID 0x0c is
> assigned to "Speaker" volume, not for "Headphone".
> The no_primary_hp flag should have achieved it, but it turned out that
> 5.1 surround setup blocks it.  That's why you got "Headphone" on NID
> 0x0c, and 0x0d/0x0e for the rest speaker and possible surrounds.
>
> The new flag, no_multi_io prevents the creation of 5.1 setup, so that
> the speaker will be assigned to NID 0x0c, together with the
> combination of no_primary_hp.
>
>
>> I was wondering if it's a problem that the speaker_outs=0 is printed way
>> before all the "fill_and_eval_dacs" changes of yours are executed?
>>
>> I attached you my patch so that you can see what output corresponds to
>> what piece of code.
>>
>> alsa-info.sh:
>> http://www.alsa-project.org/db/?f=c644b65a9e25fd1cef5b4b53d6d806d45526e5b2
>>
>> And the complete output of my debug messages:
>>
>> FIRST just loading the modules:
>>       modprobe snd debug=2
>>       modprobe snd_hda_intel
>>
>> [10263.731133] snd_hda_intel 0000:00:1b.0: irq 45 for MSI/MSI-X
>> [10263.747274] Tormen: alc882_fixup_no_primary_hp: AAA
>> [10263.750059] Tormen: alc882_fixup_no_primary_hp: BBB ==> set
>> spec->no_multi_io = 1
> OK, so far, so good.
> Check whether NID 0x0c is assigned to "Speaker".
Yes, it is assigned to "Speaker playback volume", index=0, device=0,
chs=3, dir=1, idx=0, ofs=0

Tormen
